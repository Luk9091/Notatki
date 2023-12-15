clc; clear; close all;

k = 8;
f0 = 1000;
fs = f0*2;
phi = pi/4;

[y, x, sa] = sin_3(k, f0, fs, phi);

dt = 1/(100*f0);
t = -(k+2)/f0:dt:(k+2)/f0;

dt_x = 1/fs;
t_x = -(k+2-phi/(2*pi))/f0:dt_x:(k+2-phi/(2*pi)-1)/f0;

figure(Name = "Probkowanie krytyczne z roznym phi")
    hold on; grid on;
    plot(t, y, 'b'); 
    stem(t_x, x, 's', 'filled');
    plot(t, sa, 'r');