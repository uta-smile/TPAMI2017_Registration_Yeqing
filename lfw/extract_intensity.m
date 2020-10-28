function [x_train, y_train, x_test, y_test] = extract_intensity(x_train, y_train, x_test, y_test, opts)
x_train = intensity(x_train);
sz = size(x_train);
x_train = reshape(x_train, [sz(1)*sz(2), sz(3)*sz(4)]);
% test data.
x_test = intensity(x_test);
sz = size(x_test);
x_test = reshape(x_test, [sz(1)*sz(2), sz(3)*sz(4)]);

if opts.sqrt,
    x_train = sqrt(x_train);
    x_test = sqrt(x_test);
end

if opts.whiten,
    tic;
    [x_train, U, D] = whiten(x_train, 500, 1e-6);
    toc
    x_test = apply_whiten(x_test, U, D, 1e-6);
end