clc
close all
clear all
SNR=0:1:20;                 %����ȱ仯��Χ
SNR1=0.5*(10.^(SNR/10));    %�������ת����ֱ������
N=1000000;                  %�������
X=4;                        %������
x=randi([0,1],1,N);         %��������ź�
R=raylrnd(0.5,1,N);         %���������ź�
h=pskmod(x,X);              %����matlab�Դ���psk���ƺ���
hR=h.*R;
for i=1:length(SNR)
    yAn=awgn(h,SNR(i),'measured'); 
    yA=pskdemod(yAn,X);     %QPSK����4PSK
    [bit_A,l]=biterr(x,yA); 
    QPSK_s_AWGN(i)=bit_A/N;
    
    yRn=awgn(hR,SNR(i),'measured');
    yR=pskdemod(yRn,X);     %����matlab�Դ���psk�������
    [bit_R,ll]=biterr(x,yR);
    QPSK_s_Ray(i)=bit_R/N; 
end
QPSK_t_AWGN=1/2*erfc(sqrt(10.^(SNR/10)/2));   %AWGN�ŵ���QPSK����������
QPSK_t_Ray= -(1/4)*(1-sqrt(SNR1./(SNR1+1))).^2+(1-sqrt(SNR1./(SNR1+1)));
%Rayleigh�ŵ���QPSK����������

%����ͼ��
figure
semilogy(SNR,QPSK_s_AWGN,'r*');hold on;
semilogy(SNR,QPSK_t_AWGN,'yo');hold on;
semilogy(SNR,QPSK_s_Ray,':b*');hold on
semilogy(SNR,QPSK_t_Ray,':go'); grid on;
axis([-1 20 10^-4 1]);
legend('AWGN����','AWGN����','��������','��������');
title('QPSK�������ܷ���');
xlabel('����ȣ�dB��');ylabel('BER');
