%% gather_data - Compiles and records data from current generations

for i=1:length(pop)
   fit(i,cfg.gen) = pop(i).fitness;
   spec(i,cfg.gen) = pop(i).species;
   nodes(i,cfg.gen) = size(pop(i).nodes,2);
   conns(i,cfg.gen) = length(pop(i).conns(find(pop(i).conns(5,:)~=0)));
   meanAbsWeights(i,cfg.gen) = mean(abs(pop(i).conns(4,find(pop(i).conns(5,:)~=0))));   
end

best_index = find(fit(:,cfg.gen) == max(fit(:,cfg.gen)) );

best_ind = pop(best_index(1));
test_cfg = cfg.data;
best_ind.error_test = 1/get_fitness(best_ind, test_cfg);
best_ind.error = 1/best_ind.fitness;

elite(cfg.gen) = best_ind;

for g=1:cfg.gen
    meanEliteAbsWeights(cfg.gen) = mean(abs(elite(g).conns(4,:)));
    eliteNodes(cfg.gen) = size(elite(g).nodes,2);
    eliteConns(cfg.gen) = size(elite(g).conns(find(elite(g).conns(5,:)~=0)),2);
end



