clear all
clc
c=6320;
f=10E6;
fs=f*1000;
Ts=1/fs;
w=2*pi*f;
sigma=1;
%%
%�nce pulse olu?turma
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
%Pulse?n ba? ve sonuna s?f?r ekleyip kayd?rma i?lemi i�in haz?rlama
aa=zeros(1,length(pulse));
pulseAddedZeros=[aa pulse aa];
tReal=-80E-6:3.333125013020020e-09:80E-6-3.333125013020020e-09;
passedTime=tReal(end)-tReal(1);
lenOfTime=length(tReal);

figure(2)
plot(tReal,pulseAddedZeros)
title('PulseAddedZeros')
%%
%Uzakl?k de?erlerini bulma her bir nokta i�in
d=0.0008;  %distances between each pro 
Array=zeros();
SampleArr=zeros();
N=[-15*d/2:d:-5*d/2 5*d/2:d:15*d/2];
theta=-30:2:30;
R=0:0.001:0.03;

for r=1:length(R)
    for teta=1:length(theta)
        for n=1:length(N) 
            Array(n,teta,r)=sqrt((((R(r)).*sin(theta(teta)*pi/180)-N(n)*d)^2)+((R(r)).*cos(theta(teta)*pi/180))^2)/6320;
        end
    end
end
SampleArr=round((lenOfTime/passedTime*10).*(Array));
%%
%Pulse? uzakl??a ba?l? olarak zamanda kayd?rma
for n=1:length(N)
    for r=1:length(R)-28
        for i=1:length(pulseAddedZeros)-SampleArr(n,31,r) 
        delayedPulse(n,r,i)=pulseAddedZeros(i+SampleArr(n,31,r)); 
        end
    end  
end   
 rr=zeros(1,SampleArr(12,31,11));
 finalPulse=zeros(12,48003);
 for n=1:length(N)
    finalPulse(n,:) =[delayedPulse(n,:) rr];
 end
%  for n=1:length(N)
%      figure
%     plot(tReal,finalPulse(n,:))
%  end

% for n=1:length(N)
%     for r=1:length(R)-28
%         for i=1:length(pulseAddedZeros)-SampleArr(n,31,r)
%         figure
%         scatter3(R(r),N(n),delayedPulse(n,r,i))
%         end
%     end
% end
