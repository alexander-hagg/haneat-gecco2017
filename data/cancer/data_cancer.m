%% Wisconsin Breast Cancer Dataset

function p = data_cancer(p)
p.name = 'cancer';

load breast-cancer-wisconsin_data;
x = breast_cancer_wisconsin_data(:,2:10);
t = breast_cancer_wisconsin_data(:,11);
[p.samples.input,p.samples.input_scale]     = mapminmax(x');
[p.samples.output,p.samples.output_scale]   = mapminmax(t',0,1);
p.samples.input                             = [ones(size(p.samples.input,2),1), p.samples.input'];
p.samples.output                            = p.samples.output';
p.fitFun                                    = @get_error_classification;
p.inputs                                    = size(p.samples.input,2)-1;
p.outputs                                   = size(p.samples.output,2);
p.activations                               = ones(1, p.inputs+p.outputs+1);
