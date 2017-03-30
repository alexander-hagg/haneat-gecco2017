%% Update plots
%
%

if ~mod(cfg.gen,cfg.display_fitness)
    subplot(fitGraph);
    hold off;
    fit2err = sqrt(1./fit)/2;
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
end

% Plot Performance Component
if ~mod(cfg.gen,cfg.display_component)
    subplot(componentGraph);
    %% Double Pole Balancing
    if strcmp(func2str(cfg.data.fitFun), 'twoPole_test')
        maxSteps = max(steps);
        medianSteps = median(steps);
        meanSteps = mean(steps);
        minSteps = min(steps);
        
        XData = [1:cfg.gen];
        Xvertices = [XData,fliplr(XData)]';
        newTopVerts = [Xvertices, [maxSteps, fliplr(medianSteps)]'];
        newBotVerts = [Xvertices, [medianSteps,fliplr(minSteps)]'];
        
        set(stepMean,'XData',[1:cfg.gen]);
        set(stepMean,'YData',mean(steps));
        set(stepTop,'XData',Xvertices);
        set(stepTop,'Vertices',newTopVerts);
        set(stepBot,'XData',Xvertices);
        set(stepBot,'Vertices', newBotVerts);
        
        refreshdata(componentGraph);
        drawnow;
    else
        if cfg.recurrent == false;
            plotNet(elite(end));
            drawnow;
        end
    end
    
end

% Plot Species
if ~mod(cfg.gen,cfg.display_speciesDist)
    subplot(speciesDistributionGraph);
    sdist = [];
    for i=1:length(species)
        sdist(i) = length(species{i}.members);
    end
    specPie = pie(sdist);
end

% Plot Complexity
if ~mod(cfg.gen,cfg.display_complexity)
    % Computation Time
    subplot(compTimeGraph);
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
    
    % Nodes
    subplot(nodeGraph);
    jbfill([1:cfg.gen],max(nodes),median(nodes),'g','k',1,0.2);
    jbfill([1:cfg.gen],median(nodes),min(nodes),'b','k',1,0.2);
    hold on;
    plot([1:cfg.gen],eliteNodes,'r-','LineWidth',2);
    set(nodeGraph,'XLim',[2,cfg.gen])
    xlabel('');ylabel('Nodes');
    
    % Connections
    subplot(connectionGraph);
    jbfill([1:cfg.gen],max(conns),median(conns),'g','k',1,0.2);
    jbfill([1:cfg.gen],median(conns),min(conns),'b','k',1,0.2);
    hold on;
    plot([1:cfg.gen],eliteConns,'r-','LineWidth',2);
    set(connectionGraph,'XLim',[2,cfg.gen])
    xlabel('Generation');ylabel('Connections');
    
    % Weights
    % Mean Weight
    subplot(weightGraph);
    hold off;
    jbfill([1:cfg.gen],max(meanAbsWeights),median(meanAbsWeights),'g','k',1,0.2);
    jbfill([1:cfg.gen],median(meanAbsWeights),min(meanAbsWeights),'b','k',1,0.2);
    hold on;
    plot([1:cfg.gen],meanEliteAbsWeights,'r-','LineWidth',2);
    set(weightGraph,'XLim',[2,cfg.gen]);
    axis([1 cfg.gen 0 cfg.weightCap]);
    grid on;
    xlabel('Generation');ylabel('Weights');


    refreshdata(compTimeGraph);
    drawnow;
end


