function BTC_chain()
%парсит данные с бирж

   hF = figure();
%set(hF, 'Position', [10 10 100 30]);
% создаем две пары осей
hA1 = axes('Position', [0.1 0.2 0.7 0.3]);
hA2 = axes('Position', [0.1 0.6 0.7 0.3]);
%ssttrr='btc_usd-btc_rur-btc_eur-ltc_btc-ltc_usd-ltc_rur-ltc_eur-nmc_btc-nmc_usd-nvc_btc-nvc_usd-usd_rur-eur_usd-eur_rur-ppc_btc-ppc_usd-dsh_btc-dsh_usd-dsh_rur-dsh_eur-dsh_ltc-dsh_eth-dsh_zec-eth_btc-eth_usd-eth_eur-eth_ltc-eth_rur-eth_zec-bch_usd-bch_btc-bch_rur-bch_eur-bch_ltc-bch_eth-bch_dsh-bch_zec-zec_btc-zec_usd-zec_ltc'

ssttrr='btc_usd'

%wex.nz
limit_history=500;
tick=0;

json_trades = parse_json(urlread(['https://wex.nz/api/3/trades/' ssttrr '?limit=' num2str(limit_history)]));
v=0;
while true
    % ... some computation, eg,
    tick=tick+1;
    
    %получает json ответ с биржы wex
    
    
    if mod(v,fix((json_trades.btc_usd{1, 1}.timestamp  -json_trades.btc_usd{1,limit_history}.timestamp)/200)*100  )==0
        json_trades = parse_json(urlread(['https://wex.nz/api/3/trades/' ssttrr '?limit=' num2str(limit_history)]));
        save(['Wex_chain/trades' num2str(now) '_v' num2str(v) '.mat'],'-struct','json_trades');
        v=0;
    end
    v=v+1;
    try
    json_depth = parse_json(urlread(['https://wex.nz/api/3/depth/' ssttrr '?limit=' num2str(limit_history)]));
    
    save(['Wex_chain/Depth' num2str(now) '.mat'],'-struct','json_depth');
    end
    
    %*************
    aaa=monte_carlo;
    
    
    [a b]=ksdensity(aaa(1,:));
    Y=spline(b,a,b(1):b(100));
    k=1;
    for i = round(b(1)+1):round(b(100));
        img(i,tick)=Y(k);
        k=k+1;
    end
    axes(hA1);
    imagesc(img)
    set(hA1, 'YLim',[round(b(1)) round(b(100))])
    set(hA1, 'XLim',[tick-6.5 tick])
    axis xy
    caxis([0 0.1])
    colormap jet
    axes(hA2);
    imagesc(img)
    set(hA2, 'YLim',[round(b(1)) round(b(100))])
    axis xy
    caxis([0 0.1])
    colormap jet
    pause(0.1)
    
    %******

end
