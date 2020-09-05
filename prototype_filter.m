function [h_proto,passedge] = prototype_filter(N,nbands)
stopedge = 1/nbands;
passedge = 1/(4*nbands);
h_proto = remez(N,[0,passedge,stopedge,1],[1,1,0,0],[5,1]);
[H_proto, w]=freqz(h_proto,1,512);
plot(w/pi, abs(H_proto),'k')
xlabel('w / pi')
ylabel('Magnitude')
title('Prototype LPF')
grid