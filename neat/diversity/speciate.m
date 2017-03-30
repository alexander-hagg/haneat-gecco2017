%% speciate.m - Divides population in species, assigns number of offspring, removes stagnant species
%
%   Procedure:
%       1. Assign each member of population to species
%       2. Assign number of offspring to each species
%           2.1 Get normalized species fitness size of species
%           2.2 Assign offspring proportionate to this shared fitness
%       3. If species has not improved in p.dropOffAge generations set the
%       species fitness to 0 to award no offspring
%
%

function [species,pop] = speciate(pop, p, species)

%% Divide into Species
if strcmp(p.specType, 'original')
    original_speciation;
end

if strcmp(p.specType, 'kmeans')
    kmeans_speciation;
end


%% Calculate Offspring
% Explicit fitness sharing
for s=1:length(species)
    fitsum(s) = 0;
    members(s) = length(species{s}.members);
    species{s}.best = species{s}.members(1).fitness;
    for i=1:members(s)
        fitsum(s) = fitsum(s) + species{s}.members(i).fitness;
        if species{s}.best < species{s}.members(i).fitness
            species{s}.best = species{s}.members(i).fitness;
        end
    end
end

%% Stagnation -- kill species that aren't getting better
for s=1:length(species)
    if species{s}.best <= species{s}.prevBest
        species{s}.lastImp = species{s}.lastImp + 1;
        %display(['Last Improvement for Species ' int2str(s) ' was ' int2str(species{s}.lastImp) ' gens ago.']);
    else
        species{s}.prevBest = species{s}.best;
        species{s}.lastImp = 0;
        %display(['Species ' int2str(s) ' improved!']);  
    end
    
    if species{s}.lastImp >= p.dropOffAge
        fitsum(s) = 0;
        % display('Stagnation');
    end
end

%% Assign Offspring
if exist('fitsum','var')
    speciesFit = fitsum./members;                               % calculate species fitness
    speciesFit = speciesFit/sum(speciesFit);                    % normalize
    earnedKids = speciesFit.*p.popSize;                         % real value earned offspring
    offspring  = floor(earnedKids);                             % integer earned offspring
    remainder  = p.popSize-sum(offspring);                      % extra offspring to award
    [junk,deserving]  = sort(earnedKids-offspring,'descend');   % most cheated by rounding

    % Give remaining offspring to the most cheated by rounding
    if remainder > 0
        offspring(deserving(1:remainder)) = offspring(deserving(1:remainder)) + 1;
    end

    for s=1:length(species)
        stagnant(s) = offspring(s);
        species{s}.offspring = offspring(s);
    end

    % Remove Stagnant Species
    species(stagnant==0) = [];
end
