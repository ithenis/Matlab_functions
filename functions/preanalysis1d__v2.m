function output = preanalysis1d__v2(instrument,x,y,phi_roll)
% not in use yet!
% preanalyse NOM data
% accepts multiple scans (!)

fprintf('\n\n Preanalysis of 1D data:')
fprintf('\n +++++++++++++++++++++++++++++++++++++++++++ ')

if strcmp(instrument,'NOM')
    type = 'A';
    fprintf('\n Instrument:   NOM ')
else
    type = 'B';  
    fprintf('\n Instrument:   GTx / Fizeau')
end
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% LOAD data, find optic length, equalize slope scans with figure scans:
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


% calculates dx from the first scan only!
output.dx = (x(end,1)-x(1,1))/(size(x,1)-1);


dummy = zeros(size(y));
% ------------------------------------------------------
% if NOM scans
if strcmp(type,'A')
    
    dummy(y~=0) = 1;
    idx = prod(dummy,2); % if matrix - here it cuts the corners
    
    % I think that this would make it right:
    %  iidx = idx(idx>0);
    % if any(diff(iidx)>1)
    % !!!!!!!!!!! CHECK !!!!!!!!!!!!!!
    
    % ------------------------------------------------------
    %   make sure it's ONLY the ends that we discard
    if sum(abs(diff(idx)))>2
        flag_noncontiguous = 1;
        fprintf('\n Warning:      non contiguous data')
    else
        flag_noncontiguous = 0;
    end
    x = x(idx>0,:);
    
    % ------------------------------------
    % optic length L:
    output.L = x(end,1)-x(1,1);
   
    fprintf('\n Left edge:    %.2f mm' ,  x(1,1)*1000)
        
    output.x_scan = [x(1,1) x(end,1)];
    % align x values to 0 = centre of optic
    x = x - (x(1,1)+x(end,1))/2;
    output.x_offset = x(1,1) - output.x_scan(1);
    
    output.phi = y(idx>0,:);
    output.phi_roll = phi_roll(idx>0,:);
    
    % ------------------------------------
    % calculate figure:
    output.height = zeros(size(output.phi));
    for kk = 1:size(x,2)
        output.height(:,kk) = intnom(output.phi(:,kk),output.dx);
    end
    
    
% if GTx/FIZ scans;  crop real length
elseif strcmp(type,'B')
    
    dummy(~isnan(y)) = 1;
    idx = prod(dummy,2); % if matrix - here it cuts the corners
    x = x(idx>0,:);
    output.height = y(idx>0,:);
    
    phi_roll = phi_roll(idx>0,:);
    % ------------------------------------
    % optic length L:
    output.L = x(end,1)-x(1,1);
    
    % ------------------------------------
    % calculate slope:
    output.phi = zeros(size(output.height));
    output.phi = output.phi(1:end-1,:);
    for kk = 1:size(x,2)
        output.phi(:,kk) = diff(output.height(:,kk))./diff(x(:,kk));
    end
    x = x(1:end-1,:);
    output.height = output.height(1:end-1,:);
    output.phi_roll = phi_roll(1:end-1,:);
    
    output.x_scan = [x(1,1) x(end,1)];
    % align x values to 0 = centre of optic
    x = x - (x(1,1)+x(end,1))/2;
    output.x_offset = x(1,1) - output.x_scan(1);
    
end
fprintf('\n +++++++++++++++++++++++++++++++++++++++++++ \n\n ')
output.x = x;
% output.phi_roll = output.phi_roll - repmat(mean(output.phi_roll), size(output.phi_roll,1), 1);



