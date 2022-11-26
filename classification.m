function [a_train, a_test] = classification(p, k)
% Perform multiclass classification on the att_faces dataset.
% Args:
  % p: degree of polynomial expansion to apply (-1 or 0 for no poly expand)
  % k: number of pc to use for pca (-1 or 0 for no pca)
% Returns:
  % a_train: accuracy of the system on the training set
  % a_train: accuracy of the system on the test set
% Notes:
  % At the moment, this achieves abysmal accuracy.

path = "./att_faces";
train_path = "data/train";
test_path = "data/test";

if ~exist(train_path, "dir") || ~exist(test_path, "dir")
    split(path, train_path, test_path);
end

shuffle = true;
[Z_train, y_train] = get_faces_dataset(train_path, shuffle);
[Z_test, y_test] = get_faces_dataset(test_path, shuffle, 1:35);

if p > 0
    Z_train = polynomial_expand(Z_train, p);
    Z_test = polynomial_expand(Z_test, p);
end
if k > 0
    Z_train = pca_(Z_test, k, "eig");
    Z_test = pca_(Z_test, k, "eig");
end

Z_train = add_bias(Z_train);
Z_test = add_bias(Z_test);
W = fit(Z_train, y_train);
y_pred_train = predict(W, Z_train);
y_pred_test = predict(W, Z_test);
a_train = accuracy(y_train, y_pred_train);
a_test = accuracy(y_test, y_pred_test);

end


function [y] = binarize(y, class)

for i=1:size(y, 2)
    if y(i) == class
        y(i) = 1;
    else
        y(i) = 2;
    end
end

y = cast(y, "uint8");

end


function [] = split(path, train_path, test_path)
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
        if p <= 35 && s <= 8
            [~, ~, ~] = mkdir(strcat(train_path, d));
            copyfile(strcat(path, d, f), strcat(train_path, d, f));
        elseif p <= 35 && s <= 10
            [~, ~, ~] = mkdir(strcat(test_path, d));
            copyfile(strcat(path, d, f), strcat(test_path, d, f));
        elseif p <= 40 && s<= 10
            [~, ~, ~] = mkdir(strcat(test_path, d));
            copyfile(strcat(path, d, f), strcat(test_path, d, f));
        else
            error("Something has gone horribly wrong.")
        end
    end
end

end