function [x_train, y_train, x_test, y_test] = load_LBP(train_filename, test_filename)
% 
% function [x_train, y_train, x_test, y_test] = load_intensity(train_filename, test_filename)
%   train_filename - e.g. 'lfwcrop_view2_train_h1.mat'
%   test_filename - e.g. 'lfwcrop_view1_test.mat'

[x_train, y_train] = read_lfw(train_filename);
[x_test, y_test] = read_lfw(test_filename);

x_train = intensity(x_train);
sz = size(x_train);
tic;
x_train = batchLBP(x_train);
toc
x_train = reshape(x_train, [sz(1)*sz(2), sz(3)*sz(4)]);
% test data.
x_test = intensity(x_test);
tic;
x_test = batchLBP(x_test);
toc
sz = size(x_test);
x_test = reshape(x_test, [sz(1)*sz(2), sz(3)*sz(4)]);