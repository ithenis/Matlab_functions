function output = get_ellipse(x, params)


P = params(1);
Q = params(2);
theta = params(3);
semn = params(4);

        RoC_ellipse = (2*P*Q)/((P+Q)*sin(theta));
        
        output.slope_ideal = semn*( ((P+Q)*sin(theta)) / ((P+Q)^2-((P-Q)^2)*(sin(theta)^2)) )...
            *( (P-Q)*cos(theta) - sqrt(P*Q)*(((P-Q)*cos(theta)-2*semn*x)./(sqrt(P*Q+((P-Q)*cos(theta))*(semn*x)-x.^2))));
        

        output.slope_ideal = sin(output.slope_ideal-mean(output.slope_ideal));
        output.figure_ideal = intnom(output.slope_ideal(:), x(2)-x(1), 1);
        
        % equivalent of excel's slope function
        b = 1/(sum((x-mean(x)).*(output.slope_ideal - mean(output.slope_ideal)))/sum((x-mean(x)).^2));
        
        if sign(b) == -1
            curvature = 'convex';
        else
            curvature = 'concave';
        end
        
        RoC = (b);
        output.RoC = RoC;
        output.RoC_ellipse = RoC_ellipse;
