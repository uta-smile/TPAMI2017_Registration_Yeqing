function X = apply_whiten(X, U, D, fudgefactor)

X(isnan(X)) = 0;
X = diag(1./(diag(D)+fudgefactor).^(1/2))*U'*X; % PCA projection
% X = U*diag(1./(diag(D)+fudgefactor).^(1/2))*U'*X; % ZCA projection