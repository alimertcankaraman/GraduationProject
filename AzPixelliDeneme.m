close all
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

aa=zeros(1,(length(pulse)+1)/2);% /2 vard? burada
pulseAddedZeros=[aa pulse aa];
tReal=-80E-6:4.9995e-09:80E-6-4.9995e-09;
passedTime=tReal(end)-tReal(1);
lenOfTime=length(tReal);

%%
%Uzakl?k de?erlerini bulma her bir nokta i�in
d=0.0008;  %distances between each pro 
Array=zeros();
SampleArr=zeros();
N=[-15*d/2:d:-5*d/2 5*d/2:d:15*d/2];
theta=-30:3:30;
R=0:0.003:0.03;

for r=1:length(R)
    for teta=1:length(theta)
        for n=1:length(N)             
            Array(r,teta,n)=sqrt((((R(r)).*sin(theta(teta)*pi/180)-N(n))^2)+((R(r)).*cos(theta(teta)*pi/180))^2);    
        end
    end
end
Array=Array/6320;
SampleArr=round((lenOfTime/passedTime*10).*(Array)); %*10 idi bura

%%
%Shifting the pulse in time domain with respect to the distances of the
%points
delayedPulses=zeros();
for n=1:length(N)
    for r=1:length(R)
        for teta=1:length(theta)
            for i=SampleArr(r,teta,n)+1:length(pulseAddedZeros)
                delayedPulses(n,i,r,teta)=pulseAddedZeros(i-SampleArr(r,teta,n));
            end
        end
    end  
end   
tReal2=-80E-6:4.9995e-09:80E-6-4.9995e-09;

%%
lastPulse=zeros();
for n=1:length(N)
    thePulse(n,:) = delayedPulses(n,:,6,11);
end    

for n=1:length(N)
    for r=1:length(R)
        for teta=1:length(theta)
            for i=1:length(delayedPulses)-SampleArr(r,teta,n)
                lastPulse(n,i,r,teta)=thePulse(n,i+SampleArr(r,teta,n));
            end
        end
    end
end 

zz=zeros(1,32003-length(lastPulse));

for n=1:length(N)
    for r=1:length(R)
        for teta=1:length(theta)
            lastPulseAddedZeros(n,:,r,teta) = [lastPulse(n,:,r,teta) zz];
        end
    end
end
pixel_real=zeros(length(R),length(theta));
pixel_imag=zeros(length(R),length(theta));
delayed_real=real(lastPulseAddedZeros);
delayed_imag=imag(lastPulseAddedZeros);

for r=1:length(R)
    for teta=1:length(theta)    
        for n=1:length(N)
            pixel_real(r,teta)=pixel_real(r,teta)+abs(delayed_real(n,16002,r,teta));
            pixel_imag(r,teta)=pixel_imag(r,teta)+abs(delayed_imag(n,16002,r,teta));
        end
    end
end
figure(1)
mesh(pixel_real)
xlabel('Theta')
ylabel('R')
figure(2)
mesh(pixel_imag)
xlabel('Theta')
ylabel('R')
