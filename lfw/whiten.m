function [X, U, D] = whiten(X, k, fudgefactor)
% function [X] = whiten(X,fudgefactor)
%   X is a D by N matrix.
%   k is the number of dimensions to keep.
%   fudgefactor is small constant to avoid divide-by-zero error. 
%     e.g. 1e-6 times the largest eigenvalue of the A matrix.
% 
% Ref: https://xcorr.net/2011/05/27/whiten-a-matrix-matlab-code/
% 
X(isnan(X)) = 0;
X = bsxfun(@minus, X, mean(X, 2));
sz = size(X);
if sz(1) < sz(2),
    cov = X*X';
    [U,D] = eig(cov); clear cov;
else
    [U, D, V] = svd(X, 0);
end
eigenvalue = diag(D)'; clear D;
[eigenvalue,order] = sort(eigenvalue,'descend');
U = U(:,order(1:k));
topD = eigenvalue(1:k); clear order;
D = diag(topD);
X = diag(1./(topD+fudgefactor).^(1/2))*U'*X; % PCA projection
end