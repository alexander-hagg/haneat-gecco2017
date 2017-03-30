function Z = MY_setdiff2(X,Y)
%% MY_setdiff Custom fast setdiff for positive integers
%   Taken from: http://www.mathworks.com/matlabcentral/answers/53796-speed-up-intersect-setdiff-functions
  check = false(1, max(max(X), max(Y)));
  check(X) = true;
  check(Y) = false;
  Z = X(check(X));  


