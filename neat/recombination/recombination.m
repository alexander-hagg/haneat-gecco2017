%% Recombination - Produce new population via crossover and mutation. Wrapper with execution timer.
%
% [pop, innovation] = recombination(species, p, innovation, p.gen)
%
recom_start = tic;

[pop, innovation] = recombine(species, cfg, innovation, cfg.gen);

recom_time(cfg.gen) = toc(recom_start);
