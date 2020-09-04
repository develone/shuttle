clear
close all
pkg load signal
t = 0:0.01:2;
x = chirp (t, 2, .5, 10, "quadratic") + sin (2*pi*t*0.4);
y = decimate (x, 4);
stem (t(1:121) * 1000, x(1:121), "-g;Original;"); hold on;
stem (t(1:4:121) * 1000, y(1:31), "-r;Decimated;"); hold off;