clc; clear; close all;

dt = 0.001;
t = -3:dt:7;

y0 = PI(t, 1, 0);
y1 = TRI(t, 1, 0);
y2 = U(t, 0);
y3 = dirac(t, 0);


figure("Name", "Simple Signals");
    subplot(2, 2, 1)
        plot(t, y0); grid on;
    subplot(2, 2, 2)
        plot(t, y1); grid on;
    subplot(2, 2, 3)
        plot(t, y2); grid on;
    subplot(2, 2, 4)
        plot(t, y3); grid on;


