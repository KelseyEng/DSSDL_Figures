%Plot critical Points New
clear all
close all
clc

currentFolder =  pwd;
parentFolder = fileparts(currentFolder);
load([parentFolder '/Fig4/model_all.mat'])

load([parentFolder '/test.mat'])

%%

rng(4)


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


[yMuKs1,ySDVks1] = predict(mdlKSzoom,output2);



%% Plot Distance Plots
lambdas = [0,1,5,25];
for i = 1:4
    lambda = lambdas(i);

    [~,idx] = max(yMuKs1 + lambda * ySDVks1);
    yMu = yMuKs1(idx);

    xNew = output2(idx,:);



    fig = figure();
    % Plot all points
    minVal = min(xObs);
    rangeVal = range(xObs);
    rangeVal(rangeVal == 0) = 1;

    xObsNorm = (xObs-minVal)./rangeVal;
    xNewNorm = (xNew-minVal)./rangeVal;
    distVec = vecnorm(xObsNorm-xNewNorm,2,2);


%     scatter(distVec,yObsKS,3,'k','filled')
    hold on

    % Plot points used in zoomed GP
    xObsZoomNorm = (xObsZoom-minVal)./rangeVal;
    xNewNorm = (xNew-minVal)./rangeVal;
    distVec = vecnorm(xObsZoomNorm-xNewNorm,2,2);
    scatter(distVec,yObsKSZoom,3,'k','filled')
    scatter(0,yMu,100,'pentagram','MarkerFaceColor',[46,130,219]./255,'MarkerEdgeColor','w')
    
    % format plot
    xlabel('\rho')
    ylabel('{\it y}')
%     set(gca, 'XScale', 'log')
    xlim([-0.1,0.8])
    xticks([0:.2:.8])

    % Save plot
    set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
    width_in = 3.25/2;
    height_in = 3.25/2;
    set(gca,'TickLength',[.0125,.01]) 
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperPosition', [0 0 width_in height_in]);
    title(sprintf('\\lambda = %d',lambda))
    % set(gca,'position',[0.07,0.15,.88,.8]); 
    print('-dpng','-r300',sprintf('distancePlot%d.png',i))
    
end











