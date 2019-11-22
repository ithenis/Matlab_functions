function [ii] = find_peaks(data,threshold);
%syntax:   [ii] = find_peaks(data,threshold);
%looks at all the columns (individually) of the input matrix
% threshold is the multiples of the rms value, optional input. if omitted,
% it's set to 1
 % quite simplisticneeds more work
if nargin == 1
    threshold = 1;
end

%% find all peaks   
    imax = find(diff(sign(diff(data))))+1;
   
    
%% find peaks where the curvature is higher than rms
    ii = imax(abs(data(imax))>threshold*(get_rms(data)));
   
    
   
return
 dii = find(diff(sign(data(ii))))+1;
figure
hold on
    plot(data,'b','linewidth',1.5)
    plot(ii(dii),data(ii(dii)),'ro','linewidth',1.5)
    
    hold off
    set(gca,'ytick',[ 0 get_rms(data)*10^6],'ygrid','on')
    set(gca,'xtick', ii,'xgrid','on')
    xlabel('Length [mm]','Fontsize',12,'FontWeight','bold')
    ylabel('Curvature [urad]','Fontsize',12,'FontWeight','bold')