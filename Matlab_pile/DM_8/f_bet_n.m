function y=f_bet_n(n,b0)
y=zeros(n,1);
for k=1:n
    y(k)=fzero('f_beta',b0(k),[]);
end
end