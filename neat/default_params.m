%% Default parameters set as found in original NEAT paper
% Stanley 2009/2002 HyperNEAT/NEAT Publications
%
% Obviously DO change these to suit your problem and tweak them for best
% performance, but here is a good place to start.
%
% Popsize       100
% Gens          300
% Disjoint      2
% Excess        3
% Weight		1
% CompatThesh	6
% DropOffAge	15 gens
% SurvivThesh   20%
% AddNode		3%
% AddConn		10%
% MutConn		80%
% Min4Elite     5
% CrossPer      75%
% Reenable      25%
%
%%

function p = default_params
p.alg               = 'NEAT';
p.parallel          = false;

% Recurrent NN will be added in the near future
p.recurrent         = false; 

% Algorithm Parameters
p.maxGen            = 200;
p.popSize           = 100;
p.run               = @(p)NEAT(p);

% Speciation Parameters
p.specType          = 'original'; % 'kmeans' 'original'
p.targetSpec        = 10;
p.elitism           = 1;
p.excess            = 1.0;
p.disjoint          = 1.0;
p.weightDif         = 0.2;
p.specThresh        = 6.0;
p.dropOffAge        = 15;
p.compat_mod        = 0.3;
p.minSpecThresh     = 1;

%% Selection Parameters
p.cullRatio         = 0.4;
p.minForCull        = ceil(1/p.cullRatio);
p.minForElitism     = 5;
p.tournamentSize    = 3;

%% Recombination Parameters
p.rndWeightProb     = 0.9;
p.crossoverProb     = 0.8;
p.addNodeProb       = 0.01;
p.addConnProb       = 0.05;%0.3;
p.mutConnProb       = 0.1;%0.2;
p.enableProb        = 0.005;
p.disableProb       = 0.005;
p.weightInitCap     = 1;
p.weightCap         = 5;
p.mutWeightRange    = 2;
p.fctMutProb        = 0.2;

% Activation function pool.
p.fctPool = [2,3,4,5]; 

% Visualization Parameters
display_params;

% Individual Fitness Information
p.sampleInd.fitness = 0;
