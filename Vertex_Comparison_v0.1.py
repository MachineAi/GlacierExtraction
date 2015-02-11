# -*- coding: utf-8 -*-
"""
This script compares the distance between vertices for input shapefiles.

Created Feb 2015 by Taylor Smith. v0.1
"""

#Import Modules
print "Loading modules..."
import sys, os, csv
import time, subprocess, traceback
import numpy as np
from osgeo import gdal, ogr, osr, gdalnumeric
gdal.UseExceptions()
import pyproj
import shapefile

def conf_reader(config_file): #Read config files with comments
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

basepath = # This is the base path
TMP = # Temporary Directory
StatsPath = #Path for the vertex stats
Com = #Path for the elevation stats

conf = conf_reader(sys.argv[1]) #Read the Configuration file from the command line
Watersheds = conf[0] # Watersheds Shapefile, or other clipping shapefile to split the polygons
Manual = conf[1] # Manual 'Master' Dataset
Automatic = conf[2] # Algorithm produced Glacier Outlines
E = open(conf[3],'r')  # Projection (.prj) file for the glacier outlines. In PROJ4 format, text string
EPSG = E.next()
E.close()
Elev = conf[4] # Input DEM to pull elevation values (.tif format)
POINTS = conf[5] # Glacier point file, to select which glaciers to analyze
HistPath = StatsPath + conf[6] # Output folder for the Histograms, in the format FOLDERNAME/
StatOut = StatsPath + conf[7] # Output CSV file for bulk statistics
Spectral = conf[8] # Spectral Only glacier outlines, in the same format as the Algorithm produced outlines
CompPath = Com + conf[6] # Output folder for the Histograms, in the format FOLDERNAME/
Aspect = conf[9] # An aspect file if aspect information is desired for each vertex (.tif format)
SPECTRAL = conf[10]  # To process the Spectral data, Y/N
WGS84 = pyproj.Proj("+init=EPSG:4326") #Set the initial WGS84 Datum
try:
    os.mkdir(HistPath)
except:
    pass
try:
    os.mkdir(CompPath)
except:
    pass

def Feat_To_Subset(feature_object, cs_in, Type, input_shp):
    """ Takes a feature object and coordinate system
    from GDAL and returns a clip of the input shape """

    geom = feature_object.geometry()
    target = osr.SpatialReference()
    target.ImportFromProj4(EPSG)
    transform = osr.CoordinateTransformation(cs_in, target)
    geom.Transform(transform)

    tmp = TMP + Type + '_clipper_tmp.shp'
    drv = ogr.GetDriverByName('ESRI Shapefile')
    if os.path.exists(tmp):
        drv.DeleteDataSource(tmp)

    dst_ds = drv.CreateDataSource(tmp)
    dst_layer = dst_ds.CreateLayer('Clipper', srs=None)
    f = ogr.Feature(dst_layer.GetLayerDefn())
    f.SetGeometry(geom)
    f.SetFID(0)
    dst_layer.CreateFeature(f)
    dst_ds.Destroy()
    prjout = tmp.split('.')[0] + '.prj'
    prjout = open(prjout, 'w')
    prjout.write(target.ExportToWkt())
    prjout.close()

    out = TMP + Type + 'tmp_clipped.shp'
    if os.path.exists(out):
        drv.DeleteDataSource(out)

    if Type == 'Pts':
        tmp_pt = TMP + 'ptproj.shp'
        if os.path.exists(tmp_pt):
            drv.DeleteDataSource(tmp_pt)
        ds = drv.Open(input_shp,0)
        l = ds.GetLayer()
        new_ds = drv.CreateDataSource(tmp_pt)
        new_lyr = new_ds.CreateLayer('clip', srs=None)
        zzz = 0
        for ptft in l:
            g = ptft.geometry()
            g.Transform(transform)
            outft = ogr.Feature(new_lyr.GetLayerDefn())
            outft.SetGeometry(g)
            outft.SetFID(zzz)
            zzz = zzz + 1
            new_lyr.CreateFeature(outft)
        new_ds.Destroy()
        del input_shp
        input_shp = tmp_pt
        prjout = tmp_pt.split('.')[0] + '.prj'
        prjout = open(prjout, 'w')
        prjout.write(target.ExportToWkt())
        prjout.close()

    #'-s_srs', initial, '-t_srs', target.ExportToProj4(),
    #ogr2ogr -clipsrc clipping_polygon.shp output.shp input.shp
    comm = ['ogr2ogr', '-overwrite', '-clipsrc', tmp, out, input_shp]
    subprocess.call(comm)
    prjout = out.split('.')[0] + '.prj'
    prjout = open(prjout, 'w')
    prjout.write(target.ExportToWkt())
    prjout.close()
    while not os.path.exists(out):
        time.sleep(1)
    drv.DeleteDataSource(tmp)
    if Type == 'Pts':
        drv.DeleteDataSource(tmp_pt)

    return out

