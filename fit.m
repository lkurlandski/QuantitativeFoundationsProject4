function [W] = fit(Z, y)
% Find weights to fit data to labels.
% Args:
  % Z: p x n data, probably should include bias term added
  % y: corresponding class labels
% Returns:
  % W: weight matrix

Y = onehotencode(y, 1, "ClassNames", unique(y));
W = Y * Z' / (Z * Z');

end