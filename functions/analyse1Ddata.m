% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                           analyses 1D scans
%                 inputs are x and phi + analysis parameters
%           pay attention to input as there is no garde-fou yet
%             ***   ithen   ***  created:   03.03.2014   ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
function output = analyse1Ddata(x, phi, phi_roll, height, varargin)
%{

@ x, phi, phi_roll = m * n matrices (m is number of points; n is number of scans)
@ varargin{1} =[active_L   xc_offset]
@ varargin{2} = params :
        for fitting ellipse:  params = [P   Q   theta   semn]
        for fitting cylinder: params = [R]

output structure with 
%}
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% LOAD data, find optic length, equalize slope scans with figure scans:
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% check if input is vector or 2d matrix
if size(x,1)==1
    x = x(:);
end

if size(phi,1)==1
    phi = phi(:);
end

if size(phi_roll,1)==1
    phi_roll = phi_roll(:);
end

if size(height,1)==1
    height = height(:);
end

% calculates dx from the first scan only!
dx = (x(end,1)-x(1,1))/(size(x,1)-1);

ijumps = find(abs(diff(diff(x(:,1))))>1*10^-12);

if ijumps
    disp('jumps')
end
    
%  centre x on 0 (without checking if it was already centred)
for kk = size(x,2)
    x(:,kk) = x(:,kk)+(x(1,kk)+x(end,kk))/2;
    
end
    


%%    Determine X positioning of the data 
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% find active range:
% varargin{1} = [active_L   xc_offset]
    active_L = varargin{1}(1)
    xc_offset = varargin{1}(2);
    
    L = x(end,1)-x(1,1) 
    x0 = x(1,1);

    if active_L>L
        disp('please enter an active length < full length')        
        output.message = 'ERROR: active length';
        return
    end

% centred or offset
if isnan(xc_offset) 
    
    text = ['     ~  analysis centred on the measured data  ~  '];
%     idx2 = (x(:,1)>=x(1,1)+(L-active_L)/2)&(x(:,1)<=x(1,1)+(L+active_L)/2);    
    idx2 = (x(:,1)>=(-active_L)/2)&(x(:,1)<=(active_L)/2); % assumes that x is centred!!

    if active_L>x(find(idx2,1,'last'),1)-x(find(idx2,1,'first'),1) % this corrects for active length (please check if it's OK)
%         idx2(find(idx2,1,'last')+1)=1;
        disp('analysis length is shorter than specified active length')
%         x(find(idx2,1,'last'),1)-x(find(idx2,1,'first'),1)
    end
    output.active_x = x(idx2,:); % active x
    if sum(diff(output.active_x(1,:)))
        disp('the x coordinates are not the same for all the scans, please check!!')
        output.active_x = output.active_x - repmat((output.active_x(1,:) + output.active_x(end,:))./2,size(output.active_x,1),1);
    end
    output.active_x_offset = 0;
    
else    % if centre IS offset    
    
    if x(1,1)>xc_offset-active_L/2
        idx2 = (x(:,1)>=x(1,1))&(x(:,1)<=x(1,1)+active_L);
        disp('you''re off the left edge, readjusting xc_offset')
        xc_offset = -(L - active_L)/2;
    elseif x(end,1)<xc_offset+active_L/2
        idx2 = (x(:,1)>=x(end,1)-active_L)&(x(:,1)<=x(end,1));
        disp('you''re off the right edge, readjusting xc_offset')
        xc_offset = (active_L)/2;
    else
        idx2 = (x(:,1)>=xc_offset-active_L/2)&(x(:,1)<=xc_offset+active_L/2);
%         xc_offset = xc_offset;
    end
    fprintf('     ~  analysis offset by %.1f mm ',xc_offset*10^3);
    output.active_x = x(idx2,:); % active x

    % recentre active_x    (mod 29/05/2019 treat every column independently!!)
    sum(diff(output.active_x(1,:)))
    if sum(diff(output.active_x(1,:)))
        disp('the x coordinates are not the same for all the scans, please check!!')
        output.active_x = output.active_x - repmat((output.active_x(1,:)+output.active_x(end,:))./2,size(output.active_x,1),1);
    else
        output.active_x = output.active_x - (output.active_x(1,1)+output.active_x(end,1))/2;
    end
    output.active_x_offset = -xc_offset;   % ???
end

% trim 
output.active_phi = phi(idx2,:);  %  active slope   
output.active_phi_roll = phi_roll(idx2,:);  %  active twist angle
output.active_height = height(idx2,:);  %  active figure  
% align to horizontal
for kk = 1:size(output.active_height,2)    
    output.active_height(:,kk)  = output.active_height(:,kk) - linspace(output.active_height(1,kk),output.active_height(end,kk),size(output.active_height,1))';
end      

verbose = 0;
if verbose
%     fprintf('\n\n\n  +++++++++++++++++++++++++++++++++++++++++++ \n')
%     fprintf('  vvvvvvvvvv  analyse1Ddata says:  vvvvvvvvvv \n\n')
    
%     fprintf('  *  x1 current = %f mm; \n  *  right trim = %f mm; \n', (output.active_x(1,1)-output.active_x_offset)*10^3)  

%     fprintf('\n ^^^^^^^^^^^  end of analyse1Ddata  ^^^^^^^^^^  \n')
%     fprintf(' +++++++++++++++++++++++++++++++++++++++++++++ \n\n\n')
end
fprintf('***\n')
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% do the fitting
params = varargin{2};
if numel(varargin{2})==4 % if fitting to ellipse, centre x values around 0
    xc_offset = (output.active_x(end,1)+output.active_x(1,1))/2;
    output.active_x = output.active_x - xc_offset;
    fit_to = 'ellipse';
else
    fit_to = 'cylinder';
end

% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% fit and integrate
for kk = 1:size(x,2)
   
    fitted = fitnom(squeeze(output.active_x(:,kk)),squeeze(output.active_phi(:,kk)),fit_to,params);
    
        output.slope_err(:,kk) = fitted.slope_err;
        output.slope_err_rms(kk) = fitted.slope_err_rms;
        output.height_err(:,kk) = fitted.height_err;
        output.height_err_rms(kk) = fitted.height_err_rms;
        if isfield(fitted,'RoC')
            output.roc(kk) = fitted.RoC;
            
        end    
        
end


output.message = 'All OK';
