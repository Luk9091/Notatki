function y = find_fsa(f0, fs)

k = 1;
while 1
    y = f0 - k*fs;
    k = k +1;
    if y < fs/2
        break;
    end
end
disp("f_sa = ");
disp(y);