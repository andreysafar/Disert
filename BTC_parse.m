function BTC_parse(varargin)
% Процедура
% Задача: получить на выходе актуальные стаканы
% формат выдачи: BTC_USD_stack_ask



if isempty(varargin)
        Chain='/home/safar/bitcoin/M-files/Chain4/';
    end 
s=dir(Chain);


   
   for i=3:length(s)
     open_struct=open(s(i).name);
     for k=1:length(open_struct)
         btc_usd=open_struct
   end
end
