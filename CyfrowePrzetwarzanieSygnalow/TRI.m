function y = TRI(t, T, t0)
    y = -abs(t - t0)+T/2;
    for i = 1:length(y)
        if(y(i) <= 0)
            y(i) = 0;
        end
    end
    y = y./max(y);
end
