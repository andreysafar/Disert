function ans=monte_carlo(chain_base,N, K)
% 1) ������� �������� ������ ����� ������� �� ���������� ����� � ����������
% � ������� ��������
%
% 2) ������������ �� N ����� K ��� ��������� ������ �� ������� �������� ��������,
% ��� ������� ������ ��� � ��������� ����� �� �����
%
% 3) ������� ����������� ��������� ���� �� ���� �� ���������� �������
% ���������� �� ������ ���� ������ ������������ ����� N ����� ���������� �� % �� ��������� �������
% �� 0:200 ��� 100 ��� �������� �� �����

switch nargin
    case 0
        s=dir('Wex_chain');
        N=10;
        K=10000;
    case 1
        s=dir(chain_base);
        N=100;
        K=100;
    case 2
        s=dir(chain_base);
        K=1000;
    case 3
        s=dir(chain_base);
    otherwise
        ans=0;
        disp('False param of monte_carlo');
        return;
end
a=find_oldest_file(s,'Depth');
order_book=load(a);
tiker_name=fieldnames(order_book);

for tiker_name_count=1:size(tiker_name)
    asks_fields=getfield(getfield(order_book,char(tiker_name(tiker_name_count))),'asks');
    bids_fields=getfield(getfield(order_book,char(tiker_name(tiker_name_count))),'bids');
    
    order_sum(tiker_name_count).name=tiker_name(tiker_name_count);
    for asks_count=1:size(asks_fields,2)
        if asks_count==1
            ask_struc=asks_fields{asks_count};
            asks(asks_count)=ask_struc{1}*ask_struc{2};
            
        else
            ask_struc=asks_fields{asks_count};
            asks(asks_count)=asks(asks_count-1)+ask_struc{1}*ask_struc{2};
        end
    end
    
    order_sum(tiker_name_count).asks= asks    ;
    
    for bids_count=1:size(bids_fields,2)
        if bids_count==1
            bids_struc=bids_fields{bids_count};
            bids(bids_count)=ask_struc{1}*bids_struc{2};
            
        else
            ask_struc=bids_fields{bids_count};
            bids(bids_count)=bids(bids_count-1)+ask_struc{1}*ask_struc{2};
        end
    end
    
    order_sum(tiker_name_count).bids= bids    ;
   
    %������
    for k=1:K
        aaa(tiker_name_count,k)=game_wex(order_sum,asks_fields,bids_fields,N);
        
    end
    order_sum(tiker_name_count).mean=mean(aaa(tiker_name_count,:));
    order_sum(tiker_name_count).price=bids_fields{1, 1}{1, 1};
    order_sum(tiker_name_count).trend=order_sum(tiker_name_count).mean-order_sum(tiker_name_count).price;
    order_sum(tiker_name_count).trend_percent=order_sum(tiker_name_count).trend/order_sum(tiker_name_count).price;
end
% ��������� ������ order_sum � ������� 1 ���� ��� ������
% 2 ������������� ������ asks 
% 3 ������������� ������ bids 






ans=aaa;
end
