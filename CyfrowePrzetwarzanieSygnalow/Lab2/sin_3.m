function [y, x, sa] = sin_3(k, f0, fs, phi_sa)

    dt = 1/(100*f0);
    t = 0:dt:2*(k+2)/f0;

   y = sin(2*pi*f0*t) .* PI(t, 2*k/f0, (k+2)/f0);
    
    x = [];
    for i = 1:length(t)
        if t(i) >= length(x)*1/fs-1/fs*phi_sa
            x = [x, y(i)];
        end
    end
    
    sa = zeros(1, length(t));
    for i = 1:length(x)
        sa = sa + x(i) * sinc((t-(i-1)/fs)*fs);
    end
end