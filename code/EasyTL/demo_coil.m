%% Test cross dataset

list_acc = [];
count = size(str_domains, 2);
for i = 1 : count
    %% Load data
    load([str_domains{i} '_SRC.mat']);
    Xs = fts;    clear fts;
    Ys = labels; clear labels;
    load([str_domains{i} '_TAR.mat']);
    Xt = fts;    clear fts;
    Yt = labels; clear labels;
    Ys = Ys + 1;
    Yt = Yt + 1;

    Xs = Xs ./ repmat(sum(Xs,2),1,size(Xs,2)); 
    Xs = zscore(Xs,1);
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