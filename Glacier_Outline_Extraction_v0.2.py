## This script takes Landsat data and performs automated classifications of glaciated areas and lake areas.
## Wrapper to one Matlab script (Glacier_Extraction)
## Created by Taylor Smith, v2 February 2015

#Import Modules
print "Loading modules..."
import os, csv
import time, subprocess, traceback
import numpy as np
from osgeo import gdal, ogr, osr, gdalnumeric
gdal.UseExceptions()
#All modules are open source

basepath = # This is the base directory path. All other file paths are relative to this
config_file = #Configuration file
Path_Raw = #PATH TO RAW DATA (Landsat images each in seperate directory)
Path_Glac_Ext = #PATH TO OUTPUT GLACIAL EXTENT SHAPEFILES TO
Path_Lake_Ext = #PATH TO OUTPUT LAKE EXTENTS TO
Path_SRTM = #PATH TO SAVE RESAMPLED DEMS INTO
TMP = #WORKING DIRECTORY WHERE TEMPORARY DATASETS WILL BE SAVED
Procdir = #WORDKING DIRECTORY FOR PROCFILES FOR INDIVIDUAL SCENES

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

    metafile = Path_Raw + filename + '/' + filename + '_MTL.txt'
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
    raster = Path_Raw + filename + '/' + filename + '_B1.TIF' #Use a single band for creation clipping mask for other datasets. This can be any image.
    flag = 'N'
    clipshp, EPSG = RastToShp(raster, year_day, flag) #Return clipping polygon and raster that is used to snap other datasets to same grid
    print 'Extent Created...'
    HS_Mask, prjDEM = HSMask(year_day, clipshp, Sun_azi, Sun_elev, Asia_SRTM, prjfile) #Create a hillshade image to remove shadows from forthcoming datasets
    print 'HS Created'

    if Asia_Slope == 'NULL':
        Slope = Path_SRTM + year_day + "_Slope.tif"
        gdal_comm = ['gdaldem', 'slope', '-s', '111120', prjDEM, Slope]
        if os.path.exists(Slope) == False:
            subprocess.call(gdal_comm)
            while os.path.exists(Slope) == False:
                time.sleep(1)
    else:
        Slope == Asia_Slope
    print 'Slope done...'
    #Choose which velocity profile to use
    Velocity = Velocitydir + str(PATH) + '_' + str(ROW) + '_Normed.tif' #Velocities are named relative to the Path/Row combination
    print 'Velocity chosen...'
    return year_day, HS_Mask, clipshp, timestamp, G, Sensor, Velocity, Slope, prjfile, prjDEM, PATH, ROW, EPSG #Returns data needed for the rest of the script

def RastToShp(rastinfile, year_day, flag):
    """Creates the output extent to be used in the rest of the script. Allows all images to be snapped to
    a constant grid, for direct matrix to matrix comparison"""

    t = gdal.Open(rastinfile)
    gt = t.GetGeoTransform()
    tmptif = t.ReadAsArray()#.astype(float)
    tmptif[tmptif > 0] = 1
    tmptif[tmptif != 1] = 0#np.nan
    cs = t.GetProjection()
    cs_sr = osr.SpatialReference()
    cs_sr.ImportFromWkt(cs)
    EPSG = cs_sr.GetAttrValue("AUTHORITY", 1)

    cols = tmptif.shape[1]
    rows = tmptif.shape[0]

    driver = gdal.GetDriverByName('GTiff')
    driver.Register()
    outRaster = driver.Create(TMP + 'con.tif', cols, rows, 1, gdal.GDT_Byte)
    outRaster.SetGeoTransform(gt)
    outRaster.SetProjection(cs)
    outband = outRaster.GetRasterBand(1)
    outband.WriteArray(tmptif,0,0)
    outband.FlushCache()
    del driver, outRaster, t

    t = gdal.Open(TMP + 'con.tif')
    band = t.GetRasterBand(1)

    dst_layername = 'Clipper'
    clipper = TMP + dst_layername + '.shp'
    drv = ogr.GetDriverByName('ESRI Shapefile')
    if os.path.exists(clipper):
        drv.DeleteDataSource(clipper)
    dst_ds = drv.CreateDataSource(clipper)
    dst_layer = dst_ds.CreateLayer(dst_layername, srs=None)
    gdal.Polygonize(band, band, dst_layer, -1, [], callback=None)

    #This step merges all non-zero polygons into one clipping mask
    newGeometry = None
    for feature in dst_layer:
		geometry = feature.GetGeometryRef()
		if newGeometry is None:
			newGeometry = geometry.Clone()
		else:
			newGeometry = newGeometry.Union(geometry)
		dst_layer.DeleteFeature(feature.GetFID())

    #A negative 2km buffer is applied to cut down on edge effects
    shp = newGeometry.Buffer(-2000)
    shp.AssignSpatialReference(cs_sr)
    del newGeometry

    feature = ogr.Feature(dst_layer.GetLayerDefn())
    feature.SetGeometry(shp)
    feature.SetFID(1)
    dst_layer.CreateFeature(feature)
    feature.Destroy()
    dst_ds.Destroy()
    prj = open(TMP + 'Clipper.prj', 'w')
    prj.write(cs)
    prj.close()

    os.remove(TMP + 'con.tif')
    del t, band, dst_layername, drv, dst_layer, shp, feature

    return clipper, EPSG

