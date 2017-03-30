%% stop_criteria - Early termination test. Safe wrapper with execution timer.
%
% Requires definition of cfg.stoppingCriteria()
%

stopping_start = tic;

if isfield(cfg,'stoppingCriteria')     
    cfg.stoppingCriteria();
end

stopping_time(cfg.gen) = toc(stopping_start);

