## This script takes Landsat data and performs automated classifications of glaciated areas and lake areas. 
## Wrapper to two Matlab scripts (Glacier_Extraction, Late_Extraction)
## Created by Taylor Smith, June 2014

#Import Modules
print "Loading modules..."
import arcpy, sys, os, string, csv, numpy, glob
import datetime, time, subprocess, math, traceback 
#All modules are open source with the exception of ArcPy

arcpy.env.overwriteOutput = True #Set the script to be able to overwrite files
arcpy.CheckOutExtension("Spatial") #Access Spatial Analyst extension

basepath = "" # This is the base directory path. All other file paths are relative to this
config_file = "" #Configuration file
Path_Raw = basepath + #PATH TO RAW DATA (Landsat images each in seperate directory)
Path_Glac_Ext = basepath + #PATH TO OUTPUT GLACIAL EXTENT SHAPEFILES TO
Path_Lake_Ext = basepath + #PATH TO OUTPUT LAKE EXTENTS TO
Path_SRTM = basepath + #PATH TO SAVE RESAMPLED DEMS INTO
TMP = basepath + #WORKING DIRECTORY WHERE TEMPORARY DATASETS WILL BE SAVED
Procdir = basepath + #WORDKING DIRECTORY FOR PROCFILES FOR INDIVIDUAL SCENES

def conf_reader(config_file):
    """Reads configuration files and returns a list of strings"""
    
    f = open(config_file, 'r')
    conf_list = []
    for line in f:
        raw = line.split('#')
        data = raw[0]
        new = data.replace('\r\n', '')
        new_2 = new.replace(' ', '')
        conf_list.append(new_2)
    f.close()
    return conf_list

if os.path.exists(config_file): 
    #Read config file to set up input datasets
    conf = conf_reader(config_file)
    Asia_SRTM = conf[0] #SRTM (WGS84)
    Asia_Slope = conf[1] #Pre-calculated Slope map from SRTM, or NULL to calc during script
    Rivers = conf[2] #Pre-calculated Rivers with 200m buffer (Tif Format)
    TraceLakes = conf[3] #Training Lake TIFF FILE. SHP->TIFF Conversion is highly error prone
    TraceDebris = conf[4] #Training Debris TIFF FILE. SHP->TIFF Conversion is highly error prone
    Velocitydir = conf[5] # Points to directory of Velocities for each zone (choose by path/row, date)
    prjdir = conf[6] #Projection directory 
    
