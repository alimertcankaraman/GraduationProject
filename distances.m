close all
clear
clc

d=0.0008;  %distances between each pro 
Array1=zeros();
N=[-15*d/2:d:-5*d/2 5*d/2:d:15*d/2];
theta=0;
R=(0:3)/1000000;

for r=1:length(R)   
        for n=1:length(N) 
            Array1(n,r)=sqrt((((R(r)).*sin(theta*pi/180)-N(n)*d)^2)+((R(r)).*cos(theta*pi/180))^2)/6320;
        end 
end
figure
plot(N,Array1())
grid on
xlabel('N')
ylabel('Distance')

%%
Array2=zeros();
theta2=-30:1:30;
R2=5/1000000;

for teta=1:length(theta2)   
        for n=1:length(N) 
            Array2(n,teta)=sqrt((((R2).*sin(theta2(teta)*pi/180)-N(n)*d)^2)+((R2).*cos(theta2(teta)*pi/180))^2)/6320;
        end 
end
figure
plot(theta2,Array2)
grid on
xlabel('Angle')
ylabel('Distance')
