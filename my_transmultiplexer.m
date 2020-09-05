%05/13/05 Cosine Modulated filters
%Program to find the filter bank for transmultiplexer

[h_proto,passedge] = prototype_filter(24,4);

[H_proto, w]=freqz(h_proto,1,512);
plot(w/pi, abs(H_proto),'k')
xlabel('w / pi')
ylabel('Magnitude')
title('Prototype LPF')
grid

[h,g] = make_bank(h_proto,4);

figure

[H1, w1]=freqz(h(1,:),1,512);
plot(w1/pi, abs(H1),'r')
xlabel('w / pi')
ylabel('Magnitude')
hold on
[H2, w2]=freqz(h(2,:),1,512);
plot(w2/pi, abs(H2),'k')
xlabel('w / pi')
ylabel('Magnitude')
hold on
[H3, w3]=freqz(h(3,:),1,512);
plot(w3/pi, abs(H3),'g')
xlabel('w / pi')
ylabel('Magnitude')
hold on
[H4, w4]=freqz(h(4,:),1,512);
plot(w4/pi, abs(H4),'y')
xlabel('w / pi')
ylabel('Magnitude')
hold off
grid
title('Analysis Filters H')

figure

[G1, w1]=freqz(g(1,:),1,512);
plot(w1/pi, abs(G1),'c')
xlabel('w / pi')
ylabel('Magnitude')
hold on
[G2, w2]=freqz(g(2,:),1,512);
plot(w2/pi, abs(G2),'m')
xlabel('w / pi')
ylabel('Magnitude')
hold on
[G3, w3]=freqz(g(3,:),1,512);
plot(w3/pi, abs(G3),'b')
xlabel('w / pi')
ylabel('Magnitude')
hold on
[G4, w4]=freqz(g(4,:),1,512);
plot(w4/pi, abs(G4),'.-k')
xlabel('w / pi')
ylabel('Magnitude')
hold off
title('Synthesis Filters G')
grid