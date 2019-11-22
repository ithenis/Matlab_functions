function output = fitnom(active_x,active_phi,fit_to,params)
% fit 1D slope data to specified curve
% SYNTAX:
%         output = fitnom(active_x,active_phi,fit_to,params)
% where:
%         fit_to = 'poly' / 'cylinder' / 'ellipse' / 'parabola'
%         params = [P Q theta semn] for ellipse fitting / R for others
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


active_x = active_x(:);
active_phi = active_phi(:);

dx = active_x(2) - active_x(1);

switch fit_to
    case 'poly'
        if nargin == 4
            R  = params(1);
        else
            R = -1;
        end
        
        if R<0
        % equivalent of excel's slope function
            b = sum((active_x-mean(active_x)).*(active_phi - mean(active_phi)))/sum((active_x-mean(active_x)).^2)  ;      
        else 
            b = R;  % specified radius
        end
        % equivalent of excel's intercept function
        a = mean(active_phi - mean(active_phi)) - b*mean(active_x);
        
        % aaand the slope (angle) error:
        output.slope_err = (active_phi-mean(active_phi)) - (b*active_x+a);
        
        % this is the equivalent of the STDEV function in excel. It uses the n-1 rule!
        output.slope_err_rms = sqrt(sum((output.slope_err-mean(output.slope_err)).^2)/(numel(output.slope_err)-1));
        
    case 'cylinder'
        
        % calculate sin(phi)
        sinphi = sin(active_phi-mean(active_phi));
        
        if nargin == 4
            R  = params(1);
        else
            R = -1;
        end
       
        if R<0
        % equivalent of excel's slope function
            b = 1/(sum((active_x-mean(active_x)).*(sinphi - mean(sinphi)))/sum((active_x-mean(active_x)).^2));       
        else 
            b = 1/(sum((active_x-mean(active_x)).*(sinphi - mean(sinphi)))/sum((active_x-mean(active_x)).^2));            
            fprintf('\n best fit cylinder radius: %f [m] \n', b);
            b = R;  % specified radius            
        end        
       
        if sign(b) == -1
            curvature = 'convex';
        else
            curvature = 'concave';
        end
        
        output.RoC = (b);
        
        % equivalent of excel's intercept function
        a = mean(active_x) - b*mean(sinphi);
        
        output.slope_ideal =  asin((active_x-a)/b);
        % slope (phi) error:
        output.slope_err = (active_phi-mean(active_phi)) - asin((active_x-a)/b);
        
        % this is the equivalent of the STDEV function in excel. It uses the n-1 rule!
        output.slope_err_rms = sqrt(sum((output.slope_err-mean(output.slope_err)).^2)/(numel(output.slope_err)-1));
        
    case 'ellipse'
        if nargin == 4
            P  = params(1);
            Q  = params(2);
            theta = params(3);
            semn = params(4);
        elseif ~exist('skip_ellipse_param','var')
            prompt = {'P (in metres)','Q (in metres)','theta (in radians)','sign (- or +)'};
            default = {'','','0.','-'};
            answer3 = inputdlg(prompt,'title',1,default);
            
            if isempty(answer3)
                clear
                disp('user abort')
                return
            end            
            P  = str2num(answer3{1});
            Q  = str2num(answer3{2});
            theta = str2num(answer3{3});
            
            if strcmp(answer3{4},'+')
                semn = 1; % cadran III
            else
                semn = -1;  % cadran IV
            end
            skip_ellipse_param = 1;
        end
        
        RoC_ellipse = (2*P*Q)/((P+Q)*sin(theta));
%         fprintf(' ellipse radius: %f [m] ', RoC_ellipse);
        output.slope_ideal = semn*( ((P+Q)*sin(theta)) / ((P+Q)^2-((P-Q)^2)*(sin(theta)^2)) )...
            *( (P-Q)*cos(theta) - sqrt(P*Q)*(((P-Q)*cos(theta)-2*semn*active_x)./(sqrt(P*Q+((P-Q)*cos(theta))*(semn*active_x)-active_x.^2))));
        

        output.slope_err = ((active_phi-mean(active_phi)) - output.slope_ideal);  % micro radians
        
        
        sinphi = sin(active_phi-mean(active_phi));
        
        
        % equivalent of excel's slope function
        b = 1/(sum((active_x-mean(active_x)).*(sinphi - mean(sinphi)))/sum((active_x-mean(active_x)).^2));
        
        if sign(b) == -1
            curvature = 'convex';
        else
            curvature = 'concave';
        end
        
        RoC = (b);
        output.RoC = RoC;
        output.RoC_ellipse = RoC_ellipse;
        % !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        output.slope_err = output.slope_err - mean(output.slope_err);
        % !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        
        % this is the equivalent of the STDEV function in excel. It uses the n-1 rule!
        output.slope_err_rms = sqrt(sum((output.slope_err-mean(output.slope_err)).^2)/(numel(output.slope_err)-1));


case 'parabola'
    disp('not yet')


end


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% height error
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


tango_err = tan(output.slope_err);

output.height_err = 0.5*([0; tango_err(1:end-1)] + tango_err)*dx;
output.height_err = cumsum(output.height_err);
% output.height_err = output.height_err - output.height_err(1);
output.height_err = output.height_err - mean(output.height_err);
% this is the equivalent of the STDEV function in excel. It uses the n-1 rule!
output.height_err_rms = sqrt(sum((output.height_err-mean(output.height_err)).^2)/(numel(output.height_err)-1));
% figure
% plot(output.height_err)
