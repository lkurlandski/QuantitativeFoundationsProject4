function [Y] = pca_(X, k, mode)
% Perform principal component analysis on a dataset.
% Args:
  % X: data to reduce
  % k: number of principal components to select
  % mode: whether to use the "eig" or "svd" algorithm
% Returns:
  % Y: reduced dimensional data

X_mean = mean(X, 2);
X_norm = X - X_mean;
P = pc(X_norm, mode);
Y = P(:, 1:k)' * X_norm;

end