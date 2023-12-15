clc; close all; clear;

dt = 0.0001;
t = -5:dt:5;
t1 = 0:dt:7;
t2 = 0:dt:12;

fa =  2;    fb =  5;    fc =  30;
Aa =  2;    Ab = -3;    Ac =  1;
t0a = 0;    t0b = 1;    t0c = 0;

y1 = 2.*TRI(t1, 2, 3);
y1 = y1 + PI(t1, 1, 1.5);
y1 = y1 + PI(t1, 2, 5);
y1 = y1 + 2.*PI(t1, 2, 3);

y2 = 3.*TRI(t2, 4, 4).*abs(U(t2, 4)-1);
y2 = y2 + 3.*PI(t2, 2, 5);
y2 = y2 + 3.*TRI(t2, 10, 6).*U(t2,6);


a = Aa.*sin(2*pi*fa*t-t0a) .* PI(t, 3.5, 0);
b = Ab.*sin(2*pi*fb*t-t0b) .* TRI(t, 7, 0);
c = Ac.*sin(2*pi*fc*t1-t0c) .* y1;
d = Ac.*sin(2*pi*fc*t2-t0c) .* y2;


figure("Name", "Okna")
    subplot(4, 1, 1);
        plot(t, a); grid on;
    subplot(4, 1, 2);
        plot(t, b); grid on;
    subplot(4, 1, 3);
        plot(t1, c); grid on;
    subplot(4, 1, 4);
        plot(t2, d); grid on;



