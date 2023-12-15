function [y, x] = sin_1(k, f0, fs)
    dt = 1/(100*f0);
    t = 0:dt:2*(k+2)/f0;

    w = PI(t, 2*k/f0, (k+2)/f0);
    y = sin(2*pi*f0*t) .* w;
    
    x = [];
    for i = 1:length(t)
        if t(i) >= length(x)*1/fs 
                x = [x, y(i)];
        end
    end

end