function [IA, IB] = quickIntersectIndex(A,B)
%% Custom fast intersect for positive integers returns only indices
%   Inspired by: http://www.mathworks.com/matlabcentral/answers/53796-speed-up-intersect-setdiff-functions

P = false(1, max(max(A),max(B)) ) ;
P(A) = true;
IB = P(B);

P(A) = false; % back to zeros without creating new matrix
P(B) = true;
IA = P(A);