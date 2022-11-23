function [Y, P] = pc(X, mode)

X_tilda = X - mean(X, 2);

% Given matrix A, eig returns eigenvectors, V, and eigenvalues, D, s.t.
% AV = VD, where the eigenvalues are sorted in ascending order.
% We flip A along its columns to reverse the order of the eigenvectors,
% and make the eigenvalues appear in descending order, so our principle
% component matrix is in order of the most significant components.
% We don't actually need the D matrix, but its useful for debugging.
if mode == "eig"
    A = X_tilda * X_tilda';
    [V, D] = eig(A);
    V = flip(V, 2);
    D = fliplr(fliplr(D)');
    if ~isneq(A * V, V * D)
        error("Flipping has gone wrong.")
    end
    P = V / (length(X) - 1);
    P = flip(P);

% svd sorts the singular values in descending order, so there is no need to
% flip anything.
% We don't actually need the S, V matrices, but its useful for debugging.
elseif mode == "svd"
    [U, S, V] = svd(X_tilda);
    P = U;
end

Y = P' * X_tilda;

end