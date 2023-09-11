%Plot critical Points New
clear all
close all
clc

currentFolder =  pwd;
parentFolder = fileparts(currentFolder);
load([parentFolder '/Fig4/model_all.mat'])

load([parentFolder '/test.mat'])

%%

LWidth = .5;
fontSize = 14;
limits = [10^-5.1 10^2.1 10^-10 10^2];

yObsSigmaOrig = (10.^yObsSigma).*(modKeySigma.^modulusAdj); 



%% Plot Decision Policy


%%First LHS Pass

%Get edges from database
load TISC150e01.mat


    

    
%% Set up limits for LHS

wallThickness = [0.7;1];
c1 = [0;1.2];
c2 = [-1;1];
twist = [0;.1];
wallAngle = [0;75];
wavelength = [0;.05];
amplitude = [0;1];
targetHeight = [10;45];
targetMassPH = [.05;.3];
logmod = log(filamentIDT.CylinderModulus(141));
logstress25 = log(filamentIDT.Stress25(141));
density = 1.2;

% Get points from LHS
numPts = 1e6;
boundaries = [c1,c2,c1,c2,twist,wallThickness,wavelength,amplitude,wallAngle,targetMassPH,targetHeight];

% Find target point
[~,idx] = max(yObsKS);
targetPoint = xObs(idx,:);


% Get points from LHS near target point
rangeBound = diff(boundaries);
offset = (rangeBound .* 0.5)./2;
boundaries2 = targetPoint([1:6,8:11,14]) + offset .* [-1;1];
boundaries2(1,:) = max([boundaries(1,:);boundaries2(1,:)]);
boundaries2(2,:) = min([boundaries(2,:);boundaries2(2,:)]);
for i = 1:size(boundaries2,2)
    if boundaries2(1,i) > boundaries2(2,i)
        boundaries2(:,i) = boundaries(:,i);
    end
end
boundaries = boundaries2;
returnPts = LHSsampling(numPts,boundaries);

inT = inpolygon(returnPts(:,1),returnPts(:,2),tOutline(:,1),tOutline(:,2));
inT2 = inpolygon(returnPts(:,3),returnPts(:,4),tOutline(:,1),tOutline(:,2));
output = returnPts(inT&inT2,:);

output2 = [output(:,1:6),...
    ones(size(output,1),1).*logmod,...
    output(:,7:10),...
    ones(size(output,1),2).*[logstress25,density],...
    output(:,11)];


yMuKs1 = predict(mdlKSzoom,output2);
yMuSigma1 = predict(mdlSigmaZoom,output2);
yMuSigma1 = (10.^yMuSigma1).*(filamentIDT.CylinderModulus(141).^modulusAdj); 




%% Set up limits for LHS


% Find target point
[~,idx] = max(yMuKs1);
targetPoint = output2(idx,:);


% Get points from LHS near target point
boundaries = [c1,c2,c1,c2,twist,wallThickness,wavelength,amplitude,wallAngle,targetMassPH,targetHeight];
rangeBound = diff(boundaries);
offset = (rangeBound .* 0.05)./2;
boundaries2 = targetPoint([1:6,8:11,14]) + offset .* [-1;1];
boundaries2(1,:) = max([boundaries(1,:);boundaries2(1,:)]);
boundaries2(2,:) = min([boundaries(2,:);boundaries2(2,:)]);
for i = 1:size(boundaries2,2)
    if boundaries2(1,i) > boundaries2(2,i)
        boundaries2(:,i) = boundaries(:,i);
    end
end
boundaries = boundaries2;
returnPts = LHSsampling(numPts,boundaries);

inT = inpolygon(returnPts(:,1),returnPts(:,2),tOutline(:,1),tOutline(:,2));
inT2 = inpolygon(returnPts(:,3),returnPts(:,4),tOutline(:,1),tOutline(:,2));
output = returnPts(inT&inT2,:);

output = [output(:,1:6),...
    ones(size(output,1),1).*logmod,...
    output(:,7:10),...
    ones(size(output,1),2).*[logstress25,density],...
    output(:,11)];


yMuKs2 = predict(mdlKSzoom,output);
yMuSigma2 = predict(mdlSigmaZoom,output);
yMuSigma2 = (10.^yMuSigma2).*(filamentIDT.CylinderModulus(141).^modulusAdj); 


%%

fig = figure()
hold on
grid on



scatter(yObsSigmaOrig,yObsKS,3,'k','Filled')
 
%Format plot
axis([.00004,30,0,.8])
set(gca,'XScale','log')
xlabel('{\it y}_1')
ylabel('{\it y}_2')
set(gca,'Ytick',0:.2:1)
set(gca,'Xtick',logspace(-4,2,7))


% Format and save
set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
width_in = 3.5;  
height_in = 2;    %Golden ratio size 
set(gca,'TickLength',[.0125,.01]) 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.07,0.15,.88,.8]); 
print('-dpng','-r300','CriticalPoints.png')


%Plot first LHS
ylabel('')
yticklabels('')
scatter(yMuSigma1,yMuKs1,3,[255,190,79]./255,'Filled')
xlim([.1,10])

width_in = 3.5/2;  
set(gca,'TickLength',[.0125,.01])
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.07,0.15,.88,.8]); 
print('-dpng','-r300','CriticalPoints2.png')



% Plot second LHS
scatter(yMuSigma2,yMuKs2,3,[170,129,52]./255,'Filled')



set(gca,'TickLength',[.0125,.01])
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.07,0.15,.88,.8]); 
print('-dpng','-r300','CriticalPoints3.png')





