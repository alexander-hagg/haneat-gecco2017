%% colorLookup.m - Return a color from a equally spaced range in a color map
% 
% Usage: colorLookup(value,range,colormap)
%        colorLookup(3,10,hsv)
%
% Range is range of all possible colors, for colormaps 
%
%

function color = colorLookup(value,range,varargin)
if range < 8
    switch (value)
        case 1
            color = 'b';
        case 2
            color = 'g';
        case 3
            color = 'r';
        case 4
            color = 'c';
        case 5
            color = 'm';
        case 6
            color = 'y';
        otherwise
            color = 'k';
    end
    
else    

map = colormap;

% Set custom colormap
if ~isempty(varargin)
    map = colormap(varargin{1});
end

colors = round(linspace(1,length(map),range));
color = map(colors(value),:);
end


