%% display_data - Display run data

if ~cfg.headless
    if cfg.gen == cfg.startPlot
        initPlots;
    end
    
    if cfg.gen > cfg.startPlot
        if mod(cfg.gen,cfg.plotUpdateRate) == 0
            
            updatePlots;
            
        end
    end
else
    if ~mod(cfg.gen,100)
        display([int2str(cfg.gen) ' generations completed.']);
    end
end
