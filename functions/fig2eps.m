function fig2eps(handle,name)

% export figure to eps (for publication) 
% handle is the handle of the figure

if nargin<2
    name = ['figure_' num2str(handle)];
end

name = [name '.eps'];


figure(handle)
export_fig(name, '-q101')
close;