function p = get_folds(p, folds)
%% Validation Folds
p.num_partitions                = folds;
p.indices                       = crossvalind('Kfold', size(p.samples.input,1), p.num_partitions);

for f=1:p.num_partitions
    p.folds{f}.train.input      = p.samples.input(p.indices~=f,:);
    p.folds{f}.train.output     = p.samples.output(p.indices~=f,:);
    p.folds{f}.test.input       = p.samples.input(p.indices==f,:);
    p.folds{f}.test.output      = p.samples.output(p.indices==f,:);
end
end