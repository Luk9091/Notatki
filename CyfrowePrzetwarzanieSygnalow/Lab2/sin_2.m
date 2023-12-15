function [y, x, sa, RMSE] = sin_2(k, f0, fs)

    dt = 1/(100*f0);
    t = 0:dt:2*(k+2)/f0;

   y = sin(2*pi*f0*t) .* PI(t, 2*k/f0, (k+2)/f0);
    
    x = [];
    for i = 1:length(t)
        if t(i) >= length(x)*1/fs
            x = [x, y(i)];
        end
    end
    
    sa = zeros(1, length(t));
    for i = 1:length(x)
        sa = sa + x(i) * sinc((t-(i-1)/fs)*fs);
    end

    suma = 0;
    for i = 1:length(t)
        suma = suma + (y(i)-sa(i))^2;
    end
    RMSE = sqrt(1/length(t) * suma);
end