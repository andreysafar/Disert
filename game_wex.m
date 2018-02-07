function ans=game_wex(order_sum,asks_fields,bids_fields,N)

for n=1:N
    step=fix(randn*10);
    %**********************
    %***********asks
    try
        if step> 0
            
            % Идем в сторону asks (покупку)
            if step<length(asks_fields)
                
                
                Vol_t=asks_fields(step);
                Vol_t=Vol_t{1};
                Vol_asks=Vol_t{2};
                k=0;
                while Vol_asks>0
                    k=k+1;
                    price_t=bids_fields{k};
                    price=price_t{1};
                    Vol_bids=price_t{2};
                    
                    
                    Vol_asks=Vol_asks-Vol_bids;
                end
                if k>0
                    asks_fields{1,step}{1,1}=0;
                    asks_fields{1,step}{1,2}=0;
                    bids_fields{1,k}{1,2}=-Vol_asks;
                    if k>1
                        for i=1:k-1
                            bids_fields{1,i}{1,2}=0;
                        end
                    end
                end
            end
            
            %**********************
            %***********bids
        end
        if step< 0
            % Идем в сторону bids (покупку)
            step=abs(step);
            if step<length(bids_fields)
                
                Vol_t=bids_fields(step);
                Vol_t=Vol_t{1};
                Vol_bids=Vol_t{2};
                k=0;
                while Vol_bids>0
                    k=k+1;
                    price_t=asks_fields{k};
                    price=price_t{1};
                    Vol_asks=price_t{2};
                    
                    
                    Vol_bids=Vol_bids-Vol_asks;
                end
                if k>0
                    
                    bids_fields{1,step}{1,1}=0;
                    bids_fields{1,step}{1,2}=0;
                    asks_fields{1,k}{1,2}=-Vol_bids;
                    if k>1
                        for i=1:k-1
                            asks_fields{1,i}{1,2}=0;
                        end
                    end
                end
                
            end
        end
        
    end
    try
        ans=price;
    catch
            ans='over';
    end
end
    
end




