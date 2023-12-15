clc; clear; close all;

fs = 10000;
t0 = 0;
N = 15;

f0 = fs/2*0;
k = 8*N/10;



dt = 0.001/(f0+0.01);
t = -0.75*k/(f0+0.01):dt:0.75*k/(f0+0.01);
s = ones(1, length(t)) .* 0.25;
s = s - sin(2*pi*f0*t);

[x, n] = sampling(s, fs, t, t0, N);

w = PI(t, n(end) + n(1), t0+((n(end) - n(1)))/2);


[X, f] = DFT(x, fs);
Xr = fft(x);
fr = 0:fs/length(Xr):fs-1;


xi = IDFT(X);
xr = ifft(X);

si = odwarzanie(t, xi, fs);


disp("T sygnału: ");
disp(k/f0);
disp("T próbkowania")
disp((n(end) - n(1)) + n(2)-n(1));

figure(Name="Signal")
    hold on; grid on;
    plot(t, s.*w);
    stem(n, x);
    xlabel('t');

figure(Name = "DFT")
    subplot(4, 1, 1);
        hold on; grid on;
        stem(f, abs(X));
        stem(fr, abs(Xr));
        ylabel("abs[X]")
        xlabel("f")
        legend("Xi", "Xr")
    subplot(4, 1, 2);
        hold on; grid on;
        stem(f, abs(X) - abs(Xr));
        ylabel("abs[X-Xr]")
        xlabel("f")
    subplot(4, 1, 3);
        hold on; grid on;
        stem(f, angle(X)/pi);
        stem(fr, angle(Xr)/pi);
        ylabel("phi[X][pi]")
        xlabel("f")
    subplot(4, 1, 4);
        hold on; grid on;
        stem(f, (angle(X) - angle(Xr))/pi)
        ylabel("phi[X-Xr][pi]")
        xlabel("f")    

figure(Name = "IDFT")
    subplot(4, 1, 1);
        hold on; grid on;
        stem(n, abs(xi));
        stem(n, abs(xr));
%        stem(n, abs(x));
        legend("xi", "xr");
        ylabel("abs[x]");
        xlabel("t");
    subplot(4, 1, 2);
        hold on; grid on;
        stem(n, abs(xi) - abs(xr));
        ylabel("abs[xi - xr]");
        xlabel("t");
    subplot(4, 1, 3);
        hold on; grid on;
        stem(n, angle(xi) / pi);
        stem(n, angle(xr) / pi);
        ylabel("phi[x][pi]");
        xlabel("t");
    subplot(4, 1, 4);
        hold on; grid on;
        stem(n, (angle(xi) - angle(xr))/pi);
        ylabel("phi[xi - xr][pi]");
        xlabel("t");

figure("Name", "Odtwarzanie")
    hold on; grid on;
    plot(t, s, "b");
    plot(t, real(si), 'r');
    stem(n, real(x), "b");
    stem(n, real(xi), 'r');
    
    legend("s", "si");
    xlabel('t');
    ylabel("s");

function [x, n] = sampling(s, fs, t, t0, N)
    x = [];
    n = [];

    k = 0;
    for i = 1:length(t)
        if(t(i) >= k/fs+t0)
            x = [x, s(i)];
            n = [n, t(i)];

            k = k + 1;
            if(N == k)
                break;
            end
        end
    end
end


function [X, f] = DFT(x, fs)
    N = length(x);
    X = zeros(1, N);
    f = zeros(1, N);

    for k = 0:N-1
        X0 = 0;
        for n = 0:N-1
            X0 = X0 + (x(n+1) * exp(-2j*pi*n*k/N));
        end
        X(k+1) = X0;
        f(k+1) = fs*k/N;
    end
    

end

function x = IDFT(X)
    K = length(X);
    x = zeros(1, K);

    for n = 0:K-1
        x0 = 0;
        for k = 0:K-1
            x0 = x0 + (X(k+1) * exp(2j*pi*n*k/(K)));
        end

 %       if(abs(x0) < 1e-10)
 %           x0 = 0;
 %       end
        x(n+1) = x0;
    end
    x = x./K;
end


function s = odwarzanie(t, x, fs)
    s = zeros(1, length(t));

    for i = 1:length(x)
        s = s + x(i) * sinc((t-(i-1)/fs)*fs);
    end
end