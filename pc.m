function [P, variances] = pc(X, mode)
% Get the principal components.
% Args:
  % X: normalized data to get pcs for
  % mode: whether to use the "eig" or "svd" algorithm
% Returns:
  % P: ranked principal components
  % variances: proportion variance explained for each number of pcs include

if mode == "eig"
    [P, variances] = pc_eig(X);
elseif mode == "svd"
    [P, variances] = pc_svd(X);
end

if ~all(size(P) == [size(X, 1) size(X, 1)])
    error("The principal component matrix is not the right shape.")
end

end


function [P, variances] = pc_eig(X)
% Principal components using eigenvalues and vectors
% Args:
  % X: normed data
% Returns:
  % P: ranked principal components
  % variances: proportion variance explained for each number of pcs include
% Note:
    % Given matrix A, eig returns eigenvectors, V, and eigenvalues, D, s.t.
    % AV = VD, where the eigenvalues are sorted in ascending order.
    % We flip A along its columns to reverse the order of the eigenvectors,
    % and make the eigenvalues appear in descending order, so our principle
    % component matrix is in order of the most significant components.

A = X * X';
[V, D] = eig(A);
V = flip(V, 2);
D = fliplr(fliplr(D)');
P = V / (size(X, 2) - 1);
P = flip(P);
if ~isneq(A * V, V * D)
    error("Flipping has gone wrong.")
end

variances = nan; % FIXME: implement

end


function [P, variances] = pc_svd(X)
% Principal components using singular value decomposition
% Args:
  % X: normed data
% Returns:
  % P: ranked principal components
  % variances: proportion variance explained for each number of pcs include
% Note:
    % svd sorts the singular values in descending order, 
    % so there is no need to flip anything like there was with eig.

[U, S, V] = svd(X);
eigenvalues = diag(S) .^ 2;
sum_of_eigenvalues = sum(eigenvalues);
working_sum = 0;
variances = ones(size(X, 1), 1);
for i=1:length(eigenvalues)
    working_sum = working_sum + eigenvalues(i);
    variances(i) = working_sum / sum_of_eigenvalues;
end
P = U;

end