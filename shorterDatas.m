clear all
clc
c=6320;
f=10E6;
fs=f*1000;
Ts=1/fs;
w=2*pi*f;
sigma=1;
%%
%Önce pulse olu?turma
tForGauss=-10:(1.25E-3):10;
tForEuler=-80E-8:Ts:80E-8;
x=1:length(tForEuler);

func=-0.5*(tForGauss/(sigma)).^2;
gauss=exp(func);
sincos = exp(j*w*tForEuler);
pulse(x)=gauss.*sincos;

% figure(1)
% plot(tForEuler,pulse)
% title('Pulse')
%%
%Pulse?n ba? ve sonuna s?f?r ekleyip kayd?rma i?lemi için haz?rlama
aa=zeros(1,(length(pulse)+1)/2);
pulseAddedZeros=[aa pulse aa];
tReal=-80E-6:4.9995e-09:80E-6-4.9995e-09;
passedTime=tReal(end)-tReal(1);
lenOfTime=length(tReal);

figure(2)
plot(tReal,pulseAddedZeros)
title('PulseAddedZeros')
%%
%Uzakl?k de?erlerini bulma her bir nokta için
d=0.0008;  %distances between each pro 
Array=zeros();
SampleArr=zeros();
N=[-15*d/2:d:-5*d/2 5*d/2:d:15*d/2];
theta=-30:5:30;
R=0:0.01:0.03;

for r=1:length(R)
    for teta=1:length(theta)
        for n=1:length(N) 
            
            Array(r,teta,n)=sqrt((((R(r)).*sin(theta(teta)*pi/180)-N(n))^2)+((R(r)).*cos(theta(teta)*pi/180))^2);    
        end
    end
end
Array=Array/6320;
SampleArr=round((lenOfTime/passedTime*10).*(Array));

%%
%Pulse? uzakl??a ba?l? olarak zamanda kayd?rma
delayedPulse=zeros();
for n=1:length(N)
    for r=1:length(R)
        for teta=1:length(theta)
            for i=SampleArr(r,teta,n)+1:length(pulseAddedZeros)
                delayedPulse(n,i,r,teta)=pulseAddedZeros(i-SampleArr(r,teta,n));
            end
        end
    end  
end   
tReal2=-80E-6:4.9995e-09:80E-6-4.9995e-09;

%  for n=1:length(N)
%      for r=1:length(R)
%          for teta=1:length(theta)
%             figure
%              plot(tReal2,delayedPulse(n,:,r,teta))
%          end
%      end
%  end
%%
lastPulse=zeros();

for n=1:length(N)
    for i=1:length(delayedPulse)-SampleArr(4,8,n)
        lastPulse(n,i,1,1)=delayedPulse(n,i+SampleArr(4,8,n),4,8);
    end
end 
zz=zeros(1,32003-length(lastPulse));
for n=1:length(N)
    lastPulseAddedZeros(n,:,1,1) = [lastPulse(n,:,1,1) zz];
end

%tReal3=-80E-6:5.5482e-09:80E-6-5.5482e-09;
for n=1:length(N)
    figure
    plot(tReal2,lastPulseAddedZeros(n,:,1,1))
end
