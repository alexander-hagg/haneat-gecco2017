%% Express - Converts genotype to weight and activation matrix for neural network
%

function pheno = express(ind,p)

ind.conns(4,find(ind.conns(5,:)==0)) = 0.0;
[order, wMat] = get_node_order(ind);
aMat = ind.nodes(3,order);
pheno.aMat = aMat;
pheno.wMat = wMat;

end