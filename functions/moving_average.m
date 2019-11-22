function [y_smooth] = moving_average(x, y, span, which)
% syntax:   [y_smooth] = moving_average(x, y, span, which)
% syntax:   [y_smooth] = moving_average(dx, y, span, which)
% syntax:   [y_smooth] = moving_average(x, y, span)
% syntax:   [y_smooth] = moving_average(x, y)

%           x can be either an array or a scalar in which case it's treated
%           as dx           
%           which can be 'smooth' or 'filter'.
%           span must be odd
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

if nargin < 4
    which = 'smooth';
    if nargin < 3    
        N = numel(y);
        span = round(N/7.6); % empirical
        if nargin < 2
            x = 1;
        end
    end
end
% averaging window needs to be an odd number
if ~mod(span,2)
    span=  span - 1;
end
if numel(x) == 1
    dx = x;
    x = 0:dx:(numel(y)-1)*dx;
    x = x(:);
end

% Smooth the data using the loess and rloess methods with a span of 10%:
if strcmp(which,'smooth')
    y_smooth = smooth(x,y,span,'loess');  
    % 'rloess' = robust version of 'loess' that assigns lower weight to 
    %            outliers in the regression. The method assigns zero weight
    %            to data outside six mean absolute deviations.
    
elseif strcmp(which,'filter')
    y_smooth = filter(ones(1,span)/span,1,y); % equal weight
end