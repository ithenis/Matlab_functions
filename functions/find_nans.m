function imap = find_nans(map)
% looks for nan islands within a map (including edges). each island  is a different number


nnans = sum(isnan(map(:)));
imap = zeros(size(map));
[Y X] = size(map);
if nnans    
    [ynans xnans] = find(isnan(map));
    imap(ynans(1),xnans(1)) = 1;
    crt_i = 1;
    for kk = 2:nnans
        if ynans(kk)>1 && xnans(kk)>1 && imap(ynans(kk)-1,xnans(kk)-1)
            imap(ynans(kk),xnans(kk)) = imap(ynans(kk)-1,xnans(kk)-1);
        elseif xnans(kk)>1 && imap(ynans(kk),xnans(kk)-1)
            imap(ynans(kk),xnans(kk)) = imap(ynans(kk),xnans(kk)-1);
        elseif ynans(kk)<Y && xnans(kk)>1 && imap(ynans(kk)+1,xnans(kk)-1)
            imap(ynans(kk),xnans(kk)) = imap(ynans(kk)+1,xnans(kk)-1);
        elseif ynans(kk)>1 && imap(ynans(kk)-1,xnans(kk))
            imap(ynans(kk),xnans(kk)) = imap(ynans(kk)-1,xnans(kk));
        else
            crt_i = crt_i+1;
            imap(ynans(kk),xnans(kk)) = crt_i;
        end
    end
end
    

