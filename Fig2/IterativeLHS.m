clear all
close all
clc

rng(2)

ptSize = 3;

dim = 2;
numPts = 25;

% Divide space into equal boxes
ptsPerDim = numPts.^(1/dim);
boundPts = linspace(0,1,ptsPerDim+1);
deltaPts = boundPts(2)-boundPts(1);

% Get list of initial points (lower left) for each square
returnPts = combvec(boundPts(1:end-1),boundPts(1:end-1))';

% Apply random offset 
offSet = rand(size(returnPts));
returnPts1 = returnPts+offSet.*deltaPts;

fig1 = figure;
hold on
% Plot boundaries
for i = 1:(ptsPerDim-1)
    xline(deltaPts*i)
    yline(deltaPts*i)    
end
scatter(0.5,0.5,'k*')
    
% Plot points
scatter(returnPts1(:,1),returnPts1(:,2),ptSize,[255,190,79]./255,'LineWidth', .75)

set(gcf,'color','w');

% select high performer (distance from (0.5,0.5)
dist = vecnorm(returnPts1-[0.5,0.5],2,2);
[~,idx] = min(dist);
scatter(returnPts1(idx,1),returnPts1(idx,2),ptSize,[255,190,79]./255,'filled')

xlabel('x_1')
ylabel('x_2')
set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
set(gca,'Layer','Top')

width_in = 1.625;  
height_in = 1;    %Golden ratio size 
set(gca,'TickLength',[.025,.01]) 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.05,0.1,.92,.85]); 
print('-dpng','-r300','LHS1.png')

%% second iteration
fig2 = figure;
hold on
% Plot boundaries
for i = 1:(ptsPerDim-1)
    xline(deltaPts*i)
    yline(deltaPts*i)    
end
scatter(0.5,0.5,'k*')

% Plot points
scatter(returnPts1(:,1),returnPts1(:,2),ptSize,[255,190,79]./255,'LineWidth', .75)
set(gcf,'color','w');

% select high performer
dist = vecnorm(returnPts1-[0.5,0.5],2,2);
[~,idx] = min(dist);
scatter(returnPts1(idx,1),returnPts1(idx,2),ptSize,[255,190,79]./255,'filled')

% Apply random offset 
windowSize = 0.3;
offSet = rand(size(returnPts));
returnPts2 = returnPts.*windowSize + offSet.*deltaPts.*windowSize;
targetPt = returnPts1(idx,:);
returnPts2 = returnPts2+targetPt-[1,1].*windowSize/2;
scatter(returnPts2(:,1),returnPts2(:,2),ptSize,[170,129,52]./255,'LineWidth', .75)

%Find new max
dist = vecnorm(returnPts2-[0.5,0.5],2,2);
[~,idx] = min(dist);
scatter(returnPts2(idx,1),returnPts2(idx,2),ptSize,[170,129,52]./255,'filled')


xlabel('x_1')
ylabel('x_2')
set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
set(gca,'Layer','Top')

width_in = 1.625;  
height_in = 1;    %Golden ratio size 
set(gca,'TickLength',[.025,.01]) 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.05,0.1,.92,.85]); 
print('-dpng','-r300','LHS2.png')


%% Random

randPts = rand(numPts,2);

fig3 = figure;
hold on
% Plot boundaries
for i = 1:(ptsPerDim-1)
    xline(deltaPts*i)
    yline(deltaPts*i)    
end
scatter(0.5,0.5,'k*')

% Plot points
scatter(randPts(:,1),randPts(:,2),ptSize,[255,190,79]./255,'LineWidth', .75)
set(gcf,'color','w');

%Find new max
dist = vecnorm(randPts-[0.5,0.5],2,2);
[~,idx] = min(dist);
scatter(randPts(idx,1),randPts(idx,2),ptSize,[255,190,79]./255,'filled')

xlabel('x_1')
ylabel('x_2')
set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
set(gca,'Layer','Top')

width_in = 1.625;  
height_in = 1;    %Golden ratio size 
set(gca,'TickLength',[.025,.01]) 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.05,0.1,.92,.85]); 
print('-dpng','-r300','RandomSelection.png')


%% Grid 

fig3 = figure;
hold on
% Plot boundaries
for i = 1:(ptsPerDim-1)
    xline(deltaPts*i)
    yline(deltaPts*i)    
end
scatter(0.5,0.5,'k*')

% Plot points
scatter(returnPts(:,1)+deltaPts,returnPts(:,2)+deltaPts,ptSize,[255,190,79]./255,'LineWidth', .75)
set(gcf,'color','w');

%Find new max
dist = vecnorm(returnPts+deltaPts-[0.5,0.5],2,2);
[~,idx] = min(dist);
scatter(returnPts(idx,1)+deltaPts,returnPts(idx,2)+deltaPts,ptSize,[255,190,79]./255,'filled')

xlim([0,1])
ylim([0,1])
xlabel('x_1')
ylabel('x_2')
set(gca,'FontSize',8,'FontName','Arial','FontWeight','Bold','LineWidth',1,'XColor','k','YColor','k') 
set(gca,'Layer','Top')

width_in = 1.625;  
height_in = 1;    %Golden ratio size 
set(gca,'TickLength',[.025,.01]) 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width_in height_in]);
% set(gca,'position',[0.05,0.1,.92,.85]); 
print('-dpng','-r300','GridSelection.png')


%% Legend
figure
scatter(1,1,[255,190,79]./255)
hold on
scatter(1,1,[255,190,79]./255,'filled')
scatter(1,1,[170,129,52]./255)
legend('Initial Sampling Points','Highest Performer from Initial Batch','Second Round of Sampling Points')

