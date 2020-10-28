function [fea, labels] = read_lfw(filename)

load(filename);
fea = [same_images, diff_images];
labels = [ones(length(same_images), 1); zeros(length(diff_images), 1)];