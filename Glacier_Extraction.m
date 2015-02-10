function Glacier_Extraction(csvfile)
%GlacExtract(csvfile)
%   This function performs glacier extraction via Landsat Band comparisons. 
%   It requires an extensive set of input datasets, read from a CSV. These
%   are TM1, TM3, TM4, TM5, TM7, Shadow Mask, Base Export Path, Lakes from 
%   Lake_Extraction, Slope, Elevation, River Network, Manual Debris, Velocity, 
%   and a CSV containing thresholds for the region.

%Created by Taylor Smith, Feb 2015, V 0.2

%% Data read-in
fid = fopen(csvfile, 'r'); %Read attributes from a csv
nextLine = fgetl(fid);
Cells = strsplit(nextLine, ',');
TM1_r = Cells{1};
TM3_r = Cells{2};
TM4_r = Cells{3};
TM5_r = Cells{4};
TM7_r = Cells{5};
Mask_r = Cells{6};
Glac_Base = Cells{7};
Out_Lakes = Cells{8};
Slope_r = Cells{9};
Elev_r = Cells{10};
Riv_r = Cells{11};
TraceDebris_r = Cells{12};
Vel_r = Cells{13};
Attscsv = Cells{14};
EPSG = str2num(Cells{15});
fclose(fid);

fid = fopen(Attscsv, 'r'); %Pull elevation, min and max velocity, and NDVI threshold for each individual Landsat scene
nextLine = fgetl(fid);
Cells = strsplit(nextLine, ',');
try
    ElevThreshold = str2double(Cells{1});
    MinVelocity = str2double(Cells{2});
    MaxVelocity = str2double(Cells{3});
    NDVIThreshold = str2double(Cells{4});
catch
    ElevThreshold = Cells(1);
    MinVelocity = Cells(2);
    MaxVelocity = Cells(3);
    NDVIThreshold = Cells(4);
end
fclose(fid);

%% Pure Glacial Delineation
[TM3, refmat, bbox] = geotiffread(TM3_r);
TM3 = single(TM3); %Integerize
idx0 = find(TM3 <= 0); TM3(idx0) = NaN; %Recast nodata as NaN

[TM5, refmat, bbox] = geotiffread(TM5_r);
TM5 = single(TM5); %Integerize
idx0 = find(TM5 <= 0); TM5(idx0) = NaN; %Recast nodata as NaN

Ratio = TM3./TM5; %Create the ratio of TM3/TM5
disp('Bands Ratiod')
clear TM5 bbox idx0 TM3
TMinfo = geotiffinfo(TM1_r);

[TM1, refmat, bbox] = geotiffread(TM1_r);
TMinfo = geotiffinfo(TM1_r);
TM1 = single(TM1); %Integerize
idx01 = find(TM1 <= 0); TM1(idx01) = NaN; %Recast nodata as NaN

ratioidx = find(Ratio >= 2 & TM1 > 60); %Use both the ratio and TM band 1 to pull out glaciated areas.
% This calculation is very bad at pulling thick debris cover, so the rest of this script works to identify debris cover
TM1(ratioidx) = 1;
clear ratioidx bbox idx01 Ratio

%[Mask, refmat, bbox] = geotiffread(Mask_r); %Mask out shadows
%Mask = single(Mask); %Integerize
%idx0 = find(Mask <= 0); Mask(idx0) = NaN; %Recast nodata as NaN
%disp('Mask Loaded')

[Lake, refmat, bbox] = geotiffread(Out_Lakes); %Mask out lakes
Lake = single(Lake); %Integerize
idx0 = find(Lake <= 0); Lake(idx0) = NaN; %Recast nodata as NaN
clear bbox idx0

Lakeidx = find(Lake == 1); %Create an index of just lakes
TM1(Lakeidx) = 1; %Temporarily add lakes to glacier dataset for processing
clear Lake 

restidx2 = find(TM1 > 1);
TM1(restidx2) = NaN;
restidx = find(TM1 > 0);

Ttmp = TM1;
Ttmp(Lakeidx) = NaN;

outpath = strcat(Glac_Base, '_spectral.tif');
geotiffwrite(outpath, int16(Ttmp), TMinfo.SpatialRef, 'CoordRefSysCode', EPSG) %Write out the spectral-only outlines for future processing
clear Ttmp

[Seeds, refmat, bbox] = geotiffread(TraceDebris_r); %Add manual seed points to index of glaciers
Seeds = single(Seeds);
Sidx = find(Seeds == 1); clear Seeds
TM1(Sidx) = 1; clear Sidx
testseed = find(TM1 > 0);
clear TM1 restidx2

%% Examine Debris Areas
% At this point, these are pure glacier outlines. Next find debris

[Slope, refmat, bbox] = geotiffread(Slope_r);
Slope = single(Slope); %Integerize
idx0 = find(Slope <= 0); Slope(idx0) = NaN;
disp('Slope Loaded')
clear idx0 

