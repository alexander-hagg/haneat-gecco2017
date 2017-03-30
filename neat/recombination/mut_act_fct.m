%% mut_act_fcn.m - Changes a nodes' activation function, and adds it to innovation record.

function [connG, nodeG, innovation] = mut_act_fct(connG, nodeG, p, innovation, generation)
nextInnov = innovation(1,end)+1;
new_node_id = max(innovation(4,:)) + 1;

% Determine mutability and pick node
mut_nodes = find(nodeG(2,:) == 3);
if length(mut_nodes) == 0; return; end;
rand_node = mut_nodes(randi(length(mut_nodes)));

% Select activation function
chosen_fct = p.fctPool(randi(length(p.fctPool)));
 
% Apply activation fcns
nodeG(3,rand_node) = chosen_fct;

% Adjust connections
conn_from = connG(2,:)==nodeG(1,rand_node);
conn_to = connG(3,:)==nodeG(1,rand_node);
connG(2,conn_from) = new_node_id;
connG(3,conn_to) = new_node_id;

% Record and adjust innovation numbers
if length(connG(1,conn_from)) > 0
    connG(1,conn_from) = [nextInnov:nextInnov + length(connG(1,conn_from))-1];
    nextInnov = nextInnov + length(connG(1,conn_from));
    newInnovations2 = [connG([1:3],conn_from);new_node_id*ones(1,sum(conn_from));generation*ones(1,sum(conn_from))];
    innovation = [innovation, newInnovations2];
end
if length(connG(1,conn_to)) > 0
    connG(1,conn_to) = [nextInnov:nextInnov + length(connG(1,conn_to))-1];
    nextInnov = nextInnov + length(connG(1,conn_to));
    newInnovations1 = [connG([1:3],conn_to);new_node_id*ones(1,sum(conn_to));generation*ones(1,sum(conn_to))];
    innovation = [innovation, newInnovations1];
end

% Set new node ID
nodeG(1,rand_node) = new_node_id;

end


