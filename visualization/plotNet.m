
%% plotNet - Plots the topology and connection weights of an FFANN (individual as input)

function plotNet(ind)
custom_markers = create_markers;
hold off;
ind.conns(4,find(ind.conns(5,:)==0)) = 0.0;
[layMat, actMat] = getLayers(ind);
numLayers = size(layMat,2);

height = 500;
width = 1000;
spacing = -10 + width/numLayers;
margin = 50;
markers = {'o','d','h','s','v'};

markersize = 16;
markerlinewidth = 0.1;

% Plot input layer
y1 = mid_linspace(-height+margin,height-margin,sum(layMat(:,1)));
x1 = spacing*zeros(1,length(y1));
plot_custmark(x1(1:end-1),y1(1:end-1),custom_markers{1}(1,:),custom_markers{1}(2,:), 20, [.1 1 .1], [0 0 0]);
hold on;
plot_custmark(x1(end),y1(end),custom_markers{1}(1,:),custom_markers{1}(2,:), 20, [.1 .1 1], [0 0 0]);

location = [];location = [location, [x1;y1]];

% Plot nodes
for layer=2:numLayers
    if layer==numLayers
        nodecolor = [1 0 0];
    else
        nodecolor = [.8 .8 .8];
    end
    %current_markers = {markers{actMat(actMat(:,layer) ~= 0,layer)}};
    current_markers = actMat(actMat(:,layer) ~= 0,layer);
    y2 = mid_linspace(-height,height,sum(layMat(:,layer))+2);
    y2 = y2(1:end-2);
    %y2 = y2 + 100*(rand(1,length(y2))-0.5);
    %y2 = y2 + 10*(randi(10,1,length(y2))-5);
    %y2 = y2 + 100*(mod(layer,2)-0.5);
    x2 = (layer-1)*spacing*ones(1,length(y2));
    location = [location, [x2;y2]];
    
    for n=1:size(x2,2)
        color_background = nodecolor;
        color_border = [0 0 0];
        plot_custmark(x2(n),y2(n),custom_markers{current_markers(n)}(1,:),custom_markers{current_markers(n)}(2,:), 20, color_background, color_border);

%         plot(x2(n),y2(n),current_markers{n},...
%             'LineWidth',markerlinewidth,...
%             'MarkerEdgeColor','k',...
%             'MarkerFaceColor',nodecolor,...
%             'MarkerSize',markersize)
    end
    % Move on to next layer
    y1 = y2;
    x1 = x2;
end

%% Plot connections
[order, wMat] = get_node_order(ind);
for from=1:length(wMat)
    for to=1:length(wMat)
        weight = wMat(from,to);
        if weight ~=0
            if weight > 0
                h = quiver(location(1,from),location(2,from), location(1,to)-location(1,from),location(2,to)-location(2,from), 'b-', 'LineWidth', abs(weight)/3+1, 'AutoScaleFactor', 0.9);
            else
                h = quiver(location(1,from),location(2,from), location(1,to)-location(1,from),location(2,to)-location(2,from), 'r-', 'LineWidth', abs(weight)/3+1, 'AutoScaleFactor', 0.9);
            end
            uistack(h,'bottom');
        end
    end
end

set(gca,'XTick',[]);
set(gca,'YTick',[]);

%% Add Legend


end