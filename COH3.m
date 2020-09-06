% close all
nfft = 512;

fs=100.16;
nlp=64;
nhp=8;
R=4;
fs=fs/R;
whp=.5/(.5*fs);

[b,a]=butter(nhp,whp,'high');

%for m=1:4
%fdat(m,:)=decimate(dat(m,:),R,nlp,'fir');

%end 
fdat = dat;
[y,z]=size(fdat(1,:));
x= round(z/256-1);
C=zeros((nfft/2+1),x);

% for m=1:4
% fdat(m,:)=filter(b,a,fdat(m,:));
% end

l=1;

lenrd=512;

for j=1:x
    K=0;
   for i=1:4
       for m=i:4
         coh=cohere(fdat(i,l:l+lenrd),fdat(m,l:l+lenrd),nfft,fs,hanning(0.75*nfft),256,'mean');
         if(m~=i)        
            C(:,j)=C(:,j)+coh;
            K=K+1; 
         end     
      end
   end
  l=l+256;
  
  C(:,j)=C(:,j)/K;
end
figure
imagesc(C,[.5 1])
colormap('hot')
axis xy