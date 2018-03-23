function rms_error = rms_map(map)
% calculates the rms error of a 2d map
%   Detailed explanation goes here

[Y X] = size(map);
rms_error = sqrt(sum(sum(map.^2))/(X*Y));

end

