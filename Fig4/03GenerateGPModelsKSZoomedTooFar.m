% Generates GP models that will be used in other parts of the work.
% WARNING: This can take a long time to run

%
close all;clear all;clc

currentFolder =  pwd;
parentFolder = fileparts(currentFolder);
load([parentFolder,'/test.mat'])

%% Prepare Data for Training


% Generate list of input space (xObs)
xObs = [T.C1T,...
        T.C2T,...
        T.C1B,...
        T.C2B,...
        T.Twist,...
        T.WallThickness,...
        log(T.FilamentModulus),...
        T.Wavelength,...
        T.Amplitude,...
        T.WallAngle,...
        T.TargetMass./T.TargetHeight,...
        log(T.Stress25),...
        T.Density,...
        T.TargetHeight];
                    
% Generate output target 1 (yObs)
yObsKS = T.CriticalEfficiency;


%% Zoom in on desired data based on previous best experiment (max(yObs))
% Find max point
[~,idxMax]= max(yObsKS);
xMax = xObs(idxMax,:);

% Find distance of each point from target
normVal = range(xObs);
normVal(normVal == 0) = 1;
dist = vecnorm((xObs-xMax)./normVal,2,2);

% apply filter based on distance
focusRad = .05;
idx = dist < focusRad;
xObsZoom2 = xObs(idx,:);
yObsKSZoom2 = yObsKS(idx);



%% Train Model
                    
gprMdlKSZoom2 = fitrgp(xObsZoom2,yObsKSZoom2,...
            'FitMethod','exact',...
            'BasisFunction', 'constant', ...
            'KernelFunction', 'ardsquaredexponential',...
            'Standardize',false);
        
        
   
                    
save model_Zoomed2_KS.mat        
                    
                    
                    
                    
                    
                    
                    