def ShapeExplode(shape):
    """Takes an input polygon shapefile and explodes it into component
    Vertices, which are returned as a NumPy grid"""
    #Create empty numpy array to hold coords
    Px = np.empty(shape=(m))
    Py = np.empty(shape=(m))
    Px[:] = np.nan
    Py[:] = np.nan
    sf = shapefile.Reader(shape)
    zz = 0
    shapes = sf.shapes()
    prevx = 0
    prevy = 0
    #Loop through shapes until enough vertices are found
    for shape in shapes:
        for vertex in shape.points:
            Px[zz] = vertex[0]
            Py[zz] = vertex[1]
            if Px[zz] > prevx - 15 and Px[zz] < prevx + 15 and Py[zz] > prevy - 15 and Py[zz] < prevy  + 15:
                prevx = Px[zz]
                prevy = Py[zz]
                Px[zz] = np.nan
                Py[zz] = np.nan
                zz = zz
            else:
                prevx = Px[zz]
                prevy = Py[zz]
                zz = zz + 1
                #print vertex[0], vertex[1]
            if zz >= m-1:
                break
        if zz >= m-1:
            break
    Px = Px[~np.isnan(Px)]
    Py = Py[~np.isnan(Py)]
    #If we have more than n vertices, choose a random sample
    #Only important for very large glaciers, so we have a representative sample of vertices
    if zz > n:
        idx = np.random.randint(0,Px.size,size=n)
        Px = Px[idx]
        Py = Py[idx]

    return Px, Py

def Vertex_Distance(CoordGrid, x, y):
    """Calculates the distance between each x/y pair and the input coordinate grid
    of vertices. Returns the Distance matrix and Elevation Matrix"""

    DistMat = np.empty(n)
    DistMat[:] = np.nan
    ElevMat = np.empty(n)
    ElevMat[:] = np.nan
    for i in range(0,n):
        try:
            time_s = time.time()
            Px = x[i]
            Py = y[i]
            Pt = np.array([Px, Py]) #Make a comprable Px/Py array
            GridDif = np.abs(CoordGrid - Pt) #Which can than have the original point subtracted from it
            xDif = GridDif[:,:,0]
            yDif = GridDif[:,:,1]
            TotDif = xDif + yDif #Find the total difference (already the absolute values)
            #Next find the smallest distance, excluding all zero values (TotDif[np.nonzero(TotDif)])
            idx_raw = np.where(TotDif == np.nanmin(TotDif))
            idx = idx_raw[0].tolist()[0]
            XLoc = x[idx] #Get the X/Y index of this point
            idx = idx_raw[1].tolist()[0]
            YLoc = y[idx]
            ClosestPt = np.array([XLoc, YLoc]) #Write this point to the same shape array as the input pt

            Dist = np.linalg.norm(Pt-ClosestPt) #Finally get the distance
            DistMat[i] = Dist #Finally write the data to the array at the right point
            #Next project the point into DEM space and pull the Elevation at that point
            xx, yy = pyproj.transform(pyproj.Proj(EPSG), WGS84, Px, Py)
            cX = int((xx - gt[0])/gt[1])
            cY = int((yy - gt[3])/gt[5])
            ElevMat[i] = DEM[cY,cX] #REMEMBER THIS IS IN ROWS/COLUMNS, not X/Y
            #Only on the first loop print the estimated time to completion. Removable block
            if i == 0:
                sec = time.time() - time_s
                hr = sec / 60
                t = hr * n
                print str(t) + 'estimated time (m)'
        except:
            #If there is an error (empty array, no points around, who knows what) write a NaN instead of crashing
            DistMat[i] = np.nan
            ElevMat[i] = np.nan
            #traceback.print_exc()
    return DistMat,ElevMat #Return the final distance matrix to write to the HDF