def LandsatMetadataRead(filename): 
    """Parses the metadata associated with Landsat images (_MTL.txt). Assumes that the metadata files are stored in the same directory
    as the image files (default). It then creates slope and hillshade images from a clipped DEM (SRTM by Default)."""

    metafile = Path_Raw + filename + '\\' + filename + '_MTL.txt'
    Sensor = filename[0:3] #Extract the sensor (LE7,LT4/5,LC8)
    f = open(metafile, 'r')
    for line in f: #Parse the XML structure for necessary metadata
        if 'DATE_ACQUIRED' in line:
            date = line.split('=')[1]
            datelist = date.split('-')
            year = datelist[0].strip(' ')
            month = datelist[1]
            day1 = datelist[2]
            day = day1.strip('\n')
        elif 'SUN_AZIMUTH' in line:
            Sun_azi = float(line.split('=')[1])
        elif 'SUN_ELEVATION' in line:
            Sun_elev = float(line.split('=')[1])
        elif 'SCENE_CENTER_TIME' in line:
            timetop = line.split('=')[1]
            t = timetop.split(':')
            t3 = t[2].strip('abcdefghijklmnopqrstuvwxyz \nABCDEFGHIJKLMNOPQRSTUVWXYZ')
            timestamp = t[0] + ':' + t[1] + ':' + t3
        elif 'GRID_CELL_SIZE_REFLECTIVE' in line:
            sizetop = line.split('=')[1]
            size = sizetop.strip('\n')
            G = float(size)
        elif 'UTM_ZONE' in line:
            UTMZONE = str(line.split('=')[1])
            UTMZONE_strip = UTMZONE.strip(' \n')
            #The following line should be modified based on where .prj files are stored relative to data. Ex:
            prjfile = prjdir + 'WGS 1984 UTM Zone ' + UTMZONE_strip + 'N.prj'
        elif 'WRS_PATH' in line:
            PATH = int(line.split('=')[1])
        elif 'WRS_ROW' in line:
            ROW = int(line.split('=')[1])
        else:
            continue
    f.close()
    print 'Metadata parsed...'
    
    year_day = year + '_' + month + '_' + day #Construct timestamp for naming conventions
    raster = Path_Raw + filename + '\\' + filename + '_B4.tif' #Use a single band for creation clipping mask for other datasets. This can be any image.
    flag = 'N'
    clipshp, arcrast = RastToShp(raster, year_day, flag) #Return clipping polygon and raster that is used to snap other datasets to same grid
    print 'Extent Created...'
    HS_Mask, prjDEM = HSMask(year_day, clipshp, arcrast, Sun_azi, Sun_elev, Asia_SRTM, prjfile) #Create a hillshade image to remove shadows from forthcoming datasets
    print 'HS Created'
    
    if Asia_Slope == 'NULL':
        Slope = Path_SRTM + year_day + "_Slope.tif"
        S = arcpy.sa.Slope(prjDEM)
        S.save(Slope)
    else:
        Slope == Asia_Slope
    print 'Slope done...'
    #Choose which velocity profile to use
    Velocity = Velocitydir + str(PATH) + '_' + str(ROW) + '_Normed.tif' #Velocities are named relative to the Path/Row combination
    print 'Velocity chosen...'
    return year_day, HS_Mask, clipshp, timestamp, G, Sensor, arcrast, Velocity, Slope, prjfile, prjDEM, PATH, ROW #Returns data needed for the rest of the script       
            
def RastToShp(rastinfile, year_day, flag): 
    """Creates the output extent to be used in the rest of the script. Allows all images to be snapped to
    a constant grid, for direct matrix to matrix comparison"""
    if flag == 'N':
        arcrast = TMP + year_day + "_recasttif.tif"
        tmptif = arcpy.Raster(rastinfile)
        tmptif.save(arcrast) #This step can be necessary for Arc tools to work properly on .tif files
        arcpy.CalculateStatistics_management(arcrast)
    if flag == 'Y':
        arcrast = TMP + year_day + "_recasttif.tif"
        arcpy.CopyRaster_management(rastinfile, arcrast, '', '-9999', '-9999')
    arcpy.env.extent = arcrast
    clipshp_tmp = TMP + year_day + "_clipshp_tmp.shp"
    EXT_data = arcpy.sa.Con(arcrast, 1, 0, '"Value" > 0') #Choose only areas with data
    tmp_ext = TMP + year_day + "_clipshp_con.tif"
    EXT_data.save(tmp_ext)
    del EXT_data
    arcpy.RasterToPolygon_conversion(tmp_ext, clipshp_tmp, "NO_SIMPLIFY", "Value") #Convert to Shpfile
    clipshp = TMP + year_day + "_ext.shp"
    clipshp_tmp2 = TMP + year_day + "_ext_tmp2.shp"
    arcpy.Select_analysis(clipshp_tmp, clipshp_tmp2, '"GRIDCODE" = 1')
    arcpy.Buffer_analysis(clipshp_tmp2, clipshp, "-2 Kilometers") #Negative buffer to remove edge effects

    cliprast = TMP + year_day + '_ext_tif.tif'
    arcpy.FeatureToRaster_conversion(clipshp, "GRIDCODE", cliprast, 30) #Convert back to TIF file to use as output extent
    
    arcpy.Delete_management(clipshp)
    arcpy.Delete_management(clipshp_tmp)
    arcpy.Delete_management(clipshp_tmp2)
    arcpy.Delete_management(tmp_ext)
    
    return cliprast, arcrast
     
