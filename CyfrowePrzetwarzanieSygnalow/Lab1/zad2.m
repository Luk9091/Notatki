clc; clear; close all;

dt = 0.001;
t = 0:dt:5;

x = 5.*PI(t, 2, 2);
y = 7.*TRI(t, 3, 4);

figure("Name", "Parametric function")
    hold on; grid on;
    plot(t, x);
    plot(t, y);