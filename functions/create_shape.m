function shape = create_shape(shape_type, L, dx, params, varargin);
% syntax:    shape = create_shape(shape_type, L, dx,params, sagitta)
% sagitta is an optional input that scales the shape
% recognized shape types are: flat,cylinder,ellipse,parabola,gaussian,poly,lorentzian
% params for gaussian:  sigma and mu; or sigma; or none
% params for poly:  deg and root; deg; or none

if nargin < 4
    disp('correct syntax is: shape = create_shape(shape_type, L, dx, params)')
    disp('type ''help create_shape'' for more information' )
    return
end

types = {'flat', 'cylinder','ellipse','parabola','gaussian','poly','lorentzian'};

if ~ischar(shape_type) || sum(strcmp(shape_type,types))==0
    disp('recognized shape types are: flat,cylinder,ellipse,parabola,gaussian,poly')
    disp('type ''help create_shape'' for more information' )
    return
end


x = 0:dx:L;
e = exp(1);
    
switch shape_type
    case 'flat'
    case 'cylinder'
    case 'ellipse' 
    case 'parabola'
    case 'gaussian'        
        % params are sigma and mu; or sigma; or none
        if numel(params) == 2
            sigma = params(1);
            mu = params(2);
        elseif numel(params) == 1            
            sigma = params(1);
            mu = (x(1)+x(end))/2; % centre peak on x 
        else
            sigma = L/10;
            mu = (x(1)+x(end))/2; % centre peak on x            
        end
        
        shape = (sigma * sqrt(2*pi))^-1* exp(-.5 * ((x - mu)/sigma) .^ 2) ; 
        
       
    case 'poly'
        % params are deg and root; deg; or none
        if numel(params) == 2
            deg = params(1);
            root = params(2);
        elseif numel(params) == 1
            deg = params(1);
            root = (x(1)+x(end))/2; % centre peak on x             
        else
            deg = params(1);
            root = (x(1)+x(end))/2; % centre peak on x 
        end
        shape = abs((x-root).^deg);
        
        
     case 'lorentzian'
         if numel(params) == 2
            gamma = params(1);
            x0 = params(2);
        elseif numel(params) == 1             
            gamma = params(1);
            x0 = (x(1)+x(end))/2; % centre peak on x 
         else            
            gamma = L/4;
            x0 = (x(1)+x(end))/2; % centre peak on x            
        end
        shape = 1/pi*(gamma/2)./ ((x - x0).^2 + (gamma/2).^2) ; 
         
         
end
shape = remove_tilt(shape);
% figure, subplot(1,2,1),plot(shape)
if nargin == 5
    sagitta = varargin{1};
    [~,ima] = max(abs(shape));
   
     shape = sign(sagitta)*(shape * abs(sagitta/shape(ima)));
end

shape = shape(:);
% subplot(1,2,2), plot(shape)