def HSMask(year_day, clipshp, rastband, Sun_azi, Sun_elev, Asia_DEM, prj): 
    """Clips a subset of a larger DEM, and then creates both a hillshade and a shadow mask. Returns the shadow mask, 
    as well as a projected version of the DEM"""
    outDEM = Path_SRTM + year_day + "_DEM.tif"  
    HSname = Path_SRTM + year_day + "_DEM_HS.tif"
   
    arcpy.env.snapRaster = Asia_SRTM
    arcpy.env.extent = clipshp
    
    SRTM_DEM_clip = arcpy.sa.ExtractByMask(Asia_DEM, clipshp)
    SRTM_DEM_clip.save(outDEM)

    prjDEM = Path_SRTM + year_day + "_DEM_prj.tif"
    arcpy.ProjectRaster_management(outDEM, prjDEM, prj, 'BILINEAR', '30')
    arcpy.Delete_management(outDEM)
    
    HS = arcpy.sa.Hillshade(prjDEM, Sun_azi, Sun_elev, "SHADOWS") #Create Hillshade image
    HS.save(HSname)
    del HS
    
    #Find shadowed areas and return a binary raster to use as a mask 
    HS_Maskout = Path_SRTM + year_day + "_HSMask.tif" 
    HS_Mask = arcpy.sa.Con(HSname, 1, 0, '"VALUE" < 10')
    HS_Mask.save(HS_Maskout)
    del HS_Mask
    arcpy.Delete_management(HSname)
    
    return HS_Maskout, prjDEM
    
def ExtMatch(year_day, band, clipshp, tiffile, arcrast, prjfile, foldername):
    """This function matches all rasters to the same grid. It resamples when necessary using bilinear resampling.
    Returns the clipped version of the input dataset."""
    
    arcpy.env.snapRaster = arcrast
    arcpy.env.extent = clipshp

    outprj = TMP + year_day + '_' + band + '_tightprj.tif'
    arcpy.ProjectRaster_management(tiffile, outprj, prjfile, 'BILINEAR', '30')
                
    out_tight = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
    cliptif = arcpy.sa.ExtractByMask(outprj, clipshp)
    cliptif.save(out_tight)
    del cliptif
    arcpy.Delete_management(outprj)

    cell = arcpy.GetRasterProperties_management(out_tight, 'CELLSIZEX')
    cellsize = cell.getOutput(0)
    if cellsize <> 30:
        out_tight_res = TMP + year_day + "_" + band + "_tight_res.tif"
        arcpy.Resample_management(out_tight, out_tight_res, '30', 'BILINEAR') #Resample all datasets to same resolution
        arcpy.Delete_management(out_tight)
        arcpy.CopyRaster_management(out_tight_res, out_tight)
        arcpy.Delete_management(out_tight_res)

    return out_tight
        