def Statmaker(wsid,clipped_man,clipped_auto,clipped_spec):
    """Takes the clipped Manual and Automatic outlines and finds
    the minimum distance between vertices for an arbitrary number
    of vertices. Subcalls to HistMaker for distribution creation"""

    #First blow the shapes up into points
    Px, Py = ShapeExplode(clipped_auto)
    xx,yy = np.meshgrid(Px,Py)
    CoordGrid = np.vstack(([xx.T], [yy.T])).T
    del Px, Py, xx, yy

    x, y = ShapeExplode(clipped_man)
    Distance_Matrix, ElevMatrix = Vertex_Distance(CoordGrid, x, y) #This returns the distance at the 1000 points (x,y)
    if clipped_spec != 'NULL':
        Px, Py = ShapeExplode(clipped_spec)
        xx,yy = np.meshgrid(Px,Py)
        CoordGrid_Spec = np.vstack(([xx.T], [yy.T])).T
        del Px, Py, xx, yy
        Distance_Spec, ElevMatrix_Spec = Vertex_Distance(CoordGrid_Spec, x, y) #This returns the distance at the 1000 points (x,y)
    elif clipped_spec == 'NULL':
        Distance_Spec = np.empty(n)
        Distance_Spec[:] = np.nan
    #Create csv to write rows to
    csvwriter = csv.writer(open(HistPath + wsid + '_hist.csv', 'wb'))
    csvwriter.writerow(['X', 'Y', 'Distance', 'Distance Spec', 'Elevation'])
    rows = zip(x,y,Distance_Matrix, Distance_Spec, ElevMatrix)
    for row in rows:
        csvwriter.writerow(row)
    del csvwriter
    del rows

    Mean = np.nanmean(Distance_Matrix)
    Min = np.nanmin(Distance_Matrix)
    Max = np.nanmax(Distance_Matrix)
    Std = np.nanstd(Distance_Matrix)
    Median = np.median(Distance_Matrix[~np.isnan(Distance_Matrix)])
    NrVerts = np.count_nonzero(Distance_Matrix[~np.isnan(Distance_Matrix)])

    return Mean, Min, Max, Std, Median, NrVerts

def Intersector(ptshp, base, Type, target):
    ptsrc = driver.Open(ptshp, 0)
    ptlyr = ptsrc.GetLayer()
    out_shp = TMP + Type + 'TMP.shp'
    if os.path.exists(out_shp):
        driver.DeleteDataSource(out_shp)

    src = driver.Open(base,0)
    lyr = src.GetLayer()
    out = driver.CreateDataSource(out_shp)
    dstlyr = out.CreateLayer('Clipper',geom_type=ogr.wkbPolygon)
    x = 0
    for pt in ptlyr:
        ptgeom = pt.geometry()
        for poly in lyr:
            x = x + 1
            polygeom = poly.geometry()
            if ptgeom.Intersects(polygeom):
                dstfeature = ogr.Feature(dstlyr.GetLayerDefn())
                dstfeature.SetGeometry(polygeom)
                dstfeature.SetFID(x)
                dstlyr.CreateFeature(dstfeature)
                break

    prjout = out_shp.split('.')[0] + '.prj'
    prjout = open(prjout, 'w')
    prjout.write(target.ExportToWkt())
    prjout.close()
    src.Destroy()
    out.Destroy()
    ptsrc.Destroy()
    return out_shp

def Histmaker(wsid,clipped_shp,TIF):
    """Takes single glacier, clips elevation, converts to array,
    creates histogram, returns bins and Histogram values"""
    out = TMP + 'tmp.tif'
    if os.path.exists(out):
        os.remove(out)
    d = ogr.GetDriverByName('ESRI Shapefile')
    ds = d.Open(clipped_shp,0)
    l = ds.GetLayer()
    fc = l.GetFeatureCount()
    ds.Destroy()
    del d, l
    if fc == 0: #If there are no shapes in the input, skip processing
        return [], []
    else: #Clip the DEM/Aspect/Slope/etc Tif to the input feature
        gdal_comm = ['gdalwarp', '-cutline', clipped_shp, '-crop_to_cutline', TIF, out]
        subprocess.call(gdal_comm)
        while os.path.exists(out) == False:
            time.sleep(1)

        Arr = gdalnumeric.LoadFile(out).astype(float)
        try:
            os.remove(out)
        except:
            pass
        Arr = Arr[(Arr > -1000)] #Remove nodata
        Arr = Arr[~np.isnan(Arr)]
        #1000 bins, 0:10:10000
        bins = np.arange(0, 10000, 10)
        Hist, bin_edges = np.histogram(Arr, bins)
        bins_list = bins.tolist()
        Hist_list = Hist.tolist()
        del Hist, bin_edges, bins, Arr

        return bins_list, Hist_list

