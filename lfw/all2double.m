function x = all2double(x)
% 
% function x = all2double(x)
% 

for i=1:numel(x),
    if ~isa(x{i}, 'double'),
        x{i} = double(x{i});
    end
end