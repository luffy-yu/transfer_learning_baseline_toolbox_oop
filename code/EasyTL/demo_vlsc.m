% Test with PIE

list_acc = [];
count = size(str_domains, 2);
for i = 1 : count
    for j = 1 : count
        if i == j
            continue;
        end
        fprintf('%s - %s\n',str_domains{i}, str_domains{j});
        src = str_domains{i};
        tgt = str_domains{j};
        load([src '_cleaned.mat']);     % source domain
        fts = fts ./ repmat(sum(fts,2),1,size(fts,2)); 
        Xs = zscore(fts,1);    clear fts
        Ys = labels;           clear labels
        
        load([tgt '_cleaned.mat']);     % target domain
        fts = fts ./ repmat(sum(fts,2),1,size(fts,2)); 
        Xt = zscore(fts,1);     clear fts
        Yt = labels;            clear labels
        
        % EasyTL without intra-domain alignment [EasyTL(c)]
        [Acc1, ~] = EasyTL(Xs,Ys,Xt,Yt,'raw');
        fprintf('Acc: %f\n',Acc1);
        
        % EasyTL with CORAL for intra-domain alignment
        [Acc2, ~] = EasyTL(Xs,Ys,Xt,Yt);
        fprintf('Acc: %f\n',Acc2);
        
        list_acc = [list_acc;[Acc1,Acc2]];
    end
end
