%% initializePop - Creates initial NEAT population
% _Node Genes
% 1-Node ID
% 2-Type (1=input, 2=output 3=hidden 4=bias)
% 3-Activation Function
%
% _Connection Genes
% 1-Innovation Number
% 2-Source
% 3-Destination
% 4-Weight
% 5-Enabled?
%
% _Innovation Record
% 1-Innovation Number
% 2-Source
% 3-Destination
% 4-New Node
% 5-Generation
%

function [ pop,innovation ] = init_population( p )

% Create Nodes
ind.nodes(1,:)      = [1:(p.data.inputs+p.data.outputs+1)];
ind.nodes(2,:)      = [4, ones(1,p.data.inputs), 2*ones(1,p.data.outputs)]; % Bias, Inputs, Outputs
ind.nodes(3,:)      = p.data.activations;

% Create Connections
numberOfConnections = (p.data.inputs+1) * p.data.outputs;
ins                 = [1:p.data.inputs+1];          % IDs of input nodes
outs                = p.data.inputs+1 + [1:p.data.outputs];

ind.conns(1,:)      = [1:numberOfConnections];
ind.conns(2,:)      = repmat(ins,1,length(outs));   % One source for every destination
ind.conns(3,:)      = sort(repmat(outs,1,length(ins)))';
ind.conns(4,:)      = 0.1;                          % Just a placeholder
ind.conns(5,:)      = ones(1,numberOfConnections);

% Initialize struct values
ind.fitness = 0; ind.error = 0; ind.birth = 1; ind.species = 0; ind.pheno = [];

%% Create Population of base individuals
for i=1:p.popSize
    pop(i) = ind;
    pop(i).conns(4,:) = randn(1,numberOfConnections).*0.5*p.weightInitCap;
    pop(i).conns(4,pop(i).conns(4,:) > p.weightInitCap) = p.weightInitCap;
    pop(i).conns(4,pop(i).conns(4,:) < -p.weightInitCap) = -p.weightInitCap;
end

%% Create Innovation Record
innovation = zeros(5,numberOfConnections);
innovation(4,end) = ind.nodes(1,end);
innovation([1:3],:) = ind.conns([1:3],:);
end














