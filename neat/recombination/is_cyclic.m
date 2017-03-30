%% is_cyclic.m - True if connection genes define a graph with cycles.
%
% function [cyclic, Q] = is_Cyclic(connG, nodeG)
%
% This is determined by success/failure of a topological sort. 
%
% NOTE: To avoid having to check again when a connection is reenabled,
% disabled connections are included.
%

function [cyclic, Q] = is_cyclic(connG, nodeG)

%% Build connection matrix
connMat = zeros(size(nodeG,2));

hidden = find(nodeG(2,:) == 3);
hidlookup = nodeG(1,hidden);
lookup = [1:(size(nodeG,2) - length(hidlookup)), hidlookup];

for i=1:size(connG,2)
    in = find(lookup == connG(2,i));
    out= find(lookup == connG(3,i));
    w  = connG(4,i);
    connMat(in, out) = w;    
end
connMat(connMat~=0) = 1; 

%% Topological Sort
incoming_edges = sum(connMat,1);
Q = find(incoming_edges==0); % Start with nodes with no connection to them

for i=1:length(connMat)
    if isempty(Q) || i > length(Q)
       Q = []; % Cycle found!!!
       break;
    end
    outgoing_edges = connMat(Q(i),:);
    incoming_edges = incoming_edges - outgoing_edges;
    Q = [Q , quick_set_diff(find(incoming_edges==0),Q)];
    if sum(incoming_edges) == 0
        break;
    end
end

cyclic = isempty(Q);

end