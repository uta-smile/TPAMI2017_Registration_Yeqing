function [x_train_split, y_train_split, x_test_split, y_test_split] = load_lfw_fold(type, test_fold, max_fold)
% 
% function [x_train_split, y_train_split, x_test_split, y_test_split] = load_lfw_fold(type, test_fold, max_fold)
% x_train_split, y_train_split, x_test_split, y_test_split are 2x1 cell
% array. The second element is test fold and the first element is the rest
% all folds.
% 

if strcmp(type, 'inten'),
    train_tmpl = 'lfwcrop_view2_f%d_inten_raw.mat';
elseif strcmp(type, 'lbp'),
    train_tmpl = 'lfwcrop_view2_f%d_lbp_raw.mat';
else
    error('Unknown feature type.');
end

[x_train_split, y_train_split, x_test_split, y_test_split] = ...
    deal(cell(2,1), cell(2,1), cell(2,1), cell(2,1));

for i=1:max_fold,
    if i == test_fold,
        continue;
    end
    filename = sprintf(train_tmpl, i);
    [x_train, y_train, x_test, y_test] = load_one_fold(filename);
    x_train_split{1} = [x_train_split{1}, x_train];
    y_train_split{1} = [y_train_split{1}; y_train];
    x_test_split{1} = [x_test_split{1}, x_test];
    y_test_split{1} = [y_test_split{1}; y_test];
end
clear x_train y_train x_test y_test

filename = sprintf(train_tmpl, test_fold);
[x_train_split{2}, y_train_split{2}, x_test_split{2}, y_test_split{2}] = ...
    load_one_fold(filename);

function [x_train, y_train, x_test, y_test] = load_one_fold(filename)

load(filename, 'x_train', 'y_train', 'x_test', 'y_test');
