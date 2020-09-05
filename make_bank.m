%Program to build a filter bank with given number of channels and a
%prototype low pass filter

function [H,G] = make_bank(h,nbands)
%  [H,G] = make_bank(h,nbands)
%  This function creates the filters for a pseudo-QMF filter banks
%  with number of bands = nbands
flen = max(size(h));
t = sqrt(2)/2;
for k = 1:nbands
   a(2*k-1) = t + i*t;
   a(2*k) = t - i*t;
end
for k=1:nbands
   for l=1:flen
      m1 = cos(pi*(2*k-1)*(2*l-1)/(4*nbands));
      m2 = sin(pi*(2*k-1)*(2*l-1)/(4*nbands));
      H(k,l) = 2.0*(real(a(k))*m1 - imag(a(k))*m2)*h(l);
   end
   %  Form synthesis filters
   for l=1:flen
      m1 = cos(pi*(2*k-1)*(2*l-1)/(4*nbands));
      m2 = sin(pi*(2*k-1)*(2*l-1)/(4*nbands));
      G(k,l) = 2.0*(real(a(k))*m1 + imag(a(k))*m2)*h(l);
   end
end