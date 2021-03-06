clear 
close all
pkg load signal
% Opening file
input_fd = fopen('shuttle.bin','r','l');

% Extracting headers
[Header,count] = fread(input_fd,14,'uint');
%     3080	1
%   100160	2
%       2	3
%       8	4
%       1	5
%       0	6
%       0	7
%       0	8
%       8	9	Header(9)
%       0	10
%      25	11
%       1	12
%       0	13
%       0	14

% Reading data
[data,count] = fread(input_fd,[Header(9),inf],'uint');    
%count =  2883880
% Scaling data
data = (data - 2^23).*(Header(11)/10 ./ 2^23);
sf=[-12.8 -12.1 -12.5 -12.20];

O=zeros(4,360485);
O(1,:)=data(5,:);
O(2,:)=data(6,:);
O(3,:)=data(7,:);
O(4,:)=data(8,:);
O=O';
Fs=100.16;
L = 360485;
T = 1/Fs;
t = (0:L-1)*T;
 
%figure
%subplot(4,1,1)
%S1 = O(:,1);
%plot(t,S1)

%figure
%subplot(4,1,2)
%S2 = O(:,2);
%plot(t,S2)

%figure
%subplot(4,1,3)
%S3 = O(:,3);
%plot(t,S3)

%figure
%subplot(4,1,4)
%S4 = O(:,4);

%plot(t,S4)
%x_ac = real(ifft(S4));

%figure
%plot(t,x_ac)

%Ys = fft(x_ac);

%P2 = abs(Ys/L);
%P1 = P2(1:L/2+1);
%P1(2:end-1) = 2*P1(2:end-1);

%figure 
%f = Fs*(0:(L/2))/L;
%plot(f,P1) 
%title('Single-Sided Amplitude Spectrum of X(t)')
%xlabel('f (Hz)')
%ylabel('|P1(f)|') 
%decimating the data to 90122 samples
dmt_data=decimt_data(O);

y1 = dmt_data(1:90122,1);%new
y2 = dmt_data(1:90122,2);
y3 = dmt_data(1:90122,3);
y4 = dmt_data(1:90122,4);

Fs=25.04;
L = 90122;
T = 1/Fs;
t = (0:L-1)*T;
%figure
%subplot(4,1,1)
%plot(t,y1)

%subplot(4,1,2)
%plot(t,y2)

%subplot(4,1,3)
%plot(t,y3)

%subplot(4,1,4)
%plot(t,y4)

%decimating the data to 90122 samples
dmt_data=decimt_data(O);

y1 = dmt_data(1:90122,1);%new
y2 = dmt_data(1:90122,2);
y3 = dmt_data(1:90122,3);
y4 = dmt_data(1:90122,4);

% making the filter bank/transmultiplexer
my_transmultiplexer

%doing the synthesis part of the transmultiplexer
t1=upsample(y1,4);
t2=upsample(y2,4);
t3=upsample(y3,4);
t4=upsample(y4,4);

t1=filter(g(1,:),1,t1);
t2=filter(g(2,:),1,t2);
t3=filter(g(3,:),1,t3);
t4=filter(g(4,:),1,t4);
