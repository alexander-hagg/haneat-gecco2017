%% mid_linspace - Linearly spaced vector, ordered from middle out
% linspace(X1, X2, N) generates N points between X1 and X2.
%     For N = 1, mid_linspace returns (X1+X2)/2.
function pts = mid_linspace(X1, X2, N)
    if N == 1
        pts = (X1+X2)/2;
    else
    pts = linspace(X1,X2,N);
    [val,order] = sort(abs(linspace(-1,1,N)));
    pts = pts(order);

end