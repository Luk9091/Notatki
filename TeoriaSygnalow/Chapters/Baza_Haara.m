% Sprawdzenie wzoru na bazę Haara:
clc; close all; clear;


dt = 0.001;
t = 0:dt:0.5;

k_max = 3;

H_0_0 = PI(t, 0.5, 1);
H_1 = zeros(1, length(H_0_0));
H_2 = zeros(1, length(H_0_0));
% H = H + H_0_0;
% H_2 = H_2 + H_0_0;


% Dopytać bo totalnie nie rozumiem... :C k= const? I zmieniamy tylko m dla bazy Harra????

for k = 0:k_max
    for m = 1:2^k
        H_prim = Haara(t, k, m);
        H_1 = H_1 + H_prim;
        % plot(t, H_prim);
    end
end

figure(1);
    grid on; hold on;
    plot(t, H_1)


for m = 1:2^k_max
    H_2 = H_2 + Haara(t, k_max, m);
end

figure(2);
    grid on; hold on;
    plot(t, H_2, ".-")

function y = Haara(t, k, m)
    y = 2^(k/2)*Haar(2^k*(t-((m-1)/2^k)));

end

function y = Haar(t)
    y = PI(t, 0.25, 0.5)-PI(t, 0.75, 0.5);
end

function y = PI(t, t0, T)
    y = zeros(1, length(t));
    y(t> t0-T/2 & t < t0+T/2) = 1;
    y(t== t-T/2 | t== t+T/2) = 0.5;


end