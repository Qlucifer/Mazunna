clc; clear all; close all;
T= 0.01;
t_min=0;                    % 0 perchè il segnale è causale
T_max=6;                    
t=t_min:T:T_max;            % Vettore dei tempi
d1= 1/10;                   % Per campionamento 1/100 = 10KHz ??
t1=t_min:d1:T_max;          % tempo campionato
y= t.^5 .*exp(-3*t) .*cos((pi/5)-2*pi*(1/3)*t) .*heaviside(t); % Segnale
max = max(abs(y));          % Restituisce il valore massimo
trunc_value= max/100 * 3;   % Valore di troncamento
j=1;                        % Indice utile per campionamento
for k=1:length(y)      % Troncare il segnale sotto il 3% del valore massimo
    if (abs(y(k)) < trunc_value) 
           y(k)=0;
    end
    if(rem(k,d1*100) == 1 || k==1) % Prendo un valore su X
        y1(j) = y(k);              % Inserisco il calore in un vettore
        j=j+1;                     % Incremento la posizione nel vettore
    end
end
Y1= fft(y1);        % DFT del segnale campionato
j= length(y1);      % Lunghezza del vettore contente i campioni
t2=0:1:j-1;         % Numero di campioni (k)
t2 = t2 *d1;        % Da rivedere perchè deve essere F in modo da fare kF


subplot(211);
plot(t,y); 
hold on;
stem(t1,y1);        % Plotto segnale campionato sopra quello continuo
grid on;
xlabel('t');
ylabel('s(t)');
title('Campionamento segnale');
subplot(212); 
stem(t2,abs(Y1));   % Plotto la DFT, vettore kF in ascissa
grid on;
xlabel('kF');
ylabel('S(kF)');
title('DFT del segnale campionato');