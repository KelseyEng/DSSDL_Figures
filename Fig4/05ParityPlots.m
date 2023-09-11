%% Parity Plots
clear all; close all; clc
load model_all.mat



idxP = 10809;
%% KS Parity Plot

sigmaML = mdlKS.KernelInformation.KernelParameters(1:end-1,1);
sigmaFL = mdlKS.KernelInformation.KernelParameters(end);
sigmaNL  = mdlKS.Sigma;

idxTrain = ones(length(yObsKS),1,'logical');
idxTrain(idxP) = 0;


gprMdl = fitrgp(xObs(idxTrain,:),yObsKS(idxTrain),...
        'FitMethod','none',...
        'PredictMethod','exact',...
        'BasisFunction', 'constant', ...
        'KernelFunction', 'ardsquaredexponential',...
        'KernelParameters',[sigmaML',sigmaFL],...
        'Sigma',sigmaNL,...
        'Standardize',false);

sigma_y = gprMdl.Sigma;    
    
yPredKS = predict(gprMdl,xObs);

rsEAE = corrcoef(yPredKS,yObsKS);
rsEAE = rsEAE(1,2)^2;

fig = figure();
hold on
plot([0,0.8],[0,0.8],'r-','LineWidth',2)
plot([0,0.8],[0,0.8]+sigma_y,'color',[1,.7,.7],'LineWidth',2)
plot([0,0.8],[0,0.8]-sigma_y,'color',[1,.7,.7],'LineWidth',2)
scatter(yObsKS,yPredKS,3,'k','Filled')
scatter(yObsKS(idxP),yPredKS(idxP),100,'pentagram','MarkerFaceColor',[46,130,219]./255,'MarkerEdgeColor','w')



axis equal
axis([0.5,0.8,0.5,0.8])


title(['r^2 = ',num2str(rsEAE)])

set(gca,'Layer','top');
xlabel('\boldmath$$y$$','Interpreter','Latex')
ylabel('\boldmath$$\tilde{y}$$','Interpreter','Latex')

set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
width_in = 3.25/2;
height_in = 3.25/2;
set(gca,'TickLength',[.0125,.01]) 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.07,0.15,.88,.8]); 
print('-dpng','-r300','ParityPlotKS.png')


axis([0,0.8,0,0.8])
set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
width_in = 3.25/2;
height_in = 3.25/2;
set(gca,'TickLength',[.0125,.01]) 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.07,0.15,.88,.8]); 
print('-dpng','-r300','ParityPlotKSLarge.png')



%% KSZoomed Parity Plot
idxP2 = find(yObsKS(idxP)==yObsKSZoom);

sigmaML = mdlKSzoom.KernelInformation.KernelParameters(1:end-1,1);
sigmaFL = mdlKSzoom.KernelInformation.KernelParameters(end);
sigmaNL  = mdlKSzoom.Sigma;

idxTrain = ones(length(yObsKSZoom),1,'logical');
idxTrain(idxP2) = 0;


gprMdl = fitrgp(xObsZoom(idxTrain,:),yObsKSZoom(idxTrain),...
        'FitMethod','none',...
        'PredictMethod','exact',...
        'BasisFunction', 'constant', ...
        'KernelFunction', 'ardsquaredexponential',...
        'KernelParameters',[sigmaML',sigmaFL],...
        'Sigma',sigmaNL,...
        'Standardize',false);

sigma_y = gprMdl.Sigma;    

yPredKSzoom = predict(gprMdl,xObsZoom);

rsEAE = corrcoef(yPredKSzoom,yObsKSZoom);
rsEAE = rsEAE(1,2)^2;

fig = figure();
hold on
plot([0,0.8],[0,0.8],'r-','LineWidth',2)
plot([0,0.8],[0,0.8]+sigma_y,'color',[1,.7,.7],'LineWidth',2)
plot([0,0.8],[0,0.8]-sigma_y,'color',[1,.7,.7],'LineWidth',2)
scatter(yObsKSZoom,yPredKSzoom,3,'k','Filled')
scatter(yObsKSZoom(idxP2),yPredKSzoom(idxP2),100,'pentagram','MarkerFaceColor',[46,130,219]./255,'MarkerEdgeColor','w')



axis equal
axis([0.5,0.8,0.5,0.8])


title(['r^2 = ',num2str(rsEAE)])

set(gca,'Layer','top');
xlabel('\boldmath$$y$$','Interpreter','Latex')
ylabel('\boldmath$$\tilde{y}$$','Interpreter','Latex')

set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
width_in = 3.25/2;
height_in = 3.25/2;
set(gca,'TickLength',[.0125,.01]) 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.07,0.15,.88,.8]); 
print('-dpng','-r300','ParityPlotKSZoom.png')

%% KSZoomed Too Far Parity Plot
idxP3 = find(yObsKS(idxP)==yObsKSZoom2);

sigmaML = mdlKSzoom2.KernelInformation.KernelParameters(1:end-1,1);
sigmaFL = mdlKSzoom2.KernelInformation.KernelParameters(end);
sigmaNL  = mdlKSzoom2.Sigma;

idxTrain = ones(length(yObsKSZoom2),1,'logical');
idxTrain(idxP3) = 0;


gprMdl = fitrgp(xObsZoom2(idxTrain,:),yObsKSZoom2(idxTrain),...
        'FitMethod','none',...
        'PredictMethod','exact',...
        'BasisFunction', 'constant', ...
        'KernelFunction', 'ardsquaredexponential',...
        'KernelParameters',[sigmaML',sigmaFL],...
        'Sigma',sigmaNL,...
        'Standardize',false);
    
sigma_y = gprMdl.Sigma;    
    
yPredKSzoom2 = predict(gprMdl,xObsZoom2);

rsEAE = corrcoef(yPredKSzoom2,yObsKSZoom2);
rsEAE = rsEAE(1,2)^2;

fig = figure();
hold on
plot([0,0.8],[0,0.8],'r-','LineWidth',2)
plot([0,0.8],[0,0.8]+sigma_y,'color',[1,.7,.7],'LineWidth',2)
plot([0,0.8],[0,0.8]-sigma_y,'color',[1,.7,.7],'LineWidth',2)
scatter(yObsKSZoom2,yPredKSzoom2,3,'k','Filled')
scatter(yObsKSZoom2(idxP3),yPredKSzoom2(idxP3),100,'pentagram','MarkerFaceColor',[46,130,219]./255,'MarkerEdgeColor','w')



axis equal
axis([0.5,0.8,0.5,0.8])


title(['r^2 = ',num2str(rsEAE)])

set(gca,'Layer','top');
xlabel('\boldmath$$y$$','Interpreter','Latex')
ylabel('\boldmath$$\tilde{y}$$','Interpreter','Latex')

set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
width_in = 3.25/2;
height_in = 3.25/2;
set(gca,'TickLength',[.0125,.01]) 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.07,0.15,.88,.8]); 
print('-dpng','-r300','ParityPlotKSZoom2.png')