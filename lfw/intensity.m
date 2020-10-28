function fea = intensity(x)
% function fea = rgbfea(x)
% Input:
%  x is 2xN cell array, and each elements is sz x sz (e.g. sz=64)
% Output:
%  fea is 4D-matrix of shape = [sz, sz, 2, N].
sz = size(x{1}, 1);
fea = cell2mat(x);
num_pair = size(fea, 2)/sz;
fea1 = reshape(fea(1:sz, :), [sz, sz, num_pair]);
fea2 = reshape(fea(sz+1:end, :), [sz, sz, num_pair]);
fea = zeros(sz, sz, 2, num_pair);
fea(:, :, 1, :) = fea1;
fea(:, :, 2, :) = fea2;