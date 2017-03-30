%% get_run_data.m - Compiles data from one completed run into a single struct

% Parameter Set
run_data.p               = cfg;

% Performance data
run_data.fit             = fit;
run_data.spec            = spec;
run_data.nodes           = nodes;
run_data.conns           = conns;
run_data.innovation      = innovation;

% Runtime Data
run_data.eval_time       = eval_time;
run_data.express_time    = express_time;
run_data.speciate_time   = speciate_time;
run_data.recom_time      = recom_time;

% Solution Data
run_data.elite           = elite;
run_data.population      = pop;
if exist('solveGen','var')
    run_data.solveGen =  solveGen;
else
    run_data.solvedGen = 0;
end

% Elite topology complexity
%run_data
