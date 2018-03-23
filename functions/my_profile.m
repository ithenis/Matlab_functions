function [profile, dix, diy] = my_profile(map, endPoints);
% my_profile extracts a profile from 2D data
%
% syntax:    [profile, dix, diy] = my_profile(map, endPoints)
% endPoints (optional) = [x1 y1;x2 y2]
% dix;diy = the scaling of each pixel in the X and Y direction. use it to
%           calculate the profile's sampling step as sqrt(dix*dx + diy*dy)

% created by ithen *** 16.01.2018 ***

%   Detailed explanation goes here
    if ~exist('endPoints','var')
      imagesc(map)
      endPoints =round(ginput(2));
    end
    
    ix1 = min(endPoints(1,1),endPoints(2,1));
    ix2 = max(endPoints(1,1),endPoints(2,1));
    iy1 = min(endPoints(1,2),endPoints(2,2));
    iy2 = max(endPoints(1,2),endPoints(2,2));
    
    if (ix2-ix1)>(iy2-iy1)
        Npoints = (ix2-ix1)+1;
    else
        Npoints = (iy2-iy1)+1;
    end
    
    t=linspace(0,1,Npoints);
    ix = ix1 + t*(ix2-ix1);
    ix = ix(:);
    iy = iy1 + t*(iy2-iy1);
    iy = iy(:);
    dix = t(2)*(ix2-ix1);
    diy = t(2)*(iy2-iy1);
    
    if ix1 == ix2
        profile = map(iy1:iy2,ix1);
    elseif iy1 == iy2
        profile = map(iy1,ix1:ix2);
    else
        profile = interp2([ix1:ix2]',[iy1:iy2]',map(iy1:iy2,ix1:ix2), ix, iy,'spline');
    end
    


end

