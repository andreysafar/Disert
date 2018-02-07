
B_R=realtime_trades('dsh_btc');
k=1;
for i = 1:10:1000
    k=k+1;
    b = (1/i)*ones(1,i);
 B_R_pr(k,:)=filter(b,1,B_R);
 
end
%}
%{
global nonce; 
nonce =14;

for i=1001:10000:150000
    a(nonce,:)=TradeHistory('since',num2str(i-1000),'end',num2str(i),'pair','btc_usd');
    nonce=nonce+1;
end
%}