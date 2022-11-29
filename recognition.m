function [a, f] = recognition(k)
% Perform recognition of faces/non faces
% Args:
  % k: number of pc to use for pca (-1 or 0 for no pca)
% Returns:
  % a: accuracy
  % f: fmeasure

path = "./att_faces";
non_faces_path = "./data/non_faces";
train_path = "./data/recognition/train";
test_path = "./data/recognition/test";

if ~exist(train_path, "dir") || ~exist(test_path, "dir")
    data_split(path, train_path, test_path);
end

[Z_train, y_train] = get_faces_dataset(train_path, false, 1:35);
[Z_test, y_test] = get_faces_dataset(test_path, false);
[Z_unk, y_unk] = get_non_faces_dataset(non_faces_path, 41);
y_test = [y_test(1: 2 * 35) 36 * ones(1, 10 * 5) y_unk];
y_test = cast(y_test, "uint8");
Z_test = [Z_test Z_unk];

M = mean(Z_train, 2);
P = pc(Z_train, "svd");

% Determine the representative weights for the projection for each class
W_train = zeros(k, 35); % (num PCs x num classes)
for i=1:size(Z_train, 2)
    x_i = Z_train(:, i);
    y_i = y_train(i);
    for j=1:k
        l = P(:, j)';
        r = x_i - M;
        W_train(j, y_i) = W_train(j, y_i) + (l * r);
    end
end
W_train = W_train / 8; % 8 train samples per class, so take mean

% Project test data onto face space
W = zeros(k, size(Z_test, 2));  % (num PCs x num samples)
for i=1:size(Z_test, 2)
    for j=1:k
        l = P(:, j)';
        r = Z_test(:, i) - M;
        W(j,i) = l * r;
    end
end

distances = [];
classes = [];
for i=1:size(W, 2)
    w_i = W(:, i); % (num PCs x 1)
    d = 2^16 - 1;
    c = nan;
    for j=1:size(W_train, 2) % for every class in the training set
        w_j = W_train(:, j); % (num PCs x 1)
        d_ = norm(w_i - w_j);
        if d_ < d
            c = j;
            d = d_;
        end
    end
    distances(i) = d;
    classes(i) = c;
end

T_1 = 3500;
y_pred = [];
for i=1:length(distances)
    d = distances(i);
    if d < T_1
        y_pred(i) = 1; % known face
    else
        y_pred(i) = 0; % not a face
    end
end

a_identification = accuracy(classes, y_test);
y_test = [ones(1, 120) zeros(1, 10)];
y_test = cast(y_test, "uint8");
a_recognition = accuracy(y_pred, y_test);
a = a_recognition;

ev = evaluate(y_pred, y_test);
f = ev(6);

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


function [X, y] = get_non_faces_dataset(path, label)
% Collect the nonfaces images.
% Args:
  % path: path to the non-faces dataset (should NOT end in "/")
  % label: inter label to assign to each sample
% Returns:
  % X: array of containing the pixels of the images
  % y: array of containing the corresponding class label

X = [];
y = [];
for i=0:9
    f = strcat(path, "/", num2str(i), ".png");
    m = imread(f);
    m = rgb2gray(m);
    x = reshape(m', 1, []);  % row_1 .+ row_2 .+ ... .+ row_112
    X(:, i+1) = x;
    y(i+1) = label;
end

X = cast(X, "double");
y = cast(y, "uint8");

end