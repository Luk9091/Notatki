% Aproksymnacja sygnału schodkowego za pomoca Fouriera
close all; clear; clc;

dt = 0.01;
t_max = 5;
t = 0:dt:t_max;

n = [1, 2, -2, -1];
T = 1;      f_T = 1/T;

x = zeros(1, length(t));

for 







function y = PI(t, T, t0)
    y = zeros(1, length(t));
    dt= t(2)-t(1);
    t1= t0-T/2;
    t2= t0+T/2;
    
    y(t > t1 & t < t2) = 1;
    
    y((t>(t1-dt/2))&(t<(t1+dt/2)))=1/2;    
    y((t>(t2-dt/2))&(t<(t2+dt/2)))=1/2;
end

function c=calka(y,dx)
    c=(sum(y)-(y(1)+y(end))/2)*dx;
end