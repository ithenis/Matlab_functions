function data = map_trim(map);
%  autocrop map 
    if numel(size(map)==3)
        map = (sum(map,3));
    end
    data.ix = find(sum(~isnan(map),1));
    data.iy = find(sum(~isnan(map),2));
  
    map = map(data.iy,data.ix);
    imap = isnan(map);
    
    % go around the map, trimming. top -> right -> bottom -> left
    top_sum = sum(imap(1,:)); 
    right_sum = sum(imap(:,end)); 
    bottom_sum = sum(imap(end,:));  
    left_sum = sum(imap(:,1));

    top_trim = 0;
    right_trim = 0;
    bottom_trim = 0;
    left_trim = 0;
    
    while top_sum + right_sum + bottom_sum + left_sum>0
        
        if top_sum>0
            map = map(2:end,:);
            top_trim = top_trim+1;
        end
        if right_sum>0
            map = map(:,1:end-1);
            right_trim = right_trim+1;
        end
        if bottom_sum>0
            map = map(1:end-1,:);
            bottom_trim = bottom_trim+1;
        end
        if left_sum>0
            map = map(:,2:end);
            left_trim = left_trim+1;
        end

        imap = isnan(map);    
        if numel(imap)>0
            top_sum = sum(imap(1,:)); 
            right_sum = sum(imap(:,end)); 
            bottom_sum = sum(imap(end,:));  
            left_sum = sum(imap(:,1));  
            
        else
            
            top_sum = 0; 
            right_sum = 0; 
            bottom_sum = 0;  
            left_sum = 0;  
        end
            
    end
   
data.iy = data.iy(top_trim+1:end-bottom_trim);
data.ix = data.ix(left_trim+1:end-right_trim);