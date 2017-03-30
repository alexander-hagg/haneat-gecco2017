%% mut_addConn.m - Adds a new connection if possible, and adds it to innovation record.

function [connG, innovation] = mut_addConn(connG, nodeG, innovation, generation, p)
nextInnov = innovation(1,end)+1;

%% Create set of possible connections
if ~p.recurrent
    % Possible connections in FFNN are from any node but output to any
    % nodes but input
    outputs = find(nodeG(2,:)==2);
    inputs  = union(find(nodeG(2,:)==1), find(nodeG(2,:)==4)); % and bias
    
    from_nodes = setxor(nodeG(1,:), outputs);
    to_nodes = setxor(nodeG(1,:),inputs);
    
else
    % Possible connections in RNN are from any node to any nodes but input
    inputs  = union(find(nodeG(2,:)==1), find(nodeG(2,:)==4)); % and bias
    
    from_nodes = nodeG(1,:);
    to_nodes = setxor(nodeG(1,:),inputs);
        
end

[r,q] = meshgrid(from_nodes, to_nodes);
all_conns = [r(:) q(:)];
current_conns = connG([2 3],:)';


%   _TUNE-UP: There should be a way to use graph theory to make a set
%   of possible connections that are not recurrent, for now we will
%   just check by doing a topological sort after adding a connection.
%   While this isn't that expensive [O(V+E)], with large CPPNs it may
%   have to be done many many times to find a valid connection.

% Remove already existing connections
pos_conns = setxor(all_conns,current_conns,'rows');

if ~isempty(pos_conns)
    
    % Random order to try connections
    [~,newConnIndex] = sort(rand(1,size(pos_conns,1)));
    
    %% Add connection and test for cycles
    for i=1:length(newConnIndex)
        new_conn = [nextInnov;...
            pos_conns(newConnIndex(i),:)';...
            (rand-0.5)*p.weightInitCap*2;...
            1];
        connG = [connG new_conn];
        
        if is_cyclic(connG, nodeG) && ~p.recurrent
            connG(:,end) = [];
        else
            break;
        end
    end
    
    %% Record Innovation if it is truly new
    new_conns_this_gen = innovation(:,find(innovation(5,:)==generation));
    [already_added,IA,IB] = intersect(new_conn([2 3])',new_conns_this_gen([2 3],:)','rows');
    
    if isempty(already_added) % Add to record if truly new
        new_innovation =    [new_conn([1:3]);0;generation];
        innovation = [innovation, new_innovation];
    else % Reassign
        connG(1,end) = new_conns_this_gen(1,IB);
    end
    
end




