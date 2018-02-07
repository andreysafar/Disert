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

function ticker = realtime_trades(couple)

    if nargin == 0
        couple = 'dsh_btc';
    end

    url = ['https://wex.nz/api/3/trades/' couple '?limit=5000'];

    html = urlread(url);
    anns = parse_json(html);
    for i = 1: 5000
        ticker(1).name=couple(1).name
        
        BTC(5001-i)=anns.dsh_btc{1,i}.price;
        
    end 
    % Display the returned parsed json string
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
   ticker=BTC;
end