function r = evaluate(y_true, y_pred)
% Copied and pasted from MatLab Central.

idx = (y_true() == 1);
p = length(y_true);
n = length(y_true(~idx));
N = p + n;

tp = sum(y_true(idx) == y_pred(idx));
tn = sum(y_true(~idx) == y_pred(~idx));
fp = n - tn;
fn = p - tp;
tp_rate = tp / p;
tn_rate = tn / n;

accuracy = (tp + tn) / N;
sensitivity = tp_rate;
specificity = tn_rate;
precision = tp / (tp + fp);
recall = sensitivity;
f_measure = 2 * ((precision * recall) / (precision + recall));
gmean = sqrt(tp_rate * tn_rate);

r = [accuracy sensitivity specificity precision recall f_measure gmean];

end