%% species_diff.m - Returns compatibility distance between two individuals based on innovation numbers
%
% Note: In the Original NEAT paper these values are scaled by the largest
% number of genes. It is not implemented this way in the original published
% C++ code however, and seems strange for a distance metric, so we've left
% it out. Original paper is average weight difference, some implementations
% use sum of weight differences.
%
%

function difference = species_diff(ref,ind,p)
        max_innov = max(ref.conns(1,:));
        
        % Weight difference in matching connections     
        [IA,IB] = quick_intersect_index(ind.conns(1,:), ref.conns(1,:));
        %weight_diff = mean(abs(ind.conns(4,IA)-ref.conns(4,IB)));
        weight_diff = sum(abs(ind.conns(4,IA)-ref.conns(4,IB)))/length(abs(ind.conns(4,IA)-ref.conns(4,IB)));

        % Connections not in common
        nonMatching = [ref.conns(1,~IB) ind.conns(1,~IA)];
        excess =    nonMatching <  max_innov;
        disjoint =  nonMatching >= max_innov;
                
        difference = p.excess*sum(excess) + p.disjoint*sum(disjoint) + p.weightDif*weight_diff; 
end