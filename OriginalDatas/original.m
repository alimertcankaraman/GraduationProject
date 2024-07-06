clear; clc;
%%
%Getting the datas
a1 = xlsread('A1.xlsx');
a2 = xlsread('A2.xlsx');
a3 = xlsread('A3.xlsx');
a4 = xlsread('A4.xlsx');
a5 = xlsread('A5.xlsx');
a6 = xlsread('A6.xlsx');
b3 = xlsread('B3.xlsx');
b4 = xlsread('B4.xlsx');
b5 = xlsread('B5.xlsx');
b6 = xlsread('B6.xlsx');
b7 = xlsread('B7.xlsx');
b8 = xlsread('B8.xlsx');
pulse = {a1(500:end,2),a2(500:end,2),a3(500:end,2),a4(500:end,2),a5(500:end,2),a6(500:end,2),b3(500:end,2),b4(500:end,2),b5(500:end,2),b6(500:end,2),b7(500:end,2),b8(500:end,2)};
reflectedPart = {a1(500:end-500,2),a2(500:end-500,2),a3(500:end-500,2),a4(500:end-500,2),a5(500:end-500,2),a6(500:end-500,2),b3(500:end-500,2),b4(500:end-500,2),b5(500:end-500,2),b6(500:end-500,2),b7(500:end-500,2),b8(500:end-500,2)};

for n=1:12
    pulses(n,:) = [reflectedPart{n}];
end

% aa=zeros(1,(length(reflectedPart{1})+1)/2);
% for n=1:12
%     pulsesAddedZeros(n,:) = [aa pulses(n,:) aa];
% end

time=a1(500:end,1); 
passedTime=time(end)-time(1);
lenOfTime=length(time); 
%%
%Finding the time delays with respect to the distances of all points
d=0.0008;   %distances between each pro 
c=6320;     %speed of sound in aluminum
Array=zeros();      %Array has the time delays according to the distance values to the sensors of all possible points within the area
SampleArr=zeros();  %This array is for determining how many samples the signal should be shifted
N=[-15*d/2:2*d:-5*d/2 5*d/2:2*d:15*d/2];
theta=-30:5:30;
R=0:0.003:0.03;

for r=1:length(R)
    for teta=1:length(theta)
        for n=1:length(N)             
            Array(r,teta,n)=sqrt((((R(r)).*sin(theta(teta)*pi/180)-N(n))^2)+((R(r)).*cos(theta(teta)*pi/180))^2);    
        end
    end
end
Array=Array/6320;
SampleArr=round((lenOfTime/passedTime).*(Array));
%%
%Pulse? uzakl??a ba?l? olarak zamanda geri kaydirip nerden geldi?ini bulma
lastPulse=zeros();


 for r=1:length(R)
     for teta=1:length(theta)
         for n=1:length(N)
            for i=1:length(pulses)-SampleArr(r,teta,n)
                lastPulse(n,i,r,teta)=pulses(n,i+SampleArr(r,teta,n));
            end
        end
    end
end 



