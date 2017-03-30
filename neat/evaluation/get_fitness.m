%% getFitness - Assigns fitness to individual based on fitness function designated in parameter file.
%
% Wrapper that calls fitness function designated in parameter file, use
% this to assign fitness components for visualization, or scale raw fitness
% scores.
%

function fitness = get_fitness(ind, cfg)

fitness = 1/cfg.fitFun(ind,cfg);

end