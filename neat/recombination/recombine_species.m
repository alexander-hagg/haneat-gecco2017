%% recombineSpecies.m - Produces allocated offspring of existing species
%
%   function [children, innovation] = recombineSpecies(species, p, innovation, generation)
%
%   Preconditions:
%       - Individuals have all been assigned fitness values
%       - Number of offspring is set and is greater than 0
%
%   Procedure:
%       - Copy best individual into child population unchanged (Elitism)
%       - Cull lower percentage if species is large enough
%       - Until the desired number of offspring are produced:
%           - Tournament selection to choose two parents
%           - With probability (crossover.percentage)
%               - Produce child from crossover between two parents
%           - With probability (1 - crossover.percentage) 
%               - Clone higher fit parent as child
%           - Mutate child
%               - If a new connection is added (directly through add
%               connection mutation or through add node mutation)
%                   - Check if same connection has been added already this
%                   generation
%                   - If it is new add it to the innovation record
%                   - If not assign it the correct innovation number
%
%   Output:
%       - Child population of 'number of offspring' size
%       - Updated innovation record
%
%%*************************************************************************

function [children, innovation] = ...
    recombineSpecies(species, p, innovation, generation)

%% Preprocess population
% Sort population by fitness, remove weakest individuals, elitism

subpop = species.members;
offspring = species.offspring;

% Create fitness vector and sort population by fitness
fitness = zeros(length(subpop),1);
for i=1:length(fitness)
   fitness(i) = subpop(i).fitness; 
end

[~, sortedIndex] = sort(fitness,'descend');
subpop = subpop(sortedIndex);

% Copy best individual into child population unchanged (Elitism)
if offspring >= p.minForElitism
    children(1) = subpop(1);
end

% Cull lower percentage if species is large enough
numberToCull = floor(p.cullRatio*length(subpop));
if numberToCull > 0
    subpop(end-(numberToCull-1):end) = [];
end


%% Get Parent Pairs via Tournament Selection
% Individuals are sorted by fitness so an index comparison is enough, it
% should be noted however this does not allow for the special case of two
% parents having equal fitness. Higher fitness parent is placed first by
% convention for recombination.

parentA = randi(length(subpop), offspring, p.tournamentSize);
parentB = randi(length(subpop), offspring, p.tournamentSize);
parents = [min(parentA,[],2),min(parentB,[],2)]; 
parents = sort(parents,2); % Put higher fitness first

%% Breed Child Population

for next_child = (exist('children','var')+1):offspring % Start with 2nd child if using elitism
    % Crossover
    if rand > p.crossoverProb
        children(next_child) = subpop( parents(next_child,1) ); % Take highest fitness individual if no crossover
    else
        children(next_child) = ...
            xover(subpop( parents(next_child,1) ),...
                  subpop( parents(next_child,2) ));
    end  
    % Mutation
    [children(next_child), innovation] = ...
        mutate( children(next_child), p, innovation,generation);
    
    % Mark for age
    children(next_child).birth = generation;
end

if ~exist('children','var')
    children = [];
end

end













