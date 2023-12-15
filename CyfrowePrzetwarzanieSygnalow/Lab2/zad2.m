clc; clear; close all;




k = 8;
f0 = 1000;
fs = 0:100:10000;


RMSE = zeros(1, length(fs));


for i = 1:length(fs)
    [y_2, x_2, sa_2, RMSE_c] = sin_2(k, f0, fs(i));
    RMSE(i) = RMSE_c;
end

figure(Name="RMSE(fs)")
    hold on;  grid on;
    plot(fs, RMSE);
    xline(2*f0, "--");