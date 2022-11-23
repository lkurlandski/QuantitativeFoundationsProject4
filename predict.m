% Given fitted weights and data, produce predicted class labels
function [y_pred] = predict(W, Z)

Y = W * Z;
[~, y_pred] = max(Y);

end