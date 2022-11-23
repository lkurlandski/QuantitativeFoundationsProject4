function [] = main()

X = get_data();
Z_reduced = pca_(Z, 700, "eig");

end

function [X] = get_data()

n_people = 40;
n_samples = 10;
height = 112;
width = 92;
X = zeros(n_people * n_samples, height, width);
y = zeros(n_people * n_samples,);
for p=1:n_people
    for s=1:n_samples
        i = l * n_samples + s;
        X(i, :, :) = imread(strcat("./att_faces/s", num2str(p), "/", num2str(s), ".pgm"));
        y(i) = l;
    end
end

end