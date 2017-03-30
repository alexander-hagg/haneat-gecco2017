%% Evaluation - Get evaluation results from all individuals.  Wrapper with execution timer.
%

eval_start = tic;

if cfg.parallel
    parfor i=1:length(pop)
        pop(i).fitness = get_fitness(pop(i), cfg.data);
    end
else
    for i=1:length(pop)
        pop(i).fitness = get_fitness(pop(i), cfg.data);
    end
end

eval_time(cfg.gen) = toc(eval_start);