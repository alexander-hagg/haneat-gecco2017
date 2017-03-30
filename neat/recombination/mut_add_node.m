%% mut_addNode.m - Adds new node by spliting existing connection
%
%

function [connG, nodeG, innovation] = mut_addNode(connG, nodeG, act_fcn, innovation, generation)
    nextInnov = innovation(1,end)+1;
    
    % Choose connection to split
    active_conns = find(connG(5,:) == 1);
    split_conn = active_conns( randi(length(active_conns) ) );
    
    % Create new node
    new_node_ID = max(innovation(4,:)) + 1; % node ID from running counter
    new_node = [new_node_ID 3 act_fcn]'; % hidden node with random activation
    
    % Add connections to and from new node
    conn_to = connG(:,split_conn);
    conn_to(1) = nextInnov;
    conn_to(3) = new_node_ID;            % destination is new node
    conn_to(4) = 1;                      % set weight 1
    
    conn_from = connG(:,split_conn);
    conn_from(1) = nextInnov+1;
    conn_from(2) = new_node_ID;          % source is new node
    conn_from(4) = connG(4,split_conn);  % weight equal to prev connection
    
    % Disable original connection
    connG(5,split_conn) = 0;
    
    % Record innovations
    newInnovations(:,1) = [conn_to([1:3]);new_node_ID;generation];
    newInnovations(:,2) = [conn_from([1:3]);0;generation];
    innovation = [innovation, newInnovations];
    
    % Add new structures to genome
    connG = [connG,conn_to,conn_from];
    nodeG = [nodeG,new_node];
end