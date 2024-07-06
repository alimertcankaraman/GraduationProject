clear all
clc
c=6320;
f=10E6;
fs=f*1000;
Ts=1/fs;
w=2*pi*f;
sigma=1;

%t=-10:(9.999995E-5):10;
%tr=-80E-6:Ts:80E-6;
%tr=-10E-6:Ts:10E-6;

t=-10:(1.25E-3):10;
tr=-80E-8:Ts:80E-8;

x=1:length(tr);

func=-0.5*(t/(sigma)).^2;
gauss=exp(func);
sincos = exp(j*w*tr);
%sincos2 = cos(w*tr)+j*sin(w*tr);

pulse(x)=gauss.*sincos;
%pulse2=gauspuls(tr,f,0.5);
realpulse=abs(pulse);

aa=zeros(1,length(pulse));
ppulse=[aa pulse aa];
tt=-80E-6:3.3331e-09:80E-6-3.3331e-09;
passedTime=tt(end)-tt(1);
lenOfTime=length(tt);

% figure(1)
% plot(tr,sincos)
% title('Euler function')
% 
% figure(2)
% plot(tr,gauss)
% title('Gauss Distribution')

figure(3)
plot(tt,ppulse)
title('Pulse')

% figure(4)
% plot(tr,realpulse)
% title('Real Pulse')

d=0.0008;  %distances between each pro 
Array=zeros();
N=[-15*d/2:d:-5*d/2 5*d/2:d:15*d/2];
theta=-30:1:30;
R=0:0.001:0.03;

for n=1:length(N) 
    for r=1:length(R)
        for teta=1:length(theta)
            Array(teta,r,n)=sqrt((((R(r)).*sin(theta(teta)*pi/180)-N(n)*d)^2)+((R(r)).*cos(theta(teta)*pi/180))^2)/6320;
            
            SampleArr(n,teta,r)=round((lenOfTime/passedTime).*(Array(n,teta,r)));
        end 
    end
end

for n=1:length(N)
   SampleArr(1,1,n); 
end
  for n=1:length(N)
    for i=1:length(ppulse)-SampleArr(15,1,n) 
        newpulse(n,i)=ppulse(i+SampleArr(15,1,n)); 
    end 
  end
  for n=1:length(N)
    rr(n)=zeros(1,SampleArr(15,1,n));
  end
  newpulse(n)=[newpulse(n) rr(n)];