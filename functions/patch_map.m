function [map] = patch_map(map)
% interpolates nan values
%   Detailed explanation goes here

[Y, X] = size(map);
[xq, yq] = meshgrid(1:X,1:Y);
% map(2:Y-1,2:X-1) = nan;
map;
idx = (~isnan(map));
x = xq(idx)  ;
y = yq(idx)  ;
z = map(idx) ;

if Y==1 
    zq = interp1(x,z,xq);
elseif X==1
    zq = interp1(y,z,yq);
else
    zq = griddata(x,y,z,xq(:),yq(:),'cubic');
%     zq = interp2(x,y,z,xq,yq);
end

map = reshape(zq,size(map));
end

