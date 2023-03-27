% Sprawdzenie wzorów na baze Walsha
clc; clear; close all;

dt = 0.001;
t = 0:dt:1;



function Walsh(t, k, m)
    
end


function y = PI(t, t0, T)
    y = zeros(1, length(t));
    y(t > t0-T/2 & t < t0+T/2) = 1;
    y(t== t2-T/2 | t== t0+T/2) = 0.5;

end