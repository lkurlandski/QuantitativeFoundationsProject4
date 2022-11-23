% Find weights to fit data to labels
function [W] = fit(Z, y)

Y = onehotencode(y, 1, "ClassNames", unique(y));
W = Y * Z' / (Z * Z');

end