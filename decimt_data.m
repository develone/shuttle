% Function to decimate the 360485 samples to 90122 samples
% Uses highpass butterworth filter
function dmt_data=decimt_data(in)

nhp=8;                  % Order of Butter HPF = 8             %changed 04/2/04
R=4;
fs=100.16;
Whp=.5/(.5*fs);  
[B,A]=butter(nhp,Whp,'high');
nlp=64;

disp('size of data before decimation')
X=size(in)

in(:,1)=filter(B,A,in(:,1));
in(:,2)=filter(B,A,in(:,2));
in(:,3)=filter(B,A,in(:,3));
in(:,4)=filter(B,A,in(:,4));

% D(:,1) = decimate(in(:,1),R,nlp,'fir');
% D(:,2) = decimate(in(:,2),R,nlp,'fir');
% D(:,3) = decimate(in(:,3),R,nlp,'fir');
% D(:,4) = decimate(in(:,4),R,nlp,'fir');
D(:,1) = resample(in(:,1),1,4);
D(:,2) = resample(in(:,2),1,4);
D(:,3) = resample(in(:,3),1,4);
D(:,4) = resample(in(:,4),1,4);
dmt_data=D;
disp('size of data after decimation')
Y=size(dmt_data)





