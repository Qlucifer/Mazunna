clc; clear all; close all;

T= 0.01;
t=-6:T:6; %Vettore dei tempi
d1= 1/4; %Per campionamento 10KHz
t1=-6:d1:6; %tempo campionato
y= t.^5 .*exp(-3*t) .*cos((pi/5)-2*pi*(1/3)*t) .*heaviside(t);
max = max(abs(y)); %restituisce il valore massimo
trunc_value= max/100 * 3;% Valore di troncamento
j=1; %Indice utile per campionamento
%y1=zeros(size(t1)); %Miglioramento prestazioni 
for i=1:length(y) % Troncare il segnale sotto il 3% del valore massimo
    if (abs(y(i)) < trunc_value) 
           y(i)=0;
    end
    if(rem(i,25) == 1 || i==1) %Prendo un valore su 10
        y1(j) = y(i);
        j=j+1;
    end
end
Y1= fft(y1); %DFT del segnale campionato
subplot(211);
plot(t,y); 
hold on;
stem(t1,y1); %Plotto segnale campionato sopra quello continuo
grid on;
xlabel('t');
ylabel('s(t)');
title('Primo Grafico');
subplot(212); %Plotto la DFT
plot(abs(Y1)); % vanno messe le f in ordinata non so come fare 
grid on;
xlabel('f');
ylabel('S(f)');