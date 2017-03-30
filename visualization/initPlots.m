%% Initialize all plots
runFigure = figure;

%% Optimization

% Fitness
fit2err = 1./fit; % MSE
fitGraph = subplot(5,3,[1,2,4,5]);hold off;
fitGraph.UserData.fitMean = semilogy([1:cfg.gen],mean(fit2err),'k-','LineWidth',2);
hold on;
fitGraph.UserData.fitBot = semilogy([1:cfg.gen],median(fit2err),'b-','LineWidth',2);
fitGraph.UserData.fitTop = semilogy([1:cfg.gen],[elite.error],'g-','LineWidth',2);
fitGraph.UserData.fitBestTest = semilogy([1:cfg.gen],[elite.error_test],'r-','LineWidth',2);
xlabel('Generation');ylabel('MSE');
title('MSEs of Population','FontSize',12);
legend('Mean', 'Median', 'Elite Train', 'Elite Test', 'Location','SouthWest');
axis([1 cfg.gen 10^-3 1]);
grid on;

% Fitness Components
componentGraph = subplot(5,3,[7,8,10,11,13,14]);

%% Pole Balancing
if strcmp(func2str(cfg.data.fitFun), 'twoPole_test')
    stepMean = plot([1:cfg.gen],mean(steps),'k-','LineWidth',2);
    stepTop = jbfill([1:cfg.gen],max(steps),median(steps),'g','k',1,0.2);
    stepBot = jbfill([1:cfg.gen],median(steps),min(steps),'b','k',1,0.2);
    title('Time Steps completed');
else
    if cfg.recurrent == false; plotNet(elite(end)); end;
end

%% Complexity
% Number of Nodes
nodeGraph = subplot(5,3,3);
jbfill([1:cfg.gen],max(nodes),median(nodes),'g','k',1,0.2);
jbfill([1:cfg.gen],median(nodes),min(nodes),'b','k',1,0.2);
hold on;
plot([1:cfg.gen],eliteNodes,'r-','LineWidth',2);
set(nodeGraph,'XLim',[2,cfg.gen])
xlabel('');ylabel('Nodes');

% Number of Connections
connectionGraph = subplot(5,3,6);
jbfill([1:cfg.gen],max(conns),median(conns),'g','k',1,0.2);
jbfill([1:cfg.gen],median(conns),min(conns),'b','k',1,0.2);
hold on;
plot([1:cfg.gen],eliteConns,'r-','LineWidth',2);
set(connectionGraph,'XLim',[2,cfg.gen])
xlabel('Generation');ylabel('Connections');

% Mean Weight
weightGraph = subplot(5,3,9);
jbfill([1:cfg.gen],max(meanAbsWeights),median(meanAbsWeights),'g','k',1,0.2);
jbfill([1:cfg.gen],median(meanAbsWeights),min(meanAbsWeights),'b','k',1,0.2);
hold on;
plot([1:cfg.gen],meanEliteAbsWeights,'r-','LineWidth',2);
set(weightGraph,'XLim',[2,cfg.gen]);
axis([1 cfg.gen 0 cfg.weightCap]);
grid on;
xlabel('Generation');ylabel('Weights');


%% Diversity
% Species Distribution
speciesDistributionGraph = subplot(5,3,12);
for i=1:length(species)
    sdist(i) = length(species{i}.members);
end
specPie = pie(sdist);
title('Species Distribution','FontSize',12);

% Computation Time of Each Algorithm Component
compTimeGraph = subplot(5,3,15);
adj_express_time = eval_time + express_time;
adj_speciate_time = adj_express_time + speciate_time;
adj_recom_time = adj_speciate_time + recom_time;

jbfill([1:cfg.gen],adj_recom_time,adj_speciate_time,    'r','k',0,0.2);
jbfill([1:cfg.gen],adj_speciate_time,adj_express_time,  'g','k',1,0.2);
jbfill([1:cfg.gen],adj_express_time,eval_time,          'b','k',1,0.2);
jbfill([1:cfg.gen],eval_time,zeros(1,cfg.gen),              'k','k',1,0.5);
legend('Recombination','Speciation','Expression','Evaluation','Location','NorthWest')
set(compTimeGraph,'XLim',[2,cfg.gen])
xlabel('');ylabel('Seconds');
title('Computation Time','FontSize',12);

drawnow;