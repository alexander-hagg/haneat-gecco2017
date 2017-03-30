%% Speciation - Updates species and population. Wrapper with execution timer.
%
%
speciate_start = tic;
[species, pop] = speciate(pop, cfg, species);
speciate_time(cfg.gen) = toc(speciate_start);

% Adjust species threshold to reach species number target
if cfg.gen > 1
    if (length(species) < cfg.targetSpec )
        cfg.specThresh = cfg.specThresh - cfg.compat_mod;
    elseif (length(species) > cfg.targetSpec)
        cfg.specThresh = cfg.specThresh + cfg.compat_mod;
    end
    if( cfg.specThresh < cfg.minSpecThresh )
        cfg.specThresh = cfg.minSpecThresh;
    end
    if length(species) == 1
        if isnan(species{1}.offspring)
            species{1}.offspring = cfg.popSize;
        end
    end
end
%disp(['Number of Species: ' int2str(length(species)) '. Speciation Threshold: ' num2str(cfg.specThresh)]);