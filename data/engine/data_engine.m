%% Engine dataset (Mathworks)

function p = data_engine
p.name = 'engine';

[x,t] = engine_dataset;
[p.samples.input,p.samples.input_scale]     = mapminmax(x);
[p.samples.output,p.samples.output_scale]   = mapminmax(t,0,1);
p.samples.input                             = [ones(size(p.samples.input,2),1), p.samples.input'];
p.samples.output                            = p.samples.output';
p.fitFun                                    = @get_error_regression;
p.inputs                                    = size(p.samples.input,2)-1;
p.outputs                                   = size(p.samples.output,2);
p.activations                               = ones(1, p.inputs+p.outputs+1);
