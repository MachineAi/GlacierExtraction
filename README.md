GlacierExtraction
=================

Scripts for Glacier Mapping as outlined in the paper: 'Improving Semi-Automated Glacial Mapping with a Multi-Method Approach: Areal Changes in the Tien Shan

This readme provides documentation for the suite of scripts and configuration files for glacier outline extraction described in 'Improving Semi-Automated Glacial Mapping with a Multi-Method Approach: Areal Changes in the Tien Shan' by Smith, Bookhagen, and Cannon. Scripts developed by Taylor Smith and Bodo Bookhagen, April 2014.

(1) Configuration Files
(a) Extract.conf
    This file contains the main variables used in the 'Glacier_Outline_Extraction.py' script. The File Paths must be in the format C:\PATH\PATH.tif or other image format, or pointing to folders/directories. 
        (i) SRTM, or other DEM file, as a raster
        (ii) Either NULL for calculating slope rasters during each iteration, or a .tif file pointing to a slope raster
        (iii) River centerlines, in raster format
        (iv) Lake outlines, in raster format. Pre-generated before running the script as 'training' datasets
        (v) Debris outlines, in raster format, if manual debris points are included. 
        (vi) Directory of velocity measurements, named with the convention \VelocityDirectory\PATH_ROW_Normed.tif. This can be modified in the python code if an alternate naming scheme is desired on line 100. 
        (vii) Directory of projection files used. Named in the script with \ProjectionDirectory\WGS 1984 UTM Zone UTMZONE N.prj. Can be modified for other regions by changing line 74 in the Python code. 
(b) Example_Threshold_File.csv
    This file is named according to path/row combinations. The file will be placed in the 'Procdir' path, defined in the Python code on line 21. Files will be named 'Threshold_PATH_ROW.csv', and will contain the first line #,#,#,# which define Elevation cutoff, Minimum velocity, Maximum Velocity, and NDVI cutoffs. One threshold file is required for each PATH/ROW combination, and all threshold files must be in the same directory.
    
(2) Scripts
(a) Python Script - Glacier_Outline_Extraction.py
    This script is the only script which needs to be run. Before running this script, several directory variables must be set up, on lines 14 - 21. These define which folders the output datasets will be saved to, and where the data will be pulled from. Further explanation can be found in the script. 
    This script has been developed and tested under Python 2.7, and requires the Arcpy Module, with the Spatial Analyst extension. It also requires the modules 'sys, os, string, csv, numpy, glob, datetime, solar, time, subprovess, math, and traceback'. Most of these come installed with a basic Python installation. 
    
(b) Matlab Script - Lake Extraction
    There are no variables which need to be modified within this script, although tweaking some variables for individual study areas may enhance results. The script has been extensively tested in Central Asia.
    This script has been developed and tested under Matlab 2012b. 
    
(c) Matlab Script - Glacier Extraction
    There are no variables which need to be modified within this script, although tweaking some variables for individual study areas may enhance results. The script has been extensively tested in Central Asia.
    This script has been developed and tested under Matlab 2012b. 
