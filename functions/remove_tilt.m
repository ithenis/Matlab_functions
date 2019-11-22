function [y] = remove_tilt(y)
% remove tilt curve from 1d data (bring both ends to 0)
% syntax: y = remove_tilt(y)

if numel(y)<2 
    disp('your input is a scalar. it should be an array')     
elseif ~isvector(y)
    disp('input must be an array')    
else
    if iscolumn(y)
        flag = 0;
    else
        flag = 1;
    end
    y = y(:);
    y = y - linspace(y(1),y(end),numel(y))';
    if flag
        y = y';
    end
end 
    
    
end

