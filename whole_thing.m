clear 
close all
pkg load signal
% Opening file
input_fd = fopen('shuttle.bin','r','l');

% Extracting headers
[Header,count] = fread(input_fd,14,'uint');

% Reading data
[data,count] = fread(input_fd,[Header(9),inf],'uint');    

% Scaling data
data = (data - 2^23).*(Header(11)/10 ./ 2^23);
sf=[-12.8 -12.1 -12.5 -12.20];

%-------------------------------------------------------------------
O=zeros(4,360485);
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
t1=upsample(y1,4);
t2=upsample(y2,4);
t3=upsample(y3,4);
t4=upsample(y4,4);

t1=filter(g(1,:),1,t1);
t2=filter(g(2,:),1,t2);
t3=filter(g(3,:),1,t3);
t4=filter(g(4,:),1,t4);

%combining the 4 signals into 1
T=t1+t2+t3+t4;

%--------------------------------------------------------------------------
wavwrite(T,'pre.wav');

%COMPRESS/DECOMPRESS operations

T1 = wavread('pre.wav');
%--------------------------------------------------------------------------

%doing the analysis part of the transmultiplexer
t1=filter(h(1,:),1,T1);
t2=filter(h(2,:),1,T1);
t3=filter(h(3,:),1,T1);
t4=filter(h(4,:),1,T1);

t1=downsample(t1,4);
t2=downsample(t2,4);
t3=downsample(t3,4);
t4=downsample(t4,4);

%Alligning the signals

A1=allign(y1(1:18000),(-3.5619)*t1(1:18000));
B1=allign(y1,(-3.5619)*t1(1:90122));

A2=allign(y2(1:18000),(-3.5619)*t2(1:18000));
B2=allign(y2,(-3.5619)*t2(1:90122));

A3=allign(y3(1:18000),(-3.5619)*t3(1:18000));
B3=allign(y3,(-3.5619)*t3(1:90122));

A4=allign(y4(1:18000),(-3.5619)*t4(1:18000));
B4=allign(y4,(-3.5619)*t4(1:90122));


P1=zeros(1,90122);
P1(1:18000)=A1;
P1(18001:90122)=B1(18001:90122);

P2=zeros(1,90122);
P2(1:18000)=A2;
P2(18001:90122)=B2(18001:90122);

P3=zeros(1,90122);
P3(1:18000)=A3;
P3(18001:90122)=B3(18001:90122);

%P4=zeros(1,90122);
%P4(1:18000)=A4;
%P4(18001:90122)=B4(18001:90122);

S1=sum(y1.^2);
E1=y1-P1';
N1=sum(E1.^2);
SNR1=S1/N1
10*log10(SNR1)

