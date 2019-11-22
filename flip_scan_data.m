% slope_err = flipud(-slope_err);
% active_height = flipud(active_height);
% height_err = flipud(height_err);
% active_phi_roll = flipud(-active_phi_roll);


% for metrology base data

data0(:,2) = flipud(data0(:,2)); % slope

data1(:,2) = flipud(data1(:,2)); % active slope 
data1(:,3) = flipud(data1(:,3)); % active height
data1(:,4) = flipud(-data1(:,4)); % slope error
data1(:,5) = flipud(data1(:,5)); % height error