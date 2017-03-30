function results = collect_data(rep,partition,run_data,cfg,results)
%% COLLECT_DATA collects NEAT results

% Population and elites
results.popArr{rep,partition} = run_data.population;
results.eliteArr{rep,partition} = run_data.elite;

% Connections and Nodes
results.connsArr(rep,partition,:,:) = [run_data.conns repmat(run_data.conns(:,end),1,cfg.maxGen - size(run_data.nodes,2))];
results.nodesArr(rep,partition,:,:) = [run_data.nodes repmat(run_data.nodes(:,end),1,cfg.maxGen - size(run_data.nodes,2))];

% Train and test errors
results.train_error(cfg.data.num_partitions*(rep-1) + partition,:) = ...
    [[run_data.elite.error] repmat(run_data.elite(end).error,1,cfg.maxGen - size(run_data.nodes,2))];
results.test_error(cfg.data.num_partitions*(rep-1) + partition,:) = ...
    [[run_data.elite.error_test] repmat(run_data.elite(end).error_test,1,cfg.maxGen - size(run_data.nodes,2))];

end