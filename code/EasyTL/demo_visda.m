list_acc = [];
count = size(tar_domains, 2);

load(str_mat);

Xs = fts;   clear fts;
Ys = labels;    clear labels;
Xs = Xs ./ repmat(sum(Xs,2),1,size(Xs,2));
Xs = zscore(Xs, 1);
Ys = Ys + 1;

load(tar_mat);

Xt_all = fts;   clear fts;
Yt_all = labels;    clear labels;


for i = 1 : count
    fprintf('%s\n',tar_domains{i});
    clear Xt;
    clear Yt;
    %% Load data
    Yt = Yt_all(Yt_all == i - 1, :);
    Xt = Xt_all(Yt_all == i - 1, :);
    
    Yt = Yt + 1;
    Xt = Xt ./ repmat(sum(Xt,2),1,size(Xt,2));
    Xt = zscore(Xt,1);
    
    % EasyTL without intra-domain alignment [EasyTL(c)]
    [Acc1, ~] = EasyTL(Xs,Ys,Xt,Yt,'raw');
    fprintf('Acc: %f\n',Acc1);
    
    % EasyTL with CORAL for intra-domain alignment
    [Acc2, ~] = EasyTL(Xs,Ys,Xt,Yt);
    fprintf('Acc: %f\n',Acc2);
    
    list_acc = [list_acc;[Acc1,Acc2]];
    
end

clear Xs;
clear Ys;
clear Xt_all;
clear Yt_all;
clear Xt;
clear Yt;