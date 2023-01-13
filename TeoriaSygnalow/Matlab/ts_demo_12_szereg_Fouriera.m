% m-plik skryptowy: ts_demo_12_szereg_Fouriera.m
%
% Teoria sygnalow
% Elektronika
% AGH
%
% Aproksymacja szeregiem Fouriera (wersja zespolona) i konfrontacja wspolczynnikow szeregu z CFT;
%
% (C) P.Korohoda, kolejne wersje: 17/10/2015; 25/10/2018; 7/11/2019; 23/11/2022;

clc; clear; close all;

T=10;
dt=0.01; t=0:dt:T; Nt=length(t);

% najpierw tworzymy sygnal:
x=zeros(1,Nt);     K=3;          
wersja=1;
for k=1:K
    switch wersja
        case 1,    tn(k)=(k-0.5)*(T/K); Tn(k)=T/K;  a(k)=rand*2-1;
        case 2,    tn(k)=rand*8; Tn(k)=rand*2;  a(k)=rand*2-1;  % uwaga: gdyby slupki wyszly poza zakres założonego odcinka czasu, to trzeba skorygowac CFT;
    end
    
    x=x+a(k)*xPI(t,tn(k),Tn(k));
end
x([1,end])=(x(2)+x(end-1))/2; % po co jest ta operacja?

% UWAGA teraz:
max_n=10; % tu okreslamy "dlugosc" szeregu Fouriera;

    fT=1/T; fn=0:fT:max_n*fT; % czestotliwosci dla szeregu Fouriera;
    NT=length(fn);

% teraz wyznaczamy CFT (z teorii):
  
  f=-fn(end):0.001:fn(end); Nf=length(f);
  X=zeros(1,Nf);
  for k=1:K
      X=X+a(k)*Tn(k)*sinc(f*Tn(k)).*exp(-j*2*pi*f*tn(k));
  end
  
% a teraz szereg Fouriera (numerycznie wyznaczamy wartość całki):
 c=[]; nc=[];
  for n=1:NT
     cc=(1/T)*calka(x.*exp(-j*2*pi*fn(n)*t) , dt);
     if n==1 
        c=cc; nc=0; 
     else
        c=[conj(cc);c;cc];       nc=[-(n-1);nc;(n-1)];
     end
  end
  
  % korzystajac z wyliczonych wspolczynnikow szeregu wyznaczamy aproksymacje sygnalu:
  Nc=length(c);    x1=zeros(1,Nt);
  for n=1:Nc
      x1=x1+c(n)*exp(j*2*pi*nc(n)*fT*t);
  end
  test_im_dla_x1=max(abs(imag(x1))), % test wartości urojonej dla x1;
  x1=real(x1); % należy wcześniej sie upewnic, czy ta korekta jest uprawniona... testujac wartosci urojone x1;

% ... i ogladamy, co wyszlo:   
        figure(1);
            plot(t,x,'bo-'); grid on; hold on;
            plot(t,x1,'r.-'); 
                xlabel('t [s]');  title('sygnal pierwotny i opisany szeregiem Fouriera');
            
        figure(2);
              c=T*c; % dlaczego tak?
            subplot(2,2,1); plot(f,abs(X),'b.-');grid on; title('modul'); xlabel('f [Hz]'); hold on;
                            plot(fT*nc,abs(c),'ro');
            subplot(2,2,3); plot(f,angle(X)/pi,'b.-');grid on; title('faza/pi'); xlabel('f [Hz]');hold on;
                            plot(fT*nc,angle(c)/pi,'ro');
            subplot(2,2,2); plot(f,real(X),'b.-');grid on;  title('Re(X)'); xlabel('f [Hz]');hold on;
                            plot(fT*nc,real(c),'ro');
            subplot(2,2,4); plot(f,imag(X),'b.-');grid on;  title('Im(X)'); xlabel('f [Hz]');hold on;
                            plot(fT*nc,imag(c),'ro');
        
% KONIEC PLIKU;

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