def ConvertShp(dataset, year_day, timestamp, filename, typed, G, prjfile):
    """This function takes a raster dataset and converts it to polygons. It also adds a set
    of metadata, including year, timestamp, image ID, and centroid to each polygon."""

    arcpy.env.extent = Asia_SRTM
    
    if typed == 'G':
        outfeats = Path_Glac_Ext + year_day + '_' + filename + '_glaciers_tmp.shp'
        R35 = Glac_Base + '_35.tif'
    if typed == 'L':
        outfeats = Path_Lake_Ext + year_day + '_' + filename + '_lakes_tmp.shp'

    arcpy.CalculateStatistics_management(dataset)
    outfeats_t = basepath + '\\TMP\\tmp_shp.shp'
    arcpy.RasterToPolygon_conversion(dataset, outfeats_t, 'NO_SIMPLIFY') #Convert raster back to polygon
    arcpy.Select_analysis(outfeats_t, outfeats, '"GRIDCODE" = 1')
    arcpy.Delete_management(outfeats_t)
    arcpy.DefineProjection_management(outfeats, prjfile)
    
    arcpy.AddField_management(outfeats, 'IMG', 'TEXT') #Add Fields
    arcpy.AddField_management(outfeats, 'Date', 'TEXT')
    arcpy.AddField_management(outfeats, 'Timestamp', 'TEXT')
    arcpy.AddField_management(outfeats, 'Area', 'FLOAT')
    arcpy.AddField_management(outfeats, 'Perimeter', 'FLOAT')
    arcpy.AddField_management(outfeats, 'Error', 'FLOAT')
    arcpy.AddField_management(outfeats, 'CentX', 'FLOAT')
    arcpy.AddField_management(outfeats, 'CentY', 'FLOAT')
    
    opt1 = "'%s'" % filename
    arcpy.CalculateField_management(outfeats, 'IMG', opt1, 'PYTHON') #Add filename
    operator = "'%s'" % year_day 
    arcpy.CalculateField_management(outfeats, 'Date', operator, 'PYTHON') #Add Date
    opt2 = "'%s'" % timestamp
    arcpy.CalculateField_management(outfeats, 'Timestamp', opt2, 'PYTHON') #Add Timestamp
    arcpy.CalculateField_management(outfeats, 'Area', "float(!SHAPE.AREA!)", 'PYTHON') #Calculate Area
    arcpy.CalculateField_management(outfeats, 'CentX', "float(!SHAPE.CENTROID!.split()[0])", 'PYTHON') #Add centroids
    arcpy.CalculateField_management(outfeats, 'CentY', "float(!SHAPE.CENTROID!.split()[1])", 'PYTHON')

    print 'Fields calculated for ' + year_day + ' on ' + outfeats
    
    cur = arcpy.UpdateCursor(outfeats)
    shapeName = arcpy.Describe(outfeats).shapeFieldName
    for shape in cur:
        feat = shape.getValue(shapeName)
        shape.PERIMETER = feat.length #Add perimeter
        shape.ERROR = feat.length/(G * 0.6872 * (math.pow(G,2))/2) # (P/G) * 0.6872 * G2/2 where P is perimeter and G is spatial resolution pre resampling
        ##!Perimeter! /( 30 * 0.6872 * (math.pow(30,2))/2)##
        cur.updateRow(shape)
    del cur
    if typed == 'G': #For glaciers - trim out small spaces if they are not explicitly classified as glacier
        outtable = TMP + 'R35table.dbf'
        arcpy.CalculateStatistics_management(R35)
        outfeats_fin = Path_Glac_Ext + year_day + '_' + filename + '_glaciers.shp'
        arcpy.Select_analysis(outfeats, outfeats_fin, '"AREA" > 1000 AND "PERIMETER" > 1000')
        out_spec = basepath + '\\Spec_Raw\\' + year_day + '_' + filename + '_glaciers_35_tmp.shp'
        out_spec_fin = basepath + '\\Spec_Raw\\' + year_day + '_' + filename + '_glaciers_35.shp'
        arcpy.RasterToPolygon_conversion(R35, out_spec, 'NO_SIMPLIFY') #Convert raster back to polygon
        arcpy.DefineProjection_management(out_spec, prjfile)
        arcpy.Select_analysis(out_spec, out_spec_fin, '"GRIDCODE" = 1')
        arcpy.Delete_management(out_spec)
        arcpy.Delete_management(R35)
        arcpy.Delete_management(outfeats)
        print 'Zonal Stats Done for Glacier...'
            
    if typed == 'L': #For Lakes - trim out small areas
        outfeats_fin = Path_Lake_Ext + year_day + '_' + filename + '_lakes.shp'
        arcpy.Select_analysis(outfeats, outfeats_fin, '"AREA" > 5') #500
        arcpy.Delete_management(outfeats)
        
    return outfeats_fin

