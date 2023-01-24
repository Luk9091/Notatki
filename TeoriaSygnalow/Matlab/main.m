clc; clear; close all;

dt = 0.001;
t = -5:dt:5;

x = xPI(t, 2, 0);
uu= CTF(x, t);

figure(1);
    plot(t, x);
figure(2)
    plot(f, X);



function y = lambda(t, T, t0)
    y = -1/T*abs(t-t0)+1;
    y(y <= 0) = 0;
end

function y = sinc(t, T, t0)
    a = PI(t, T, t0);
    y = a.*sin(t-t0)./(t-t0);
    y(t-t0== 0) = 1;
end


function y = PI(t, T, t0)
    y = zeros(1, length(t));
    y(t >= t0-T/2 & t <= t0+T/2) = 1;
end

function y = u(t, t0)
    y = t-t0;
    y(y > 0) = 1;
    y(y <= 0) = 0;
end

function y = xPI(t, T, t0)
    y = zeros(1, length(t));
    dt= t(2)-t(1);
    t1= t0-T/2;
    t2= t0+T/2;
    
    y(t > t1 & t < t2) = 1;
    
    y((t>(t1-dt/2))&(t<(t1+dt/2)))=1/2;    
    y((t>(t2-dt/2))&(t<(t2+dt/2)))=1/2;
end


function c=calka(y,dx)
    c=(sum(y)-(y(1)+y(end))/2)*dx;
end

function [X, f]=CFT(x, t)
    X=fft(x);
	X=fftshift(X);
	
	N=length(x); dt=t(2)-t(1); fp=1/dt; df=fp/N;
	
	f=0:df:(N-1)*df;
	f=f-fp/2; 
	X=X/fp;
	
	X=X.*exp(-j*2*pi*f*t(1));
end