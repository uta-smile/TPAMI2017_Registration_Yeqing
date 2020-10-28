function result = pair_corr(X)
%  
% function result = pair_corr()
% 
sz = size(X);
X = reshape(X, sz(1), 2, sz(2)/2);
result = squeeze(X(:, 1, :) .* X(:, 2, :));