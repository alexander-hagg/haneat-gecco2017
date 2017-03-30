%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Custom markers for nodes in neural networks
%% By: Alexander Hagg (Germany 2017)
%% Based on code from: Salman Mashayekh
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [patchHndl] = plot_custmark(xData,yData,markerDataX,markerDataY, ...
    markerSize, color_background, color_border)

%% make sure the inputs are OK
if ~isvector(xData) || ~isvector(yData) || length(xData)~=length(yData)
    fprintf('Error! xData and yData mar must be vectors of the same length!\n');
    return
end
if ~isvector(markerDataX) || ~isvector(markerDataY) || length(markerDataX)~=length(markerDataY)
    fprintf('Error! markerDataX and markerDataY mar must be vectors of the same length!\n');
    return
end
% ------
xData = reshape(xData,length(xData),1) ;
yData = reshape(yData,length(yData),1) ;
markerDataX = markerSize * reshape(markerDataX,1,length(markerDataX)) ;
markerDataY = markerSize * reshape(markerDataY,1,length(markerDataY)) ;
% -------------------------------------------------------------


%% prepare and plot the patches
markerEdgeColor = [0 0 0] ;
markerFaceColor = [0 0 0] ;
lineStyle = '--' ;
lineColor = [0 0 0] ;
% ------
vertX = repmat(markerDataX,length(xData),1) ; vertX = vertX(:) ;
vertY = repmat(markerDataY,length(yData),1) ; vertY = vertY(:) ;
% ------
vertX = repmat(xData,length(markerDataX),1) + vertX ;
vertY = repmat(yData,length(markerDataY),1) + vertY ;
% ------
faces = 0:length(xData):length(xData)*(length(markerDataY)-1) ;
faces = repmat(faces,length(xData),1) ;
faces = repmat((1:length(xData))',1,length(markerDataY)) + faces ;
% ------

scatter(xData,yData,20*markerSize,color_border,'o','filled');
hold on;
scatter(xData,yData,15*markerSize,color_background,'o','filled');
patchHndl = patch('Faces',faces,'Vertices',[vertX vertY]);
set(patchHndl,'FaceColor',markerFaceColor,'EdgeColor',markerEdgeColor) ;
% -------------------------------------------------------------

