% Add a bis term (column of ones) to data
function [Z] = add_bias(Z)

Z = [ones(1, size(Z, 2)); Z];

end