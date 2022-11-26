function [a] = accuracy(y_true, y_pred)
% Measure the accuracy of predictions given ground truths.
% Args:
  % y_true: ground truth classification labels
  % y_pred: classification predictions
% Returns:
  % a: proportion correct, ie, accuracy

a = sum(y_true == y_pred) / length(y_true);

end