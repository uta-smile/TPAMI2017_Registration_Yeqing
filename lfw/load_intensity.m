function [x_train, y_train, x_test, y_test] = load_intensity(train_filename, test_filename, opts)
% 
% function [x_train, y_train, x_test, y_test] = load_intensity(train_filename, test_filename)
%   train_filename - e.g. 'lfwcrop_view2_train_h1.mat'
%   test_filename - e.g. 'lfwcrop_view1_test.mat'

if ~exist('opts', 'var')
    opts = struct('whiten', 1, 'sqrt', 0);
end

[x_train, y_train] = read_lfw(train_filename);
[x_test, y_test] = read_lfw(test_filename);
[x_train, y_train, x_test, y_test] = extract_intensity(x_train, y_train, x_test, y_test, opts);