def HistWrite(wsid, shp, name):
    """Writes the results of the histogram making step to seperate csv files
    based on the type of input (spectral, manual, algorithm, etc)"""
    hist = csv.writer(open(CompPath + wsid + '_' + name + '.csv', 'wb'), lineterminator='\n')
    bins, Elev_Hist = Histmaker(wsid,shp,Elev)
    #Uncommment this row if Aspect processing is desired
    #Any other TIF (slope, curvature, etc) could be subsituted here
    #bins, Aspect_Hist = Histmaker(wsid,shp,Aspect)

    rows = zip(bins, Elev_Hist)#, Aspect_Hist)
    for row in rows:
        hist.writerow(row)
    del bins, Elev_Hist, hist, rows#, Aspect_Hist

#Loop through a shapefile of watersheds and use each as a clipping mask
driver = ogr.GetDriverByName("ESRI Shapefile")
dataSource = driver.Open(Watersheds, 0)
layer = dataSource.GetLayer()
cs_in = layer.GetSpatialRef()

#Load the DEM
DEM = gdalnumeric.LoadFile(Elev)#.astype(float) #Only doable on big memory systems, floats take a lot of memory
srcImage = gdal.Open(Elev)
gt = srcImage.GetGeoTransform()
del srcImage

#Set the input variables and open the CSV file
n = 2000 #Max sample size from any given glacier
m = 100000 #Max vertices from any given glacier
stats_out = csv.writer(open(StatOut, 'wb'), lineterminator='\r\n')
stats_out.writerow(['WSID', 'Nr_Verts', 'MeanDist', 'MinDist', 'MaxDist', 'StdDist', 'MedianDist'])
PT_Proc = 'Y'
if SPECTRAL == 'N':
    clipped_spec = 'NULL'

for feature in layer:
    #Watershed ID field from the watersheds shapefile used for naming the output files
    wsid = feature.GetField('WSID')
    if PT_Proc == 'N':
        #If not using a point feature, will process all watersheds
        clipped_man = Feat_To_Subset(feature,cs_in,'Man',Manual)
        clipped_auto = Feat_To_Subset(feature,cs_in,'Auto',Automatic)
        if SPECTRAL == 'Y':
            clipped_spec = Feat_To_Subset(feature,cs_in,'Spec',Spectral)
    if PT_Proc == 'Y':
        #If using a point file, only certain shapes will be selected
        clipped_pts = Feat_To_Subset(feature,cs_in,'Pts',POINTS)

        man = Intersector(clipped_pts,Manual,'Man',cs_in)
        auto = Intersector(clipped_pts,Automatic,'Auto',cs_in)
        if SPECTRAL == 'Y':
            spec = Intersector(clipped_pts, Spectral, 'Spec', cs_in)

        clipped_man = Feat_To_Subset(feature,cs_in,'Man',man)
        clipped_auto = Feat_To_Subset(feature,cs_in,'Auto',auto)
        if SPECTRAL == 'Y':
            clipped_spec = Feat_To_Subset(feature,cs_in,'Spec',spec)

        driver.DeleteDataSource(man)
        driver.DeleteDataSource(auto)
        if SPECTRAL == 'Y':
            driver.DeleteDataSource(spec)
        driver.DeleteDataSource(clipped_pts)
    #Once the single-glacier shapefiles are made, run stats on the vertices
    Mean, Min, Max, Std, Median, NrVerts = Statmaker(wsid,clipped_man,clipped_auto,clipped_spec)
    stats_out.writerow([wsid, NrVerts, Mean, Min, Max, Std, Median])
    #Now generate the elevation distributions
    HistWrite(wsid,clipped_man,'Manual')
    HistWrite(wsid,clipped_auto, 'Auto')
    #Remove TMP files
    if SPECTRAL == 'Y':
        HistWrite(wsid,clipped_spec, 'Spectral')
    driver.DeleteDataSource(clipped_man)
    driver.DeleteDataSource(clipped_auto)
    if SPECTRAL == 'Y':
        driver.DeleteDataSource(clipped_spec)
#Free up memory
del DEM, stats_out
dataSource.Destroy()


