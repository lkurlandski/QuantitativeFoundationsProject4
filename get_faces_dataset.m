function [X, y] = get_faces_dataset(path, shuffle, people, samples)
% Collect the flattened pixels from the att_faces dataset.
% Args:
  % path: path to the att_faces dataset (should NOT end in "/")
  % shuffle: optional boolean indicator of whether or not to randomize data
  % people: optional integer array indicating subset of faces to use
  % people: optional integer array indicating subset of samples to use
% Returns:
  % X: array of containing the pixels of the faces
  % y: array of containing the corresponding class labels

if ~exist("people", "var")
    people = 1:40;
end
if ~exist("samples", "var")
    samples = 1:10;
end

X = [];
y = [];
i = 1;

for p=people
    for s=samples
        f = strcat(path, "/s", num2str(p), "/", num2str(s), ".pgm");
        if isfile(f)
             m = imread(f);
             x = reshape(m', 1, []);  % row_1 .+ row_2 .+ ... .+ row_112
             X(:, i) = x;
             y(i) = p;
             i = i + 1;
        end
    end
end

X = cast(X, "double");
y = cast(y, "uint8");

if exist("shuffle", "var") && shuffle
    idx = randperm(length(y));
    X = X(:, idx);
    y = y(idx);
end

end