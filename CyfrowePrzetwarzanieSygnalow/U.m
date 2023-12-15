function y = U(t, t0)
    y = zeros(1, length(t));
    for i = 1:length(t)
        if(t(i) >= t0)
            y(i) = 1;
        end
    end
end