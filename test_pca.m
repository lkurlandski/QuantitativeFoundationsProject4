function [] = test_pca()

test_1()

fprintf("All tests have passed!\n")

end

function [] = test_1()

X = iris_dataset;
X_reduced_1 = pca_(X, 3, "eig");
X_reduced_2 = pca_(X, 3, "svd");

end