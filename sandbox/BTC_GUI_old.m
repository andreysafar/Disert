%plot_tick ()
clear all
tick=1;
img(1:30000,1)=0;

limit_history=10
colormap jet

hF = figure('Name', 'myplotgui2', 'NumberTitle', 'off',...
'MenuBar', 'none', 'Units', 'characters');
set(hF, 'Position', [10 10 100 30]); 
% создаем две пары осей
hA1 = axes('Position', [0.1 0.2 0.3 0.7]);
hA2 = axes('Position', [0.6 0.2 0.3 0.7]);
% создаем две кнопки, для каждой кнопки функция BtnP
    btc_usd_bid(1)=0;
    btc_usd_ask(1)=0;
    btc_usd_p(1)=0;
    btc_usd_t(1)=0;

for tick =1:30000;

    %УДАЛИЛ КАК ПАРСИТ, ОСТАВИЛ ТОЛЬКО КАК РИСУЕТ. 
    
    
    %subplot(2,1,1)
    
    axes(hA1);

    plot(btc_usd_t,btc_usd_p) 
    set(hA1, 'YLim',[btc_usd_p(1)-1500 btc_usd_p(1)+1500])
    
 %{ subplot(2,2,2)
%   plot(btc_usd_t,btc_usd_bid-btc_usd_ask)

   % figure 
 %   subplot(2,2,3);
  %  image(img) ;
   % axis ([0 tick btc_usd_p(1)-100 btc_usd_p(1)+100]);
    %subplot(2,1,2);
    axes(hA2);
   img(1,tick)=0;
   img= Depth(img,tick);      
   
   for i = round(btc_usd_p(1))+2:30000

           img(i,tick)=img(i,tick)+img(i-1,tick);

   end
   
   for i = round(btc_usd_p(1))-2:-1:1

           img(i,tick)=img(i,tick)+img(i+1,tick);

   end
   
       for i = 2:limit_history
        img(round(btc_usd_p(i)),tick)=10000000;
    end 
   
    imagesc(img,[0  btc_usd_p(10)])
   caxis ([0 200]);
    if tick <1000
         axis ([0 tick btc_usd_p(1)-100 btc_usd_p(1)+100]);
   else
         axis ([tick-1000 tick btc_usd_p(1)-100 btc_usd_p(1)+100]);
   end
   
   set(hA2,'YDir','normal')
   
   set(hA1, 'YLim',[btc_usd_p(1)-1500 btc_usd_p(1)+1500])
   
    % imagesc(img)
   pause(1)

end
    
    
    
    
    