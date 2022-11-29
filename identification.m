function [a_train, a_test] = identification(p, v)
% Perform multiclass classification on the att_faces dataset.
% Args:
  % p: degree of polynomial expansion to apply (-1 or 0 for no poly expand)
  % v: proportion of variance that should be explained (0 for no PCA)
% Returns:
  % a_train: accuracy of the system on the training set
  % a_train: accuracy of the system on the test set

path = "./att_faces";
train_path = "data/identification/train";
test_path = "data/identification/test";

if ~exist(train_path, "dir") || ~exist(test_path, "dir")
    data_split(path, train_path, test_path);
end

[Z_train, y_train] = get_faces_dataset(train_path, true);
[Z_test, y_test] = get_faces_dataset(test_path, true);

if p > 1
    Z_train = polynomial_expand(Z_train, p);
    Z_test = polynomial_expand(Z_test, p);
end

if v > 0
    Z_train = Z_train - mean(Z_train, 2);
    [P, variances] = pc(Z_train, "svd");
    for k=1:length(variances)
        if variances(k) >= v
            break
        end
    end
    Z_train = P(:, 1:k)' * Z_train;
    Z_test = Z_test - mean(Z_test, 2);
    Z_test = P(:, 1:k)' * Z_test;
end

Z_train = add_bias(Z_train);
Z_test = add_bias(Z_test);

W = fit(Z_train, y_train);
y_pred_train = predict(W, Z_train);
y_pred_test = predict(W, Z_test);
a_train = accuracy(y_train, y_pred_train);
a_test = accuracy(y_test, y_pred_test);

end


function [] = data_split(path, train_path, test_path)
% Construct a train and test split for the att_faces dataset.
% Args:
  % path: path to the att_faces dataset (should NOT end in "/")
  % train_path: path to the train folder (should NOT end in "/")
  % test_path: path to the test folder (should NOT end in "/")

[~, ~, ~] = mkdir(train_path);
[~, ~, ~] = mkdir(test_path);
for p=1:40
    for s=1:10
        d = strcat("/s", num2str(p));
        f = strcat("/", num2str(s), ".pgm");
        if s <= 8
            [~, ~, ~] = mkdir(strcat(train_path, d));
            copyfile(strcat(path, d, f), strcat(train_path, d, f));
        elseif s <= 10
            [~, ~, ~] = mkdir(strcat(test_path, d));
            copyfile(strcat(path, d, f), strcat(test_path, d, f));
        else
            error("Something has gone horribly wrong.")
        end
    end
end

end