for foldername in os.listdir(Path_Raw):
    try:
        print 'Processing ' + foldername
        arcpy.env.extent = Asia_SRTM #Set the default processing extent before each tree
        year_day, HS_Mask, clipshp, timestamp, G, Sensor, arcrast, Velocity, Slope, prjfile, prjDEM, PATH, ROW = LandsatMetadataRead(foldername) #Read metadata, prep elevation derived datasets
        arcpy.env.extent = clipshp
        
        for file in os.listdir(Path_Raw + foldername):
            Landsat = Path_Raw + foldername + "\\" + file
            ## Clip all the images to the same size 
            if Landsat.endswith('.TIF') == True:
                bandtop = Landsat.split('_')[-1]
                band = bandtop.strip('.tifTIF')
                if band == '1':
                    band = 'B6_1'
                elif band == '2':
                    band = 'B6_2'
                if band == 'B1' or band == 'B2' or band == 'B3' or band == 'B4' or band == 'B5' or band == 'B7' or band == 'B6': 
                    if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
                        ExtMatch(year_day, band, clipshp, Landsat, arcrast, prjfile, foldername) #This function does the clipping and resampling
                        print band + ' extent matched.'
                    else:
                        continue
                else:
                    continue

        if Sensor == 'LE7' or Sensor == 'LT5':
            B1 = TMP + year_day + '_B1_' + foldername + "_tight.tif"
            B3 = TMP + year_day + '_B3_' + foldername + "_tight.tif"
            B4 = TMP + year_day + '_B4_' + foldername + "_tight.tif"
            B5 = TMP + year_day + '_B5_' + foldername + "_tight.tif"
            B7 = TMP + year_day + '_B7_' + foldername + "_tight.tif"
        elif Sensor == 'LC8': #Rename some files to account for different band values on LC8
            B1 = TMP + year_day + '_B2_' + foldername + "_tight.tif"
            B3 = TMP + year_day + '_B4_' + foldername + "_tight.tif"
            B4 = TMP + year_day + '_B5_' + foldername + "_tight.tif"
            B5 = TMP + year_day + '_B6_' + foldername + "_tight.tif"
            B7 = TMP + year_day + '_B7_' + foldername + "_tight.tif"
        
        band = 'ShadowMask' 
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            Mask = ExtMatch(year_day, band, clipshp, HS_Mask, arcrast, prjfile, foldername)
        else:
            Mask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Shadow Mask Created'
                
        band = 'SlopeMask'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            SlopeMask = ExtMatch(year_day, band, clipshp, Slope, arcrast, prjfile, foldername)
        else:
            SlopeMask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Slope Mask Created'
        
        band = 'ElevMask'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            ElevMask = ExtMatch(year_day, band, clipshp, prjDEM, arcrast, prjfile, foldername)
        else:
            ElevMask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Elevation Mask Created'
        
        band = 'RivMask' 
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            RivMask = ExtMatch(year_day, band, clipshp, Rivers, arcrast, prjfile, foldername)
        else:
            RivMask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'River Mask Created'
        
        band = 'VelMask'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            Vel_Arc = TMP + year_day + '_tmpVel.tif' #This is necessary for datasets which come from Matlab, because Arc is bad with reading projection information written from Matlab
            v = arcpy.Raster(Velocity)
            v.save(Vel_Arc)
            del v
            VelMask = ExtMatch(year_day, band, clipshp, Vel_Arc, arcrast, prjfile, foldername)
            arcpy.Delete_management(Vel_Arc)
        else:
            VelMask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Velocity Mask Created'

        band = 'LakeTrace'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            Lakes_known = ExtMatch(year_day, band, clipshp, TraceLakes, arcrast, prjfile, foldername)
        else:
            Lakes_known = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Lake Training Set Created'

        band = 'ManualDebris'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            Debris = ExtMatch(year_day, band, clipshp, TraceDebris, arcrast, prjfile, foldername)
        else:
            Debris = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Manual Debris Cover Clipped'
        
        arcpy.Delete_management(arcrast)
        if Asia_Slope == 'NULL':
            arcpy.Delete_management(Slope)
        print 'Input Datasets Created'

        #Set up output paths
        Out_Lakes = Path_Lake_Ext + year_day + '_' + foldername + '_lakes.tif'
        Glac_Base = Path_Glac_Ext + year_day + '_' + foldername + '_glaciers'
        Out_Glaciers = Path_Glac_Ext + year_day + '_' + foldername + '_glaciers.tif'     
               
        ## Send the inputs to Matlab for processing of Lakes ##
        try:
            arcpy.Delete_management(Out_Lakes)
        except:
            pass
        if os.path.exists(Out_Lakes) == False:
            #print "matlab -nosplash -nodesktop -r Lake_Extraction('%s','%s','%s','%s','%s','%s')" % (B1,B4,HS_Mask,Out_Lakes, Lakes_known, SlopeMask)
            subprocess.call("matlab -nosplash -nodesktop -r Lake_Extraction('%s','%s','%s','%s','%s','%s')" % (B1,B4,Mask,Out_Lakes, Lakes_known, SlopeMask))
            while not os.path.exists(Out_Lakes):
                time.sleep(1)
        time.sleep(5)
        typed = 'L'
        arcpy.DefineProjection_management(Out_Lakes, prjfile)   
        Lake_Shp = ConvertShp(Out_Lakes, year_day, timestamp, foldername, typed, G, prjfile)

        ## Send inputs to Matlab for processing of Glaciers ##
        try:
            arcpy.Delete_management(Out_Glaciers)
        except:
            pass
        if os.path.exists(Out_Glaciers) == False:
            #Matlab takes a hard number of characters for command line calls, so this writes all of the data to a CSV which is then parsed in Matlab
            #The procile directory must contain thresholds for each individual scene. See example 'Example_Threshold_File.csv'
            procsv = Procdir + 'Threshold_' + str(PATH) + '_' + str(ROW) + '.csv' 
            tmproc = Procdir + 'procfile_' + foldername + '.csv'
            csvwrite = csv.writer(open(tmproc, 'wb'))
            csvwrite.writerow([B1,B3,B4,B5,B7,Mask,Glac_Base,Out_Lakes,SlopeMask,ElevMask,RivMask,Debris,VelMask,procsv])
            del csvwrite
            subprocess.call("matlab -nosplash -nodesktop -r Glacier_Extraction('%s')" % tmproc)
            d = 0
            while not os.path.exists(Out_Glaciers):
                time.sleep(1)
                d = d + 1
                if d > 1000:
                    break
           
        print 'Matlab done. Vectorizing...'
        time.sleep(5) #Allow five seconds for datasets to be properly saved out
        
        ## Do final attribute adding and conversion
        typed = 'G'
        GlacOut = Glac_Base + '.tif'
        Glac_Shp = ConvertShp(GlacOut, year_day, timestamp, foldername, typed, G, prjfile)
        arcpy.DefineProjection_management(Glac_Shp, prjfile)      
        ## Clean up unneccessary datasets ##
        arcpy.Delete_management(B1)
        arcpy.Delete_management(B3)
        arcpy.Delete_management(B4)
        arcpy.Delete_management(B5)
        arcpy.Delete_management(Mask)
        arcpy.Delete_management(B7)
        arcpy.Delete_management(SlopeMask)
        arcpy.Delete_management(ElevMask)
        arcpy.Delete_management(RivMask)
        arcpy.Delete_management(Out_Lakes)
        arcpy.Delete_management(Debris)
        arcpy.Delete_management(Out_Glaciers)
        arcpy.Delete_management(VelMask)
        print 'Done with ' + foldername
        
    except:
        print foldername + ' failed.'
        traceback.print_exc()
        print 'I hope that error code helps.'
        try:
            arcpy.Delete_management(B1)
            arcpy.Delete_management(B3)
            arcpy.Delete_management(B4)
            arcpy.Delete_management(B5)
            arcpy.Delete_management(Mask)
            arcpy.Delete_management(B7)
            arcpy.Delete_management(SlopeMask)
            arcpy.Delete_management(ElevMask)
            arcpy.Delete_management(RivMask)
            arcpy.Delete_management(Out_Lakes)
            arcpy.Delete_management(Debris)
            arcpy.Delete_management(Out_Glaciers)
            arcpy.Delete_management(VelMask)
        except:
            pass


