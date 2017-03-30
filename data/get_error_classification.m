function error = get_error_classification(ind,p)
input = p.samples.input;
output = ffnet(ind.pheno.wMat,ind.pheno.aMat,input,p);

num_classes = numel(unique(p.samples.output));
target = p.samples.output;
correct_classifications = abs(output-target)<1/num_classes;
error = 1-(sum(correct_classifications)/size(target,1));
end