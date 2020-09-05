%--------------------------------------------------------------------------
% Taking care of shifts after decompression
% April 07 2005
% All operations are done assuming both input vectors are equal in length
% Future Work: Add SNR before and after, divide signal into smaller segments 
%--------------------------------------------------------------------------
function SIG=allign(sig1,sig2)
%--------------------------------------------------------------------------
% Function to read two signals, find thier cross-correaltion and use that
% to find out if they are alligned. If not alligned then find the
% shift(left or right) then move the signal2 to be alligned with the mother
% signal i.e., signal1
%--------------------------------------------------------------------------
disp('Length of Signal1 is ')
l1=length(sig1);
disp(l1)
disp('Length of Signal2 is ')
l2=length(sig2);
disp(l2)

[AC_sig1,lags1]=xcorr(sig1,sig1);
[XC_sig12,lags12]=xcorr(sig1,sig2);

[M_AC_sig1,I1]=max(AC_sig1);
[M_XC_sig12,I2]=max(XC_sig12);
disp('Maximum in Auto-correlation occurs at ')
disp(I1)
disp('Maximum in Cross-correlation occurs at ')
disp(I2)

if I1>I2
    disp('The Signal2 is shifted to the right of Signal1 by ')
    D=I1-I2;
    disp(D)
    SIG=zeros(l2,1);
    for i=1:l2
        if (i+D)<=l2
            SIG(i)=sig2(i+D);
        else SIG(i)=0;
        end
    end
else if I2>I1
        disp('The Signal2 is shifted to the left of Signal1 by ')
        D=I2-I1;
        disp(D)
        SIG=zeros(l2,1);
        for i=1:l2
            if (i+D)<=l2
                SIG(i+D)=sig2(i);
            else SIG(i+D)=0;
            end
        end
else
    disp('The two Signals are similar')
    SIG=sig2;
end
end
