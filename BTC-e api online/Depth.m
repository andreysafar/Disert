% Input: a couple
%
% Example:
% realtime_ticker('ppc_btc')
%
% Output:
% A structure with the values for:
% high
% low
% avg
% vol
% vol_cur
% buy
% sell
% updated
% server_time

function resp = Depth(img,tick)

        couple = 'btc_usd';
   

    url = ['https://wex.nz/api/3/depth/' couple '?limit=5000'];

    html = urlread(url);
    anns = parse_json(html);
    ETH_USD.asks=anns.btc_usd.asks;
    ETH_USD.bids=anns.btc_usd.bids;
    
    X_A(1)= cell2mat(ETH_USD.asks{1}(1));
    Y_A(1)= cell2mat(ETH_USD.asks{1}(2));
    
    for i = 2: length(ETH_USD.asks)
        X_A(i)= cell2mat(ETH_USD.asks{i}(1));
        Y_A(i)=Y_A(i-1)+ cell2mat(ETH_USD.asks{i}(2));
        
        if (X_A(i)<30000) && (X_A(i)>0 )
            img(round(X_A(i)),tick)=img(round(X_A(i)),tick)+Y_A(i);
        end
    end 
        X_B(1)= cell2mat(ETH_USD.bids{1}(1));
        Y_B(1)= cell2mat(ETH_USD.bids{1}(2));
    
    for i = 2: length(ETH_USD.bids)
        X_B(i)= cell2mat(ETH_USD.bids{i}(1));
        Y_B(i)=Y_B(i-1)+ cell2mat(ETH_USD.bids{i}(2));     
        if (X_B(i)<30000) & (round( X_B(i))>0 )
            img(round(X_B(i)),tick)=img(round(X_B(i)),tick)+Y_B(i);
        end
        
    end 
        
        
       resp=img;
       
        
    %end 
    % Display the returned parsed json string
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
   ticker=ETH_USD;
end