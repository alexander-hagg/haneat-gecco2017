function custom_markers = create_markers()

ff{1} = @(x) x;
ff{2} = @(x) (x>0);
ff{3}= @(x) (x>0).*x;
ff{4} = @(x) (1./(1+exp(-4.9*x)));
ff{5} = @(x) (exp(-(x-0).^2/(2*1^2)));

x = [-1:0.03:1;-1:0.03:1;-1:0.03:1;-3:0.09:3;-3:0.09:3];
custom_markers = {};
for i=1:5
    custom_markers{i} = [[x(i,:) fliplr(x(i,:))];...
        [2*ff{i}(x(i,:)) 0.5 + 2*fliplr(ff{i}(x(i,:)))]];
end

for i=1:5
    custom_markers{i}(1,:) = mapminmax(custom_markers{i}(1,:),-1,1);
    custom_markers{i}(2,:) = mapminmax(custom_markers{i}(2,:),-1,1);
end

end
