% Call the api
% input is the method and the parameters
% output is the response of the api call in json format
%
% parameters format should look like:
% parameters = '&parameter1=value1&parameter2=value2'
%
% Example:
%
% method = 'getInfo';
% parameters = '';
% response = btce_call(method, parameters);
%
% !Important!
% Change the appKey and appSecret to your key and secret (found online
% on your btc-e account.

function response = btce_call(method, params, nonce)

    % Change appKey and appSecret
    %%%%%%%%%%%%%%%%
    appKey = 'CASKWDCC-2FJAT2BF-Z9FA48M2-N756MLPO-08XW79L6';
    appSecret = 'f7ea7d2048ead2d594e6f97314b3851a7f0f028566b51db1fc0ca9a16d6272d6';
global nonce;
    % Create a nonce, calls can be made successively every millisecond
    % This nonce works until 18-jan-2026
   % nonce = strrep(num2str(now*1000000-7.34E11), '.', '');
   % nonce = nonce(1:10);
   %nonce = 5;

    % Addres to call
    addr = 'https://wex.nz/tapi';

    % Parameters to use
    parameters = [ 'nonce=' num2str(nonce) '&method=' method params];

    % SHA512 encoding
    requestString = doHMAC_SHA512(parameters, appSecret);

    % Create the headers
    header1 = http_createHeader('Content-Type','application/x-www-form-urlencoded');
    header2 = http_createHeader('Key', appKey);
    header3 = http_createHeader('Sign', requestString);
    headers = [header1 header2 header3];

    % Do the request
    response = urlread2(addr,'POST',parameters,headers);

end