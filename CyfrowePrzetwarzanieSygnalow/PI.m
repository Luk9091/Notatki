function y = PI(t, T, t0)
    y = zeros(1, length(t));
    for i = 1:length(t)
        if(t(i) >= t0-T/2 && t(i) < t0+T/2)
            y(i) = 1;
        end
    end
end
