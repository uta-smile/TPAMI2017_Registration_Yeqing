function X = batchLBP(X)
sz = size(X);
for i = 1:sz(4),
    X(:, :, 1, i) = efficientLBP(squeeze(X(:, :, 1, i)));
    X(:, :, 2, i) = efficientLBP(squeeze(X(:, :, 2, i)));
end