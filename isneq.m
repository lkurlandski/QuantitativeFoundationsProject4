% Determine if two floating point array are nearly equal
function [tf] = isneq(a, b)

tolerance = 0.0001;
tf = abs(a - b) > tolerance;
tf = any(tf, "all");
tf = ~tf;

end