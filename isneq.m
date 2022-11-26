function [tf] = isneq(a, b)
% Determine if two floating point array are nearly equal.
% Args:
  % a: matrix/array
  % b: matrix/array
% Returns:
  % tf: boolean result of comparison

tolerance = 0.0001;
tf = abs(a - b) > tolerance;
tf = any(tf, "all");
tf = ~tf;

end