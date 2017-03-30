function error = get_error_regression(ind,p)
input = p.samples.input;
output = ffnet(ind.pheno.wMat,ind.pheno.aMat,input,p);
if strcmp(p.name,'xor2')
    output(output<0) = 0;
    output(output>1) = 1;
end
target = p.samples.output;
error =  immse(output, target);
end