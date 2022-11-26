function [Z] = add_bias(Z)
% Add a bias term (row of ones) to data.
% Args:
  % Z: p x n data
% Return:
  % Z: (p + 1) x n data with row of ones inserted as first row

Z = [ones(1, size(Z, 2)); Z];

end