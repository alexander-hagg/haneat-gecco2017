%% mutate.m - Alters existing solution through node and connection mutations.
%

function [mutant, innovation] = mutate(child, p, innovation, generation)

%% Rename for readability
g_len = size(child.conns,2);
connG = child.conns;
nodeG = child.nodes;

%% Disable/ReEnable Connection
disabled_conns = find(connG(5,:) == 0);
reenabled = rand(1,length(disabled_conns)) < p.enableProb;
connG(5,disabled_conns) = reenabled;

enabled_conns = find(connG(5,:) == 1);
disabled = rand(1,length(enabled_conns)) < p.disableProb;
connG(5,enabled_conns) = ~disabled;

%% Weight Mutation
mutated_weights = rand(1,g_len) < p.mutConnProb; % Choose weights to mutate
perturbed_weights = mutated_weights.*rand(1,length(mutated_weights));
perturbed_weights = perturbed_weights > p.rndWeightProb;  % Chance changes are fully random
weight_change   = mutated_weights .* randn(1,g_len) .* p.mutWeightRange;
connG(4,:) = connG(4,:) + weight_change; % Apply mutation
connG(4,perturbed_weights) = p.weightInitCap*2*(-0.5+rand(1,sum(perturbed_weights)));

% Cap weight strength
connG(4,connG(4,:) >  p.weightCap) =  p.weightCap;
connG(4,connG(4,:) < -p.weightCap) = -p.weightCap;

%% Add Node Mutation
if rand < p.addNodeProb && length(find(connG(5,:) == 1)) > 0
    [connG, nodeG, innovation] = mut_add_node(connG, nodeG, p.fctPool(randi(length(p.fctPool))), innovation, generation);
end

%% Add Connection Mutation
if rand < p.addConnProb 
    [connG, innovation] = ...
        mut_add_conn(connG, nodeG, innovation, generation, p);
end

%% Act Function Mutation Mutation
if length(p.fctPool) > 1
    if rand <  p.fctMutProb
        [connG, nodeG, innovation] = mut_act_fct(connG, nodeG, p, innovation, generation);
    end    
end

%% Create mutated child
mutant = child;
mutant.fitness = [];
mutant.species = 0 ;
mutant.nodes = nodeG;
mutant.conns = connG;

end













