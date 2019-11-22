function output = create_parabola(r,theta,L,dx)
% creates a parabola to beamline specification
% syntax:  output = create_parabola(r,theta,L,dx)
%   inputs: 
%     L - length of parabola;
%     dx = sampling step;
%     r = focal distance to the centre of the mirror
%     theta = incidence angle [rad]
% this function was developed and tested for a mirror in the upper right quadrant


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%theta = pi/180*theta; %rad

% other parameters
FM1 = r*cos(2*theta);  %[m] distance from focus to centre of the mirror  
yM = r*sin(2*theta);   %[m] distance from centre of the mirror to axis of symmetry

% define Vertex as Origin:
h = 0;    k = 0;

% p = xM - FM1
% 4*p*xM = yM^2
% --> 4*(xM-FM1)*xM = 4*xM^2 - 4*FM1*xM = yM^2

xM = (FM1+sqrt(FM1^2+yM^2))/2; % the other root is negative
p = xM - FM1;

% Mirror is in upper right quadrant: create upper half of parabola
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

parabola_right_up = @(x) (4*p*(x-h)).^0.5 + k;
%dx = 0.00025;

output.x = xM-L/2:dx:xM+L/2;
output.height = parabola_right_up(output.x);

output.x = output.x(:);
output.height = output.height(:);

% optical surface is on the interior of the parabola (concave) 
output.height = flipud(-output.height); 

output.slope = diff(output.height)./diff(output.x);
output.slope = interp1(output.x(2:end)-dx/2,output.slope,output.x,'pchip');

output.slope = output.slope - mean(output.slope);
