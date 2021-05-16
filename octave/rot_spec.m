for i=1:length(moon004(:,1))
[M,MI]=max(reshape([moon004(i,:) zeros(1,10)],50,21));
mas(:,i)=M;
masi(:,i)=MI;
endfor