def HSMask(year_day, clipshp, Sun_azi, Sun_elev, Asia_DEM, prj):
    """Clips a subset of a larger DEM, and then creates both a hillshade and a shadow mask. Returns the shadow mask,
    as well as a projected version of the DEM"""
    outDEM = Path_SRTM + year_day + "_DEM_t.tif"
    prjDEM = Path_SRTM + year_day + "_prjDEM.tif"
    HSname = Path_SRTM + year_day + "_DEM_HS.tif"
    HS_Maskout = Path_SRTM + year_day + "_HSMask.tif"

    wgs = 'GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.01745329251994328,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]]'
    gdal_comm = ['gdalwarp', '-s_srs', wgs, '-of', 'GTiff', '-cutline', clipshp, '-cl', 'Clipper', '-crop_to_cutline', '-overwrite', Asia_DEM, outDEM]
    if os.path.exists(outDEM) == False:
        subprocess.call(gdal_comm)
    while os.path.exists(outDEM) == False:
        time.sleep(1)
    print 'DEM Clipped'

    prj_str = open(prj).next().strip('\r\n')
    prj_os=osr.SpatialReference()
    prj_os.ImportFromWkt(prj_str)
    prj_out = prj_os.ExportToProj4()
    gdal_comm = ['gdalwarp', '-s_srs', wgs, '-t_srs', prj_out, '-cutline', clipshp, '-cl', 'Clipper', '-crop_to_cutline', '-overwrite', outDEM, prjDEM]
    if os.path.exists(prjDEM) == False:
        subprocess.call(gdal_comm)
    while os.path.exists(prjDEM) == False:
        time.sleep(1)
    print 'DEM Clipped + Projected'

    gdal_comm = ['gdaldem', 'hillshade', prjDEM, HSname, '-az', str(Sun_azi), '-alt', str(Sun_elev)]
    if os.path.exists(HSname) == False:
        subprocess.call(gdal_comm)
        while os.path.exists(HSname) == False:
            time.sleep(1)
    print 'HS Made'

    #Find shadowed areas and return a binary raster to use as a mask
    if os.path.exists(HS_Maskout) == False:
        t = gdal.Open(HSname)
        gt = t.GetGeoTransform()
        tmptif = t.ReadAsArray()#.astype(float)
        tmptif[tmptif < 1.1] = 1
        tmptif[tmptif >= 1.1] = 0
        cs = t.GetProjection()

        cols = tmptif.shape[1]
        rows = tmptif.shape[0]

        driver = gdal.GetDriverByName('GTiff')
        driver.Register()
        outRaster = driver.Create(HS_Maskout, cols, rows, 1, gdal.GDT_Byte)
        outRaster.SetGeoTransform(gt)
        outRaster.SetProjection(cs)
        outband = outRaster.GetRasterBand(1)
        outband.WriteArray(tmptif,0,0)
        outband.FlushCache()
        del driver, outRaster, t

        os.remove(HSname)

    return HS_Maskout, outDEM

