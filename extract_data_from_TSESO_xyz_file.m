    
    keep xyz
    clc

    nx = numel(unique(xyz(:,1)));
    ny = numel(unique(xyz(:,2)));
    dx = 0.000233938;
    % get x [m]:
    x_map = xyz(:,1)*0.000233938;
    x_map = reshape(x_map,[nx, ny])';
    x = x_map(1,:);
    
    y_map = xyz(:,2)*0.000233938;
    y_map = reshape(y_map,[nx, ny])';
    y = y_map(:,1);
    
    map = xyz(:,3);
    map = reshape(map,[nx, ny])';

    dx = (max(x(:))-min(x(:)))/(nx-1);
    dy = (max(y(:))-min(y(:)))/(ny-1);

        
   instrument = 'TSESO';