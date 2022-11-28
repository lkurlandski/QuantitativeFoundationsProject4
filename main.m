%%% main script %%%


% Test the principal component analysis alorithms.

[data_train, label_train] = get_faces_dataset('data/att_faces', 1, 1:35, 1:8);
[data_test , label_test ] = get_faces_dataset('data/att_faces', 1, 1:35, 9:10);

test_1(data_train, label_train', data_test, label_test');
test_2(data_train, label_train', data_test, label_test');

fprintf("All tests have passed!\n")


function [] = test_1(Z_train, y_train, Z_test, y_test)
% Test classification accuracy of digits dataset using SVD algorithm

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

function [] = test_2(Z_train, y_train, Z_test, y_test)
% Test classification accuracy of digits dataset using EIG algorithm

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