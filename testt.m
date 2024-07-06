close all
clear
clc

d=0.008;  %distances between each pro 
Array=zeros();
N=[-15*d/2:d:-5*d/2 5*d/2:d:15*d/2];
theta=-30:1:30;
R=0:0.001:0.03;

for r=1:length(R)
    for teta=1:length(theta)
        for n=1:length(N) 
            Array(n,teta,r)=sqrt((((R(r)).*sin(theta(teta)*pi/180)-N(n)*d)^2)+((R(r)).*cos(theta(teta)*pi/180))^2)/6320;
            SampleArr(n,teta,r)=round((160000/160e-6).*(Array(n,teta,r)));
        end
    end
end

c=6320;
f=10E6;
fs=f*100;
Ts=1/fs;
w=2*pi*f;
sigma=1;

t=-10:(1.25E-3):10;
tr=-80E-7:Ts:80E-7;
x=1:length(tr);

func=-0.5*(t/(sigma)).^2;
gauss=exp(func);
sincos = exp(j*w*tr);
sincos2 = cos(w*tr)+j*sin(w*tr);

pulse(x)=gauss.*sincos;
pulse2=gauspuls(tr,f,1);
realpulse=abs(pulse);

figure(3)
plot(tr,pulse)
title('Pulse')
for teta=1:length(theta) 
    for x=1:length(pulse) 
        newpulse(teta,x)=pulse(16000-SampleArr(1,teta,20)); 
        
    end      
end