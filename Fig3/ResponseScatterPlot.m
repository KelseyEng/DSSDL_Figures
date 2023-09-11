%Densification Strain vs. K_s
clear all
close all
clc

currentFolder =  pwd;
parentFolder = fileparts(currentFolder);
load([parentFolder,'/test.mat'])


%%

[~,idxMax] = max(T.CriticalEfficiency);

xObsList = [T.C2T,log(T.Stress25)];
                    
varNames = {'C2T','Log(Stress25)'}; 

for i = 1:size(xObsList,2)
    figure
    colormap(colormap(flipud(gray)))
    scatter(xObsList(:,i),T.CriticalEfficiency,3,T.ADTS_ID,'Filled')
    hold on
%     scatter(xObsList(idxMax,i),T.CriticalEfficiency(idxMax),10,'r','Filled')
    idx = 10800;
    scatter(xObsList(idx,i),T.CriticalEfficiency(idx),100,'pentagram','MarkerFaceColor',[46,130,219]./255,'MarkerEdgeColor','w')
    xlabel(sprintf('{\\it x}_%d',i))
    ylabel('{\it y}')
    caxis([-max(T.ADTS_ID)/2,max(T.ADTS_ID)])

   
    set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
    width_in = 3.5;
    height_in = 2;
    set(gca,'TickLength',[.0125,.01]) 
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'PaperPosition', [0 0 width_in height_in]);
    % set(gca,'position',[0.07,0.15,.88,.8]); 
    print('-dpng','-r300',sprintf('ResponseScatter%d.png',i))
end

