clc; clear; close all;

dt = 0.0001;
t1 = 0:dt:7;
t2 = 0:dt:12;

y1 = 2.*TRI(t1, 2, 3);
y1 = y1 + PI(t1, 1, 1.5);
y1 = y1 + PI(t1, 2, 5);
y1 = y1 + 2.*PI(t1, 2, 3);

y2 = 3.*TRI(t2, 4, 4).*abs(U(t2, 4)-1);
y2 = y2 + 3.*PI(t2, 2, 5);
y2 = y2 + 3.*TRI(t2, 10, 6).*U(t2,6);

figure("Name", "First")
    plot(t1, y1); grid on;

figure("Name", "Second")
    plot(t2, y2); grid on;