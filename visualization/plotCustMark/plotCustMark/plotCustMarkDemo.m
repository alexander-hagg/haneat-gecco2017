ff{1} = @(x) x;
ff{2} = @(x) (x>0);
ff{3}= @(x) (x>0).*x;
ff{4} = @(x) (1./(1+exp(-4.9*x)));
ff{5} = @(x) (exp(-(x-0).^2/(2*1^2)));
        
x = -3:0.1:3;
custom_markers = {};
fig = figure(1);
for i=1:5
    custom_markers{i} = [[x/6 fliplr(x/6)];...
        [2*ff{i}(x)/6 0.05 + 2*fliplr(ff{i}(x)/6)]];
    plotCustMark(1,1,custom_markers{i}(1,:),custom_markers{i}(2,:),1,fig);
    drawnow;
pause(1);
end

