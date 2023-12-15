clc; close all; clear;




k = 8;
f0 = 1000;
fs = 300;
f_a = f0/2;

dt = 1/(100*f0);
t = -(k+2)/f0:dt:(k+2)/f0;

dt_x = 1/fs;
t_x = -(k+2)/f0:dt_x:(k+2)/f0;
dt_xA = 1/f_a;
t_xA = -(k+2)/f0:dt_xA:(k+2)/f0;


y_0 = sin_0(k, f0);

[y_1, x_1] = sin_1(k, f0, fs);

[y_2, x_2, sa_2, RMSE_2] = sin_2(k, f0, fs);

[y_3, x_3, sa_3] = sin_2(k, f0, f_a);




figure(Name="Zad 1")
    hold on; grid on;
    plot(t, y_0, 'b');

figure(Name="Zad 2")
    hold on; grid on;
    plot(t, y_1, 'b');
    stem(t_x, x_1, 's', 'filled');


figure(Name="Zad 3")
    hold on; grid on;
    plot(t, y_2, 'b'); 
    stem(t_x, x_2, 's', 'filled');
    plot(t, sa_2, 'r');
    
    disp("RMSE = ");
    disp(RMSE_2);
    find_fsa(f0, fs);
figure(Name="Aliasing fs=f0/2")
    hold on; grid on;
    plot(t, y_3, 'b'); 
    stem(t_xA, x_3, 's', 'filled');
    plot(t, sa_3, 'r');




