%% kmeans_speciation.m - Divide population into species with classic multidimensional scaling and kmeans
%
%   Procedure:
%       1. Produce compatibility distance matrix of all individuals in
%       population
%           1.1 'get_species_dist' only computes top corner (only if excess
%           and disjoint values are equal!)
%           1.2 'getSpecDist' computes all values
%       2. Perform classic multidimensional scaling to assign each
%       individual coordinates in n-d space
%       3. Perform kmeans clustering using euclidean distance between n-d
%       coordinates produced in (2), to group each individual into the
%       desired number of species
%
%   Note: Computing the full species matrix can be expensive with a large
%   population if you must do it serially. 
%
%
%%*************************************************************************

if isempty(species)
    %% Build first set of species
    speciesDist = zeros(p.popSize);
    for i = 1:p.popSize;
        speciesDist(i,:) = get_species_dist(pop,i,p);
    end
    speciesDist = speciesDist+speciesDist'; % Copy upper half to lower
    
    % Multidimensional Scaling into n-d coordinates
    indCoords = cmdscale(speciesDist);    
    [specIndex] = kmeans(indCoords,p.targetSpec);
    
    for s=1:p.targetSpec
        prevSpecies{s}.prevBest = 0;
        prevSpecies{s}.lastImp = 0;
    end

    
    % Multidimensional Scaling into n-d coordinates
    indCoords = cmdscale(speciesDist);
    [specIndex] = kmeans(indCoords,p.targetSpec);
    
    for s=1:p.targetSpec
        prevSpecies{s}.prevBest = 0;
        prevSpecies{s}.lastImp = 0;
    end
    
else
    %% Get Previous Seeds
    prevSpecies = species;
    for i=1:length(prevSpecies)
        seed(i) = prevSpecies{i}.members(1);
        % These values will be removed later, but MATLAB gets cranky with
        % uninitialized structs
        species{i}.members(1) = seed(i);
        species{i}.members(1).species = i;
        species{i}.distance(1) = 0;
    end
    pop_with_seeds = [seed pop];
    fullPopSize = length(pop_with_seeds);
    
    % Create distance matrix
    speciesDist = zeros(fullPopSize);
    if p.parallel
        parfor i = 1:fullPopSize;
            speciesDist(i,:) = get_species_dist(pop_with_seeds,i,p);
        end
    else
        for i = 1:fullPopSize;
            speciesDist(i,:) = get_species_dist(pop_with_seeds,i,p);
        end
    end
    
    speciesDist = speciesDist+speciesDist'; % Copy upper half to lower
    
    % Multidimensional Scaling into n-d coordinates
    indCoords = cmdscale(speciesDist);
    
    % Get coordinates of previous seeds and remove them from population
    prevSeedCoords = indCoords([1:length(prevSpecies)],:);
    indCoords([1:length(prevSpecies)],:) = [];
    
    % Random individuals as species seeds
    [randRows, randRows] = sort(rand(1,p.popSize));
    startMat = indCoords(randRows([1:p.targetSpec]),:);
    startMat([1:length(prevSpecies)],:) = prevSeedCoords;
    
    % Group into species via kmeans around previous seeds
    [specIndex] = kmeans(indCoords,p.targetSpec,'Start',startMat);
    
    clear species;
end

%% Assign members to species
for i=1:p.targetSpec
    species{i}.members = pop(specIndex==i);
    if length(prevSpecies) < i
        species{i}.prevBest = 0;
        species{i}.lastImp = 0;
    else
        species{i}.prevBest = prevSpecies{i}.prevBest;
        species{i}.lastImp = prevSpecies{i}.lastImp;
    end
end

for i=1:p.popSize
    pop(i).species = specIndex(i);
end
