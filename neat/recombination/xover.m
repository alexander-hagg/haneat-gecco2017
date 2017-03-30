%% xover.m - Create child from two individuals via uniform crossover
%
%   Preconditions:
%       - ParentA has higher fitess than ParentB
%
%   Procedure:
%       - Copy node and connection genes from ParentA
%       - Identify matching connection genes in ParentA and ParentB
%       - With random chance take matching connection weights from ParentB
%
%   Output:
%       - Child individual
%       - Note: species ID is maintained because of copying
%
%   Tuneup: Could change intersect to modified quick intersect
%

function child = xover(pA, pB)

    % Inherit all nodes and connections from most fit parent
    child = pA;
    child.fitness = []; 
    child.pheno = [];
    
    % Identify matching connection genes in ParentA and ParentB
    aConns = pA.conns(1,:);
    bConns = pB.conns(1,:);
    [matching,IA,IB] = intersect(aConns,bConns); % Could be sped up...
    
    % Replace weights with ParentB weights with some probability
    bProb = 0.45;
    bgenes = rand(1,length(matching))<bProb;
    
    child.conns(:,IA(bgenes)) = pB.conns(:,IB(bgenes));   

end