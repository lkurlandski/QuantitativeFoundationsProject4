function [] = test_pca()
% Test the principal component analysis alorithms informally.

test_1();
test_2();

fprintf("All tests have passed!\n")

end


function [] = test_1()
% Test classification accuracy of digits dataset using SVD algorithm

[y_train, Z_train] = readtrain(10, nan);
[y_test, Z_test] = readtest(10, nan);

Z_train = cast(Z_train, "double");
Z_test = cast(Z_test, "double");
y_train = cast(y_train', "uint8");
y_test = cast(y_test', "uint8");

Z = pca_([Z_train Z_test], 100, "svd");
Z_train = Z(:, 1:size(Z_train, 2));
Z_test = Z(:, size(Z_train, 2) + 1:end);
Z_train = add_bias(Z_train);
Z_test = add_bias(Z_test);

W = fit(Z_train, y_train);

y_pred = predict(W, Z_train);
a = accuracy(y_pred, y_train);
fprintf("Train accuracy using SVD algorithm: %f\n", a);

y_pred = predict(W, Z_test);
a = accuracy(y_pred, y_test);
fprintf("Test accuracy using SVD algorithm: %f\n", a);

end


function [] = test_2()
% Test classification accuracy of digits dataset using EIG algorithm

[y_train, Z_train] = readtrain(10, nan);
[y_test, Z_test] = readtest(10, nan);

Z_train = cast(Z_train, "double");
Z_test = cast(Z_test, "double");
y_train = cast(y_train', "uint8");
y_test = cast(y_test', "uint8");

Z = pca_([Z_train Z_test], 100, "eig");
Z_train = Z(:, 1:size(Z_train, 2));
Z_test = Z(:, size(Z_train, 2) + 1:end);
Z_train = add_bias(Z_train);
Z_test = add_bias(Z_test);

W = fit(Z_train, y_train);

y_pred = predict(W, Z_train);
a = accuracy(y_pred, y_train);
fprintf("Train accuracy using EIG algorithm: %f\n", a);

y_pred = predict(W, Z_test);
a = accuracy(y_pred, y_test);
fprintf("Test accuracy using EIG algorithm: %f\n", a);

end