def ExtMatch(year_day, band, clipshp, tiffile, prjfile, foldername):
    """This function matches all rasters to the same grid. It resamples when necessary using bilinear resampling.
    Returns the clipped version of the input dataset."""

    prj_str = open(prjfile).next().strip('\r\n')
    prj_os=osr.SpatialReference()
    prj_os.ImportFromWkt(prj_str)
    prj_out = prj_os.ExportToProj4()
    out_tight = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
    gdal_comm = ['gdalwarp', '-of', 'GTiff', '-t_srs', prj_out, '-cutline', clipshp, '-cl', 'Clipper', '-crop_to_cutline', tiffile, out_tight]
    if os.path.exists(out_tight) == False:
        subprocess.call(gdal_comm)
        while os.path.exists(out_tight) == False:
            time.sleep(1)

    t = gdal.Open(out_tight)
    cellsize = int(t.GetGeoTransform()[1])

    if cellsize <> 30:
        out_tight_res = TMP + year_day + "_" + band + "_tight_res.tif"
        gdal_comm = ['gdalwarp', '-s_srs', prj_out, '-tr', '30', '30', '-r', 'bilinear', '-cutline', clipshp, '-cl', 'Clipper', '-crop_to_cutline', out_tight, out_tight_res]
        if os.path.exists(out_tight_res) == False:
            subprocess.call(gdal_comm)
            while os.path.exists(out_tight_res) == False:
                time.sleep(1)
            os.remove(out_tight)
            os.rename(out_tight_res, out_tight)

    t = gdal.Open(out_tight)
    print 'Raster is ' + str(t.RasterXSize) + 'x' + str(t.RasterYSize)
    del t
    return out_tight

def ConvertShp(dataset, year_day, timestamp, filename, typed, G, prjfile):
    """This function takes a raster dataset and converts it to polygons. It also adds a set
    of metadata, including year, timestamp, image ID, and centroid to each polygon."""

    if typed == 'G':
        outfeats = Path_Glac_Ext + year_day + '_' + filename + '_glaciers.shp'
    if typed == 'Spec':
        outfeats = Path_Glac_Ext + year_day + '_' + filename + '_spectral.shp'

    drv = ogr.GetDriverByName('ESRI Shapefile')
    if os.path.exists(outfeats):
        drv.DeleteDataSource(outfeats)

    t = gdal.Open(dataset)
    band = t.GetRasterBand(1)

    dst_layername = 'Data'
    dst_ds = drv.CreateDataSource(outfeats)
    dst_layer = dst_ds.CreateLayer(dst_layername, srs=None)
    #Calling 'band' twice uses the already binary image as its own mask
    gdal.Polygonize(band, band, dst_layer, -1, [], callback=None)
    dst_ds.Destroy()
    del dst_layer, drv, dst_layername, band, t
    prjout = outfeats.split('.')[0] + '.prj'
    prj = open(TMP + 'Clipper.prj', 'r')
    data = prj.next()
    prj.close()
    prj2 = open(prjout, 'w')
    prj2.write(data)
    prj2.close()
    print outfeats

    return outfeats

def Lake_Extract(TM1, TM4, Mask, outpath, TraceLake, Slope):
    """ This function extracts Lake pixels based on an
    input set of 'training lakes' provided as a tif file"""

    t = gdal.Open(TM1)
    cs = t.GetProjection()
    cs_sr = osr.SpatialReference()
    cs_sr.ImportFromWkt(cs)
    tmptif = t.ReadAsArray()
    cols = tmptif.shape[1]
    rows = tmptif.shape[0]
    gt = t.GetGeoTransform()
    del t, tmptif

    TM1_Arr = gdalnumeric.LoadFile(TM1).astype(float)
    TM4_Arr = gdalnumeric.LoadFile(TM4).astype(float)
    TM1_Arr[(TM1_Arr <= 0)] = np.nan
    TM4_Arr[(TM4_Arr <= 0)] = np.nan

    Shadow = gdalnumeric.LoadFile(Mask).astype(float)
    Shadow[(Shadow <= 0)] = np.nan

    Ratio = (TM4_Arr - TM1_Arr) / (TM4_Arr + TM1_Arr)
    del TM1_Arr, TM4_Arr

    Lakes = gdalnumeric.LoadFile(TraceLake).astype(float)
    target = np.where(Lakes == 1)
    LRatio = np.nanmean(Ratio[target]) + 0.025

    Ratio[(Shadow == 1)] = np.nan
    Ratio[(Ratio < LRatio)] = 1
    Ratio[(Ratio != 1)] = np.nan

    Slope_Arr = gdalnumeric.LoadFile(Slope).astype(float)
    Ratio[(Slope_Arr > 3)] = np.nan
    del Lakes, Shadow, Slope_Arr

    driver_tif = gdal.GetDriverByName('GTiff')
    driver_tif.Register()
    if os.path.exists(outpath):
        os.remove(outpath)
    outRaster = driver_tif.Create(outpath, cols, rows, 1, gdal.GDT_Byte)
    outRaster.SetGeoTransform(gt)
    outRaster.SetProjection(cs)
    outband = outRaster.GetRasterBand(1)
    outband.WriteArray(Ratio,0,0)
    outband.FlushCache()
    del driver_tif, outRaster, Ratio

