function Lake_Extraction(TM1_r, TM4_r, Mask_r, outpath, tracerLakes, Slope_r, EPSG)
%LakeExtract - Lake extraction via Landsat Band Ratios
%   LakeExtract(TM1, TM4, Mask, outpath, TracerLakes, Slope) 
%   returns a TIF file delineating lake areas in a given scene. 
%   Functions by checking band ratios in a set of training lakes 
%   (TracerLakes) and using them to delineate other lakes.

%Created by Taylor Smith, June 2014, V 0.1

[TM1, refmat, bbox] = geotiffread(TM1_r); %Read in datasets
TMinfo = geotiffinfo(TM1_r);
TM1 = single(TM1); %Integerize
idx0 = find(TM1 <= 0); TM1(idx0) = NaN; %Recast nodata as NaN
disp('TM1 Loaded')

[TM4, refmat, bbox] = geotiffread(TM4_r);
TM4 = single(TM4); %Integerize
idx0 = find(TM4 <= 0); TM4(idx0) = NaN; %Recast nodata as NaN
disp('TM4 Loaded')

[Mask, refmat, bbox] = geotiffread(Mask_r);
Mask = single(Mask); %Integerize
idx0 = find(Mask <= 0); Mask(idx0) = NaN; %Recast nodata as NaN
disp('Mask Loaded')

Ratio = (TM4 - TM1)./(TM4 + TM1); %NDWI to identify lakes
clear TM4 bbox idx0
disp('Bands Ratiod')

[LakeT, refmat, bbox] = geotiffread(tracerLakes); %Read in manually classified lakes as training
LakeT = single(LakeT);
target = find(LakeT == 1);
LTemp = Ratio;
LRatio = nanmean(LTemp(target)) + 0.05; %Add buffer for sediment-laden lakes. Can be removed if lakes are highly constrained
clear LakeT bbox refmat idx0 LTemp target

ratioidx = find(Ratio < LRatio); % Identify lakes based on NDWI
Maskidx = find(Mask > 0);

TM1(ratioidx) = 1; %Remove misclassified areas in shadow
TM1(Maskidx) = NaN;
clear ratioidx Maskidx Mask Ratio
restidx = find(TM1 > 1);
TM1(restidx) = NaN;
clear restidx

[Slope, refmat, bbox] = geotiffread(Slope_r);
Slope = single(Slope); %Integerize
idx0 = find(Slope <= 0); Slope(idx0) = NaN;
disp('Slope Loaded')
clear idx0 

Slopeidx = find(Slope > 5); %Identify slopes greater than 5 degrees and remove lakes
TM1(Slopeidx) = NaN;
clear Slope Slopeidx 

B3 = int16(TM1);
B4 = reshape(B3, TMinfo.Height, TMinfo.Width); %Reshape to save out
clear B3

EPSG = str2num(EPSG);
geotiffwrite(outpath, B4, TMinfo.SpatialRef, 'CoordRefSysCode', EPSG);% TMinfo.GeoTIFFCodes.PCS);
disp(strcat(outpath,' created.'))
exit
