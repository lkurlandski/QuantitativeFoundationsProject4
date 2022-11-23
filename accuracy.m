% Measure the accuracy of predictions given ground truths
function [a] = accuracy(y, y_pred)

a = sum(y == y_pred) / length(y);

end