Slopeidx = find(Slope > 24); %Identify slopes between 1 and 24 degrees (After Paul et al., 2004)
Slope(Slopeidx) = NaN;
Slope2idx = find(Slope < 1);
Slope(Slope2idx) = NaN;
S = stdfilt(Slope, ones(9)); %Identify and remove areas of low slope variability (plains, riverbeds, etc)
Stdidx = find(S > 2);
Slope(Stdidx) = NaN;
clear S Stdidx
Slopeidxr = find(Slope > 0);
Slope(Slopeidxr) = 1;
clear Slope2idx Slopeidx Slopeidxr

[Elev, refmat, bbox] = geotiffread(Elev_r); %Filter for elevation. This can be set dependent on lowest glacier elevation in study region
Elev = single(Elev); %Integerize
idx0 = find(Elev <= 0); Elev(idx0) = NaN;
disp('Elev Loaded')
clear idx0 
elevmask = find(Elev < ElevThreshold); %Low elev, not glacier
Slope(elevmask) = NaN;
clear Elev refmat bbox 

[Riv, refmat, bbox] = geotiffread(Riv_r); %Read in rivers to remove mis-identified areas of wet soil
Riv = single(Riv); %Integerize
idx0 = find(Riv > 1); Riv(idx0) = NaN; 
Riv(elevmask) = NaN;
rivseed = find(Riv == 1); 
clear Riv refmat bbox

[Vel, refmat, bbox] = geotiffread(Vel_r); %Read velocity data
Vel = single(Vel);
idx0 = find(Vel < 0); Vel(idx0) = NaN;
idx1 = find(Vel > MaxVelocity); Vel(idx1) = NaN;
disp('Velocity Loaded')
velmask = find(Vel < MinVelocity); 
Slope(velmask) = NaN;
clear Vel refmat bbox idx0 idx1

%Use a distance weighting metric based on distance from rivers (center of valleys) to identify debris areas
T = graydist(Slope, rivseed); 
Tidx = find(T > 90); 
Slope(Tidx) = NaN; Slope(elevmask) = NaN;
clear Tidx T elevmask

seed2idx = find(Slope > 0);
Slope(seed2idx) = 1;
Slope(restidx) = NaN;
clear seed2idx rivseed
maskidx = isnan(Slope);

%% NDVI Masking
% maskidx = isnan(Slope);
% [TM3, refmat, bbox] = geotiffread(TM3_r);
% TM3 = single(TM3); %Integerize
% idx0 = find(TM3 <= 0); TM3(idx0) = NaN; %Recast nodata as NaN
% 
% [TM4, refmat, bbox] = geotiffread(TM4_r);
% TM4 = single(TM4); %Integerize
% idx0 = find(TM4 <= 0); TM4(idx0) = NaN; %Recast nodata as NaN
% 
% NDVI = (TM4 - TM3)./(TM4 + TM3); clear TM4 TM3 idx0 bbox refmat
% NDVI(maskidx) = NaN;
% NDVIdx = find(NDVI > NDVIThreshold); %Remove vegetated areas
% Slope(NDVIdx) = NaN;
% clear NDVI NDVIdx

%% Filter Overclassifications
%Debris maximum extent is now identified. The next steps try to remove misclassified areas

S2 = Slope; % Do a second distance weighting from only manual seed points and lakes
S2(restidx) = 1;
T2 = graydist(S2,testseed); 
T2idx = find(T2 > 400); 
Slope(T2idx) = NaN;
clear S2 T2 T2idx

%% Statistical Filtering
slopeidx = isnan(Slope); 
Slope(slopeidx) = 0; clear slopeidx
Slope_Filtered = medfilt2(Slope, [3 3]);
Slope_AO = ~bwareaopen(~Slope_Filtered, 100); %was 1000000 
clear Slope_Filtered Slope

% Add previous stuff back in 
Slope_AO(testseed) = 1;
Slope_AO(Lakeidx) = 1;
clear TM1 restidx Lakeidx testseed

Slope_Filt = medfilt2(Slope_AO, [3 3]); %Single median filter pass
disp('Pass 2 Done. Saving...')

[Elev, refmat, bbox] = geotiffread(Elev_r); %Filter for elevation. This can be set dependent on lowest glacier elevation in study region
Elev = single(Elev); %Integerize
idx0 = find(Elev <= 0); Elev(idx0) = NaN;
clear idx0 
elevmask = find(Elev < ElevThreshold); %Low elev, not glacier

Slope_Filt(elevmask) = 0;
clear elevmask Elev

Binary = im2bw(Slope_Filt, 0.1);
Final_Outlines = bwmorph(Binary, 'bridge');
clear BW
clear maskidx new new5 velmask
%Unbinary the output
Final_Outlines(isnan(Final_Outlines)) = 0;

outpath = strcat(Glac_Base, '.tif');
geotiffwrite(outpath, int16(Final_Outlines), TMinfo.SpatialRef, 'CoordRefSysCode', EPSG) %Write out the spectral-only outlines for future processing

exit