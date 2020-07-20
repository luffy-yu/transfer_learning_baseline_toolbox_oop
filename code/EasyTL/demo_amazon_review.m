%% Test Amazon review dataset

% addpath('../dataset/amazon_review/');
%str_domains = {'books','dvd','elec','kitchen'};
list_acc = [];
count = size(str_domains, 2);
for i = 1 : count
    for j = 1 : count
        if i == j
            continue;
        end
        fprintf('%s - %s\n',str_domains{i}, str_domains{j});
        %% Load data
        load([str_domains{i},'_400.mat']);
        Xs = fts;    clear fts;
        Ys = labels; clear labels;
        load([tar_domains{j},'_400.mat']);
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
end