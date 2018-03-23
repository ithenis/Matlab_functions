function x_rms = get_rms(x)
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   calculate rms value
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   syntax:  x_rms = get_rms(x))
%            x is 1d data
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

if numel(x)<2
    disp('needs a vector as input')
    x_rms=nan;
    return
end

x_rms = sqrt(sum((x-mean(x)).^2)/(numel(x)-1));
end

