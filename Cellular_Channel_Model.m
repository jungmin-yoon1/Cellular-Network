% made by Jungmin Yoon
%%%%%%%%%%%%%%%%%%% 21.05.27 : Cellular_Channel Model %%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
close all;

% pdf 생성
x=-100:0.01:100;
Mean=0;
Devi=3.71;
pdf=(1/(sqrt(2*pi)*Devi))*exp(-((x-Mean).^2)/(2*Devi^2));

% cdf 생성
p=cumsum(pdf);    
cdf=p/p(length(p));  

% pdf_Rayleigh -multipath
sigma=4;
pdf_Rayleigh=(x./sigma^2).*exp(-((x).^2)/(2*sigma^2));

% cdf_Rayleigh
cdf_Rayleigh=1-exp(-x.^2/(2*sigma^2));

% r_median
syms t
sol=solve(1-exp(-t^2/(2*sigma^2))==1/2,t);
r_median=sol(sol>0);

%distance
d=1:1:1001;

% PathLoss- Goldsmith CH2 2.5 Simplified Path Loss Model
Gamma=3.71; % Path Loss Exponent
f=900*10^6; 
c=3*10^8; 
Lamda=c/f;
d0=1;
K=-20*log((4*pi*d0)/Lamda);
PathLoss=K-10*Gamma*log(d/d0);

% Shadowing-Goldsmith CH2 2.7 Shadow Fading
Shadowing=zeros(1,length(d));
for i=1:length(d)
    r=rand(1,1);
    k=find(cdf<r);    %cdf<r 을 만족하는 것의 index 찾기
    z=x(max(k+1));   %최댓값 반환
    Shadowing(i)=PathLoss(i)-z;
end


% MultiPath(Rayleigh)
MultiPath=zeros(1,length(d));
for i=1:length(d)
    r=rand(1,1); 
    k=find(cdf_Rayleigh<r); 
    z=x(max(k+1));
    MultiPath(i)=Shadowing(i)-(z-r_median);
end

hold on;
subplot(2,2,1)  %PathLoss 영향 만 출력  
plot(d,PathLoss,'r')
grid on;
ylabel('Pt/Pr(dB)')
legend('PathLoss');
xlim([0 1000]);

subplot(2,2,2) %Shadowing 영향 만 출력
plot(d,Shadowing,'b')
grid on;
ylabel('Pt/Pr(dB)')
legend('Shadowing');
legend('Shadowing');
xlim([0 1000]);

subplot(2,2,3)  %Multipath 영향 만 출력
plot(d,MultiPath,'g')
grid on;
ylabel('Pt/Pr(dB)')
legend('MultiPath')
xlim([0 1000]);

subplot(2,2,4)
plot(d,PathLoss,'r') %PathLoss, Shadowing, Multipath 모두 출력
hold on;
plot(d,Shadowing,'b')
hold on;
plot(d,MultiPath,'g')
legend('PathLoss','Shadowing', 'MultiPath')
grid on;
xlim([0 1000]);

xlabel('Distance')
ylabel('Pt/Pr(dB)')


