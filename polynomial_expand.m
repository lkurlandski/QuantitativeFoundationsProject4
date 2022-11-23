% Perform polynomial expansion to some degree on data
function [Z] = polynomial_expand(Z, degree)

n_features = size(Z, 1);
n_samples = size(Z, 2);
Z_ = zeros(n_features  * (degree - 1), n_samples);

i = 1;
for d=2:degree
    for f=1:n_features
        Z_(i, :) = Z(f, :) .^ d;
        i = i + 1;
    end
end

Z = [Z; Z_];

end