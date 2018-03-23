function height = intnom(slope,dx,remove_tilt)
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   integrate slope data
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   syntax:  height = intnom(slope,dx,remove_tilt)
%            slope is 1d data; remove_tilt is optional input
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

if nargin == 2
    remove_tilt = 1;
end

slope = slope(:);



% (trapezoidal integration)
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


if remove_tilt == 1
    tango = tan(slope-mean(slope));   
else
    tango = tan(slope);   
end

height = 0.5*([0; tango(1:end-1)] + tango)*dx;
height = cumsum(height);  % in [nm]   

% align to horizontal
if remove_tilt == 1
    height  = height - linspace(height(1),height(end),numel(height))';
end
