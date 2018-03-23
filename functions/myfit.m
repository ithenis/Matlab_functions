 function [vertex,theta, a] = myfit(x,y)
 % function fits to parabola (I think)
 % syntax: [vertex,theta, a] = myfit(x,y)
 
 
 %{
 theta = the angle of the directrix to the x-axis
         the angle of the parabola's axis of symmetry to the y-axis. 

Positive theta rotates the directrix/symmetry axis clockwise.

My code basically reduces the fit to a minimization over theta. 
For a given theta, the x,y coordinates are un-rotated and POLYFIT is applied, leading to a polyfit error. 
The code minimizes over this error with fminsearch (Nelder-Mead). In the code, you will also see

    [a,b,c]=deal(coeffs(1),coeffs(2), coeffs(3));

Here a,b,c are the coefficients of the unrotated parabola. 
To plot, you could derive coordinates for the unrotated parabola and then rotate by theta clockwise.

Your approach with A*x^2 + 2*B*xy +C*y^2 + 2*g*x + 2*f*y + c looks like it could work, too, but it requires a constrained solver. 
It would be interesting to see which produces the better fit. 
If nothing else, my approach might be a good way of deriving an initial parameter guess for yours. A few remarks, though,

    I think you have a mistake in B.^2= 2AC, which might account for some of your problems. I think it should really be B.^2= 4AC.
    I don't know how you got to A=cos(theta) and C=sin(theta). 
If that were true, then in the unrotated case theta=90 you would always reduce to a conventional parabola of the form y=x^2+p*x+q 
whose second derivative is always fixed at 2. Surely, you want it to reduce to something more general, like y=s*x^2+p*x+q.
 %}
 
 
    xy=[x(:),y(:)].';

    theta= fminsearch(@(theta) cost(theta,xy), 45);    

    [~,coeffs]=cost(theta,xy);

    [a,b,c]=deal(coeffs(1),coeffs(2), coeffs(3));

        xv=-b/2/a;

     vertex=R(-theta)*[xv;polyval(coeffs,xv)];

 function [Cost,coeffs,xx,yy] = cost(theta,xy)

    Rxy=R(theta)*xy;

    [xx,idx]=sort(Rxy(1,:));
    yy=Rxy(2,idx);

    [coeffs,S]=polyfit(xx,yy,2);

    Cost=S.normr;

 function Rmat=R(theta)

     Rmat=[cosd(theta), -sind(theta); sind(theta), cosd(theta)];