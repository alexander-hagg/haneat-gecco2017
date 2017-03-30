%% recombine - Produces new population by iteratively performing recombination on each species.

function [pop, innovation] = ...
        recombine(species, p, innovation, generation)
    
pop = [];

for i=1:length(species)
    if species{i}.offspring > 0
        [children, innovation] = ...
            recombine_species(species{i}, p, innovation, generation);
        pop = [pop children];
    end
end

