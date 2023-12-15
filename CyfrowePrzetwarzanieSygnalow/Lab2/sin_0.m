function y = sin_0(k, f0)
    dt = 1/(100*f0);
    t = 0:dt:2*(k+2)/f0;


    y = sin(2*pi*f0*t) .* PI(t, 2*k/f0, (k+2)/f0);

end