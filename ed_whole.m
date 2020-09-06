pkg load signal
% Opening file
input_fd = fopen('shuttle.bin','r','l');
%input_fd = fopen('ss.bin','r','l');
% Extracting headers
[Header,count] = fread(input_fd,14,'uint');

% Reading data
[data,count] = fread(input_fd,[Header(9),inf],'uint');    

% Scaling data
data = (data - 2^23).*(Header(11)/10 ./ 2^23);
sf=[-12.8 -12.1 -12.5 -12.20];

%-------------------------------------------------------------------
O(1,:)=data(5,:);
O(2,:)=data(6,:);
O(3,:)=data(7,:);
O(4,:)=data(8,:);
O=O';

%decimating the data to 90122 samples
dmt_data=decimt_data(O);

y1 = dmt_data(1:90122,1);%new
y2 = dmt_data(1:90122,2);
y3 = dmt_data(1:90122,3);
y4 = dmt_data(1:90122,4);

% making the filter bank/transmultiplexer
my_transmultiplexer

%doing the synthesis part of the transmultiplexer
% t1=upsample(y1,5);
% t2=upsample(y2,5);
% t3=upsample(y3,5);
% t4=upsample(y4,5);
t1=upit(y1,5);
% y1(1:20)
% t1(1:20)
t2=upit(y2,5);
t3=upit(y3,5);
t4=upit(y4,5);
figure
%plot(y1);hold;plot(t1,'r');
%cmfb_5V2
%load fil

g=f;


t1=conv(g(1,:),t1);
t2=conv(g(2,:),t2);
t3=conv(g(3,:),t3);
t4=conv(g(4,:),t4);

%combining the 4 signals into 1
T=t1+t2+t3+t4;
figure
wavwrite(T,16000,16,'pre.wav');
plot(T)
% !lame --comp 15 -m m --resample 16 -k pre.wav pre.mp3
%!lame -b 32 -m m --resample 16 -k pre.wav pre.mp3
system("lame -b 32 -m m --resample 16 -k pre.wav pre.mp3")
system("lame --resample 16 -k --decode pre.mp3 pre_dec.wav")
%!lame --resample 16 -k --decode pre.mp3 pre_dec.wav
 [T1,FS,bits] = wavread('pre_dec.wav');
 hold
 plot(T1,'r')
 title('combined 4 ch at 24 Kbit')
 
S = sum(T.^2);
[a,b] = size(T);
N = sum((T-T1(1:a)).^2);
SNR = S/N;
10*log10(SNR)

%T1=T;
t1=conv(h(1,:),T1);
t1 = t1*5;
t2=conv(h(2,:),T1);
t2 = t2*5;
t3=conv(h(3,:),T1);
t3 = t3*5;
t4=conv(h(4,:),T1);
t4=t4*5;
% t1=downsample(t1,5);
% t2=downsample(t2,5);
% t3=downsample(t3,5);
% t4=downsample(t4,5);

t1=dnit(t1,5);
t2=dnit(t2,5);
t3=dnit(t3,5);
t4=dnit(t4,5);

S = sum(y1.^2);
[a,b] = size(y1);
N = sum((y1-t1(9:(a+8))).^2);
SNR = S/N;
10*log10(SNR)
figure
plot(y1) 
hold  
plot(t1(9:a+8),'r')
title('y1 & t1')


S = sum(y2.^2);
[a,b] = size(y2);
N = sum((y2-t2(9:a+8)).^2);
SNR = S/N;
10*log10(SNR)


S = sum(y3.^2);
[a,b] = size(y3);
N = sum((y3-t3(9:a+8)).^2);
SNR = S/N;
10*log10(SNR)


S = sum(y4.^2);
[a,b] = size(y4);
N = sum((y4-t4(9:a+8)).^2);
SNR = S/N;
10*log10(SNR)

dat = zeros(4,90122);
dat(1,1:90122)= t1(1:90122,1)';
dat(2,1:90122)= t2(1:90122,1)';
dat(3,1:90122)= t3(1:90122,1)';
dat(4,1:90122)= t4(1:90122,1)';
figure
coh3
colorbar
