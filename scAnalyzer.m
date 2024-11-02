% scAnalyzer 2.4.0
% 11/02/2024
% Pei Su, Kelleher Research Group
% Northwestern University
% pei.su@northwestern.edu

% 2.4 adds the y axis grid definition, making microMS feature picking
% more precise; tolerance for scan picking around the apex is widened to
% capture more scans into the single cell feature; summary variable was
% added to ease output summary construction
%2.4.1.1 was just for the new dataset
clear
clc

%% statistical modeling for estimation of expected single cell features in scPiMS dataset
% define total dimension
x_pixel = 18/0.2;
y_pixel = 13/0.2;

% simulate the number of features using microMS coordinates
coord = readmatrix("put full path of the xy coordinates of the optical features here");
microMScount = numel(coord(:,1));

scatter(coord(:,1),coord(:,2));
probeSize_x = (max(coord(:,1))-min(coord(:,1)))/x_pixel;
probeSize_y = (max(coord(:,2))-min(coord(:,2)))/y_pixel;
[N,c] = hist3(coord,'Ctrs',{min(coord(:,1)):probeSize_x:max(coord(:,1)) min(coord(:,2)):probeSize_y:max(coord(:,2))});
totalGrids = round(x_pixel) * round(y_pixel);
N = reshape(N,[numel(N),1]);
k = find(N(:)==0);
no = numel(k);
N(N(:)==0) = [];
counts = tabulate(N);
singleFeature = counts(1,2);
doubleFeature = counts(2,2);
multipleFeature = sum(counts(3:end,2));
noFeature = totalGrids - singleFeature - doubleFeature - multipleFeature;
totalFeature = singleFeature + doubleFeature + multipleFeature;

%% single cell feature extraction
% Define parameters
%scanRate = 30; % 30um/s
%msRate = 1; % 1spectrum/s
%adjacentFeatureDistance = round(200/(scanRate*msRate)); % 150um at minimum, determined by the probe size
lefthalfPeakPoint = 2;
righthalfPeakPoint = 5;
countThres = 800;
%rasterRate = 40;
%gridScanNum = 200/rasterRate;
cellogram = 8; % extraction kinetics

% Import ion table data WITH R^2>0.999 for single cell feature picking (best SNR performance)
%profile = readmatrix('ionDat.csv');

% Import temporal profile from ScanIonCount tab
profile = readmatrix("Chronogram_16_2nd_50_6.csv");
% The columns in an STORIBoard export is:
% Stori Group|Scan|Raw Ion Count|Processed Ion Count|Charge Assigned Ion
% Count|Raw Ion Percent|Processed Ion Percent|Charge Assigned Ion Percent
profile(:,7:end) = [];
profile(:,4:5) = [];
profile(:,1:2) = [];
profile = sortrows(profile,1,"ascend");

% fix the issue with scanNumber not starting from 1
if profile(1,1) > 1
    profile(:,1) = profile(:,1) - profile(1,1) + 1;
end

profile(1:4,2) = 0;
profile(end+1:end+5+righthalfPeakPoint,:) = 0;

% Obtain scan number and Processed Ion Count
%profile(:,1) = dat(:,2);
%profile(:,2) = dat(:,4);

%for i = 1:numel(dat(:,1))
    %yes = ismember(dat(i,1),profile(:,1));
    %if yes == 0 
        %profile(end+1,1) = dat(i,1);
    %else
    %end
%end

%profile = sortrows(profile,1,"ascend");

% Initial peak picking with threshold
[intensity,peakPosition] = findpeaks(profile(:,2),'MinPeakHeight',countThres,'MinPeakDistance',cellogram);
chronogram(:,2)  = intensity;
chronogram(:,1)  = peakPosition;

% derivative, check how many negative values following the peak
% could be a useful idea to test in the future but not really for now
%first_d = gradient(profile(:,2)./profile(:,1));

% peak picking
% use decay profile under the experimental conditions to filter out
% overlapping features
% A majority of the features are 4-scan decay profiles with the second
% scan as the peak. The third scan typically decays to half but cannot be
% more than the fourth that still haven't dropped below half max.
for i = 1:size(chronogram,1)
    if profile(peakPosition(i)+righthalfPeakPoint,2)>0.5*profile(peakPosition(i),2)
        chronogram(i,1) = 0;
    else 
    end
end

chronogram(chronogram(:,1)==0,:) = [];

%x_values = 0:50:2500;
%[N,~] = histcounts(chronogram(:,2),'Binwidth',50);
%N = N';
%x = fitdist(N, 'Poisson');
%hold on
%pdf = pdf(x, x_values);
%plot(x_values, pdf)

% pick single cell feature scans within each FWHM
for i=1:numel(chronogram(:,1))
feature = zeros(lefthalfPeakPoint+righthalfPeakPoint,2);
feature(:,1:2) = profile((chronogram(i,1)+1-lefthalfPeakPoint):(chronogram(i,1)+righthalfPeakPoint),1:2);
peakFeature = max(feature(:,2));
feature(feature(:,2)<0.05*peakFeature,:)=[]; %0.05 rel abd to peak is about the noise level
minScan = min(feature(:,1));
maxScan = max(feature(:,1));
clear feature
feature(:,1:2) = profile(minScan:maxScan,1:2);
featureScans{i}(:,1) = feature(:,1);
featureScans{i}(:,2) = feature(:,2);
featureScans{i}(:,3) = i;
clear feature
end

% single cell feature ion count
for i = 1:numel(chronogram(:,1))
    featureSum(i) = sum(featureScans{1,i}(:,2));
end

featureScansList = vertcat(featureScans{:});
featureExport = featureScansList;
featureExport(:,2) = [];

summary = [numel(chronogram(:,1)), numel(peakPosition)];
%summary = [numel(chronogram(:,1)), numel(peakPosition), microMScount, singleFeature, multipleFeature];

cHeader = {'ScanIndex' 'FeatureIndex'}; %dummy header
textHeader = strjoin(cHeader,'\t');
writematrix(textHeader,'Feature_list_14.csv');
writematrix(featureExport,'Feature_list_14.csv','WriteMode','append');
fprintf('Data Written\n');