for foldername in os.listdir(Path_Raw):
    try:
        print 'Processing ' + foldername
        year_day, HS_Mask, clipshp, timestamp, G, Sensor, Velocity, Slope, prjfile, prjDEM, PATH, ROW, EPSG = LandsatMetadataRead(foldername) #Read metadata, prep elevation derived datasets
        for fil in os.listdir(Path_Raw + foldername):
            Landsat = Path_Raw + foldername + '/' + fil
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
                        ExtMatch(year_day, band, clipshp, Landsat, prjfile, foldername) #This function does the clipping and resampling
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
            Mask = ExtMatch(year_day, band, clipshp, HS_Mask, prjfile, foldername)
        else:
            Mask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Shadow Mask Created'

        band = 'SlopeMask'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            SlopeMask = ExtMatch(year_day, band, clipshp, Slope, prjfile, foldername)
        else:
            SlopeMask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Slope Mask Created'

        band = 'ElevMask'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            ElevMask = ExtMatch(year_day, band, clipshp, prjDEM, prjfile, foldername)
        else:
            ElevMask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Elevation Mask Created'

        band = 'RivMask'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            RivMask = ExtMatch(year_day, band, clipshp, Rivers, prjfile, foldername)
        else:
            RivMask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'River Mask Created'

        band = 'VelMask'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            VelMask = ExtMatch(year_day, band, clipshp, Velocity, prjfile, foldername)
        else:
            VelMask = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Velocity Mask Created'

        band = 'LakeTrace'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            Lakes_known = ExtMatch(year_day, band, clipshp, TraceLakes, prjfile, foldername)
        else:
            Lakes_known = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Lake Training Set Created'

        band = 'ManualDebris'
        if os.path.exists(TMP + year_day + "_" + band + '_' + foldername + "_tight.tif") == False:
            Debris = ExtMatch(year_day, band, clipshp, TraceDebris, prjfile, foldername)
        else:
            Debris = TMP + year_day + "_" + band + '_' + foldername + "_tight.tif"
        print 'Manual Debris Cover Clipped'

        if Asia_Slope == 'NULL':
            os.remove(Slope)
        print 'Input Datasets Created'

        #Set up output paths
        Out_Lakes = Path_Lake_Ext + year_day + '_' + foldername + '_lakes.tif'
        Glac_Base = Path_Glac_Ext + year_day + '_' + foldername + '_glaciers'
        Out_Glaciers = Path_Glac_Ext + year_day + '_' + foldername + '_glaciers.tif'

        ## Send the inputs to Matlab for processing of Lakes ##
        driver = ogr.GetDriverByName('ESRI Shapefile')
        try:
            os.remove(Out_Lakes)
        except:
            pass
        Lake_Extract(B1, B4, HS_Mask, Out_Lakes, Lakes_known, SlopeMask)
        print 'Lakes Done'

        ## Send inputs to Matlab for processing of Glaciers ##
        try:
            os.remove(Out_Glaciers)
        except:
            pass
        if os.path.exists(Out_Glaciers) == False:
            #Matlab takes a hard number of characters for command line calls, so this writes all of the data to a CSV which is then parsed in Matlab
            #The procile directory must contain thresholds for each individual scene. See example 'Example_Threshold_File.csv'
            procsv = Procdir + 'Threshold_' + str(PATH) + '_' + str(ROW) + '.csv'
            tmproc = Procdir + 'procfile_' + foldername + '.csv'
            csvwrite = csv.writer(open(tmproc, 'wb'))
            csvwrite.writerow([B1,B3,B4,B5,B7,Mask,Glac_Base,Out_Lakes,SlopeMask,ElevMask,RivMask,Debris,VelMask,procsv,EPSG])
            del csvwrite
            matlabCom = "Glacier_Extraction('%s')" % tmproc
            command = ['matlab', '-nosplash', '-nodesktop', '-r', matlabCom]
            subprocess.call(command)
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
        typed = 'Spec'
        GlacOut = Glac_Base + '_spectral.tif'
        Glac_Shp = ConvertShp(GlacOut, year_day, timestamp, foldername, typed, G, prjfile)

        ## Clean up unneccessary datasets ##
        driver.DeleteDataSource(clipshp)
        del driver
        print 'Done with ' + foldername

    except:
        print foldername + ' failed.'
        traceback.print_exc()
        print 'I hope that error code helps.'



