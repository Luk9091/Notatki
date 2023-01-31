% m-plik skryptowy: demo_efektu_okienkowania.m
%
% Teoria sygnalow
% Elektronika
% AGH 
%
% Tu korzystam z funkcji specgram;
%
% (C) P.Korohoda, 12/01/2017; 17/12/2021;

clc; clear; close all;

fp=44100;   dt=1/fp;
f1=220;     f2=440;       f3=880;
T1=0.05;    T2=0.05;      T3=0.025;
t1=0:dt:T1; t2=dt:dt:T2;  t3=dt:dt:T3;

t=[t1,t2+T1,t3+T1+T2];
x1=cos(2*pi*f1*t1);
    x2=cos(2*pi*f2*t2);
        x3=cos(2*pi*f3*t3);
        
x=[x1,x2,x3];

f=0:0.5:fp/8;
td1=T1/2; td2=T1+T2/2; td3=T1+T2+T3/2;
X=0.5*T1*sinc((f+f1)*T1).*exp(-j*2*pi*(f+f1)*td1);
    X=X+0.5*T2*sinc((f+f2)*T2).*exp(-j*2*pi*(f+f2)*td2);
        X=X+0.5*T3*sinc((f+f3)*T3).*exp(-j*2*pi*(f+f3)*td3);
            X=X+0.5*T1*sinc((f-f1)*T1).*exp(-j*2*pi*(f-f1)*td1);
                X=X+0.5*T2*sinc((f-f2)*T2).*exp(-j*2*pi*(f-f2)*td2);
                    X=X+0.5*T3*sinc((f-f3)*T3).*exp(-j*2*pi*(f-f3)*td3);
                    
   tic;        
   K=2^10; dK=round(K/64);  w=hann(K);
   [B,fx,tx]=specgram(x,K,fp,w,K-dK);
   czas_obl_specgram=toc,        
        
    pokaz=1;    
    if pokaz    
    figure(1);
        [Nf,Nt]=size(B); T=(K-1)*dt;
        B=B*dt;
        tic;
        for n=1:Nt-1
            subplot(2,1,1); plot(t,x,'b-'); grid on; hold on;
                            plot(tx(n):dt:tx(n)+T,w,'r'); 
                                ylim([-1,1]);   xlim([t(1),t(end)]);   xlabel('t [s]');
            subplot(2,1,2); plot(fx,abs(B(:,n)),'b.-'); grid on;
                                ylim([0,6e-3]); xlim([f(1),f(end)]);   xlabel('f [Hz]');
            pause(0.05);
            if n<Nt-1, clf; end;
        end
        czas_tej_zabawy=toc,
    end

    figure(2);
        subplot(3,1,1);    plot(t,x,'b.-');      grid on;
                                xlim([t(1),t(end)]);   xlabel('t [s]');
        subplot(3,1,2);    plot(f,abs(X),'b.-'); grid on;
                                xlim([f(1),f(end)]);   xlabel('f [Hz]');
        subplot(3,1,3);    plot(f,angle(X)/pi,'b.-'); grid on;
                                xlim([f(1),f(end)]);   xlabel('f [Hz]');
                       
    figure(3); fmin=f(1); fmax=f(end); % te parametry mozna i warto zmieniac;
               specgram(x,K,fp,w,K-dK); colorbar;
               % ylim([fmin,fmax]);
    
    soundsc(x,fp);

% KONIEC PLIKU;