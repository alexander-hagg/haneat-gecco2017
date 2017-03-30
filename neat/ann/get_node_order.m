%% get_node_order - Returns indices of nodes in topological order, and weight matrix
%

function [ Q, wMat ] = get_node_order( ind )

connMat = zeros(size(ind.nodes,2));

hidden = find(ind.nodes(2,:) == 3);
hidlookup = ind.nodes(1,hidden);
output = find(ind.nodes(2,:)==2);
outlookup = ind.nodes(1,output);
lookup = [1:(size(ind.nodes,2) - length(hidlookup)), hidlookup];

for i=1:size(ind.conns,2)
    in = find(lookup == ind.conns(2,i));
    out= find(lookup == ind.conns(3,i));
    w  = ind.conns(4,i);
    connMat(in, out) = w;    
end
wMat = connMat;
connMat(connMat~=0) = 1; 

%% Topological Sort
incoming_edges = sum(connMat,1);
Q = find(incoming_edges==0); % Start with nodes with no connection to them

for i=1:length(connMat)
    if isempty(Q) || i > length(Q)
       Q = []; % found a cycle
       break;
    end
    outgoing_edges = connMat(Q(i),:);
    incoming_edges = incoming_edges - outgoing_edges;
    Q = [Q , quick_set_diff(find(incoming_edges==0),Q)];
    if sum(incoming_edges) == 0
        break;
    end
end

%% Move output nodes to the back
for i=1:length(outlookup)
    n = find(Q==outlookup(i));
    Q(n) = [];
end
Q = [Q, outlookup]; % add output nodes back to Q

wMat = wMat(Q,Q);

end

