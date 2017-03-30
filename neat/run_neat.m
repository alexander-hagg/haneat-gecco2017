%% RUN_NEAT - HA-NEAT algorithm, which produces heterogeneous feed forward neural networks
% Default configuration is defined in default_params.m
% Returns the population and gathered experimental data

% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Jan 2017; Last revision: 30-Mar-2017

function [pop, run_data] = run_neat( cfg )
%% Initialize Population and run first evaluation
[pop, innovation] = init_population(cfg);
species = []; genArr = []; cfg.gen = 1;
expression;
evaluation;
speciation;

% Elitism
[eliteValue, eliteIndex] = max(cell2mat({pop.fitness})); cfg.elite = pop(eliteIndex);
pop(1) = cfg.elite;

gather_data;

%% Begin Evolution
while (cfg.gen < cfg.maxGen)
    tic
    old_pop = pop;
    cfg.gen = cfg.gen + 1;
    recombination;
    expression;
    evaluation;
    stop_criteria;
    speciation;
    
    %% Data Gathering and Visualization
    if  ~isempty(pop)
        if cfg.elitism==1
            if  max(cell2mat({pop.fitness})) > cfg.elite.fitness;
                [eliteValue, eliteIndex] = max(cell2mat({pop.fitness}));
                cfg.elite = pop(eliteIndex);
                pop(1) = cfg.elite;
            else
                pop(1) = cfg.elite;
            end
        end
        gather_data;
        display_data;
    else
        disp('Population empty');
        cfg.gen = cfg.maxGen;
        pop = old_pop;
    end
    genArr = [genArr, [cfg.gen;cfg.elite.fitness;(1/cfg.elite.fitness);cfg.fctPool';toc;cfg.current_run]];
    
end

get_run_data;

end

