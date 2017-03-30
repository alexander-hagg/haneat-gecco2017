%% original_speciation.m - Original NEAT speciation, aka first compatible seed
%
%   Procedure:
%       1. Take first individual from each previous gens species as seeds
%           1.1 If no seeds are given the first individual will be taken as
%           the only seed
%       2. Assign each member of population to first species within
%       compatibility distance
%           2.1 If no seed within cdist, that ind becomes a new seed
%
%   Result: species struct
%               .members (individuals)

%% Get Previous Seeds
if isempty(species)
    seed(1) = pop(1);
    species{1}.members(1) = pop(1);
    species{1}.members(1).species = 1;
    species{1}.distance(1) = 0;
    species{1}.prevBest = 0;
    species{1}.lastImp = 0;
    prevSpecies = species{1};
else
    prevSpecies = species;
    for i=1:length(prevSpecies)
        seed(i) = prevSpecies{i}.members(1);
        species{i}.members = seed(i);
        species{i}.distance = [];
        species{i}.members(1).species = i;
        species{i}.distance(1) = 0;
    end
end
%% Assign Species
% Cycle through population, assigning individual to first species seed
% within compatibility difference
for i=1:length(pop)
    assigned = false;
    for s=1:length(seed)
        diff = species_diff(seed(s),pop(i), p);
        if diff < p.specThresh %speciation.threshold
            species{s}.members(end+1) = pop(i);
            species{s}.members(end).species = s;
            species{s}.distance(end+1) = diff;
            assigned = true;
            break;
        end
    end
    
    % If no seed is close enough, create new species centered on this
    % individual
    if ~assigned
        seed(end+1) = pop(i);
        species{end+1}.members = pop(i);
        species{end}.members.species = length(seed);
        species{end}.distance = 0;
        species{end}.seed = pop(i);
        species{end}.prevBest = 0;
        species{end}.lastImp = 0;
    end
end

% Remove prev gen seeds from species
extinct = [];
for i=1:length(prevSpecies)
    species{i}.distance(1) = [];
    species{i}.members(1) = [];
    if isempty(species{i}.members)
        extinct = [extinct i];
    end
end

if ~isempty(extinct)
    species(extinct) = [];
end