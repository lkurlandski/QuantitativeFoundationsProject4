function [X_reduced] = pca_(X, k, mode)

[Y, P] = pc(X, mode);
X_reduced = P(1:k, 1:k) * Y(1:k, :);

end