function output = preanalysis1d(instrument,x,y,phi_roll)
% preanalyse NOM data
% accepts multiple scans (!)




if ~strcmp(instrument,'NOM')
    type = 'B';
else
    type = 'A';
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
    if any(diff(idx)>1)   % this looks wrong to me

        if ~exist('skip_gap_check','var')
            disp('non contiguous data')
            prompt = {'x1 (position of left edge, in m)','length of optic [m]'};
            default = {'-0.','0.'};
            answer = inputdlg(prompt,'title',1,default);
            
            if isempty(answer)
                clear
                disp('user abort')
                return
            end
            
        % ------------------------------------
        % optic length L:            
            x1 = str2num(answer{1});
            output.L  = str2num(answer{2}); %#ok<*ST2NM>
            
            skip_gap_check = 1;
            output.x1_NOM = x1;
        end
        idx = find((x>=x1)&(x<=x2));
        
        x = x(idx>0,:);
        
    else
        x = x(idx>0,:);
        
        % ------------------------------------
        % optic length L:
        output.L = x(end,1)-x(1,1);        
        
        fprintf('\n\n ++++++++++++++    NEW SET OF DATA   ++++++++++++++')
        fprintf('\n      Left edge is at %.2f mm\n\n' ,  x(1,1)*1000)
        
        % ------------------------------------
        
    end
    
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

output.x=x;
% output.phi_roll = output.phi_roll - repmat(mean(output.phi_roll), size(output.phi_roll,1), 1);



