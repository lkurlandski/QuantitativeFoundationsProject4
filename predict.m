function [y_pred] = predict(W, Z)
% Given fitted weights and data, produce predicted class labels
% Args:
  % W: weight matrix with weights for each class
  % Z: data matrix with bias term already added
% Returns:
  % y_pred: predicted values for the data

Y = W * Z;
[~, y_pred] = max(Y);
y_pred = cast(y_pred, "uint8");

end