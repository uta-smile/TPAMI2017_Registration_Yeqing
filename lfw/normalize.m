function [X, X_max, X_min] = normalize(X, X_max, X_min)
% 
% function X = normalize(X)
%  Linearly scaling each attribute to the range [0, 1].

if ~exist('X_min', 'var'),
    X_min = min(X, [], 2);
end
X = bsxfun(@minus, X, X_min);
if ~exist('X_max', 'var'),
    X_max = max(X, [], 2);
end
X = bsxfun(@rdivide, X, X_max);