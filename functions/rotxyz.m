function M = rotxyz(D, rx, ry, rz)

% rotate matrix D 
% D = [X; Y; Z];
% rx, ry, rz = the rotation angles in radians

if nargin ~= 4
    disp('correct syntax is: M = rotxyz(D,rx,ry,rz)')
    return
end

if numel(size(D))~=2 || size(D,2)~=3
    disp('correct format for D is: D = [X,Y,Z]')
    return
end


% Rotation matrices (rad.):

    Rx = [1 0 0;
          0 cos(rx) -sin(rx);
          0 sin(rx) cos(rx)];

    Ry = [cos(ry) 0 sin(ry);
          0 1 0;
          -sin(ry) 0 cos(ry)];

    Rz = [cos(rz) -sin(rz) 0;
          sin(rz) cos(rz) 0;
          0 0 1];
  
% Rotation matrix
R = Rx*Ry*Rz;

% Transform data-matrix model-matrix 
M = (R*D')';