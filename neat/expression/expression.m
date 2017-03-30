%% Expression - Create phenotype from genotype. Wrapper with execution timer.

express_start = tic;

if cfg.parallel
    parfor i=1:length(pop)
        pop(i).pheno = express(pop(i),cfg);
    end
else
    for i=1:length(pop)
        pop(i).pheno = express(pop(i),cfg);
    end
end

express_time(cfg.gen) = toc(express_start);