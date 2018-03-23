function map = fitplane(map, varargin)
% fitplane = removes tilt from input matrix
% outputs detilted matrix and optionally, the fitted plane

[m n] = size(map);
if find(isnan(map))
    
end

[x, y] = meshgrid(1:n, 1:m);
X = [ones(m*n, 1), x(:), y(:)];
M = X\map(:);
fittedplane = reshape(X*M, m, n);

map = map-fittedplane;

if nargin>1
    map(:,:,2) = fittedplane;
end

