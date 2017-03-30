%% DEMO for Heterogeneous Activation NEAT
% The algorithm and data configuration are loaded, with the data being
% partitioned into k folds. The algorithm is executed and data collected.
% Configuration and results are saved in a Matlab binary (.mat)

clear; clc; set(0,'DefaultFigureWindowStyle','docked');
algo                        = default_params;
algo.data                   = get_folds(data_cancer, 3);
results                     = [];

disp(['Dataset: ' algo.data.name]);

for partition = 1:algo.data.num_partitions
    disp(['Training partition ' int2str(partition)]);
    algo.current_run = partition;
    
    [pop, run_data] = run_neat(algo);    
    
    results = collect_data(1,partition,run_data,algo,results);
    save(algo.data.name,'results','algo','-v7.3');
end

%% Visualize all runs/folds
semilogy(results.test_error','LineWidth',2);
grid on;xlabel('Generations');ylabel('MSE');
axis([0 algo.maxGen 1e-2 1e0]);