function output = create_ellipse(P, Q, theta, semn, L, dx)
% creates an ellipse  to beamline specification
% syntax:  output = create_ellipse(P,Q,theta,L,dx)
% inputs: 
%     P [m] = distance from source to the centre of the mirror 
%     Q [m] = distance from centre of the mirror to the sample
%     theta [rad] = incidence angle [deg]
%     semn = -1 if lower right quadrant|+1 if lower left quadrant
%     L [m] = length of parabola;
%     dx [m] = sampling step;
% outputs:
%       x [m] centred at 0, slope [rad], height [m], radius [m]

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



output.x = -L/2:dx:L/2;
output.slope = semn*( ((P+Q)*sin(theta)) / ((P+Q)^2-((P-Q)^2)*(sin(theta)^2)) )...
    *( (P-Q)*cos(theta) - sqrt(P*Q)*(((P-Q)*cos(theta)-2*semn*output.x)./(sqrt(P*Q+((P-Q)*cos(theta))*(semn*output.x)-output.x.^2))));
output.slope = output.slope - mean(output.slope);
output.slope = output.slope;
output.height = intnom(output.slope,dx);
output.radius = (2*P*Q)/((P+Q)*sin(theta));


