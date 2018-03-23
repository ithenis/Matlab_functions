function [R,T] = align_3Ddata(A, B)
%{
This function finds the optimal Rigid/Euclidean transform in 3D space
It expects as input two Nx3 matrices of 3D points.
It returns R, t for the first dataset
Apply as:
    [R,T] = align_3Ddata(A, B)
    A2 = (R*A') + repmat(T, 1, h*w);
    A2 = A2';

%}

% expects row data
    if nargin ~= 2
	    error('Missing parameters');
    end

    for kk = 1: numel(size(A))
        assert(size(A,kk)==size(B,kk))
    end

    centroid_A = mean(A);
    centroid_B = mean(B);

    N = size(A,1);

    H = (A - repmat(centroid_A, N, 1))' * (B - repmat(centroid_B, N, 1));
    
    [U,S,V] = svd(H); %#ok<ASGLU>
    
    R = V*U';

    if det(R) < 0
%         disp('Reflection detected\n');
        V(:,3) = -1;
        R = V*U';
    end

    T = -R*centroid_A' + centroid_B';
end

