classdef VisDA < Dataset
    
    properties
        Xt_all
        Yt_all
    end
    
    methods
        function obj = VisDA(datasetpath)
            obj@Dataset();
            obj.datasetName = 'VisDA';
            obj.datasetPath = datasetpath;
            obj.sourceDomains = 'train_1000.mat';
            obj.targetDomains = 'validation_1000.mat';
            obj.new_sourceDomains = 'train_new_1000.mat';
            obj.new_targetDomains = 'validation_new_1000.mat';
            obj.Xt_all = [];
            obj.Yt_all = [];
        end
        
        function domains = get_transfer_domains(obj)
            domains = {'aeroplane','bicycle','bus','car','horse','knife','motorcycle','person','plant','skateboard','train','truck'};
        end
        
        
        function obj = load_source_domain(obj, name, tar_name)
            load(name);
            Xs = fts;       clear fts;
            Ys = labels;    clear labels;
            Xs = Xs ./ repmat(sum(Xs,2),1,size(Xs,2));
            obj.X = zscore(Xs, 1);
            obj.Y = Ys + 1;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            load(tar_name);
            Xt = fts;       clear fts;
            Yt = labels;    clear labels;
            Xt = Xt ./ repmat(sum(Xt,2),1,size(Xt,2));
            Xt = zscore(Xt,1);
            Yt = Yt + 1;
            obj.Xt_all = Xt;
            obj.Yt_all = Yt;
        end
        
        function list_acc = run(obj)
            str_domains = obj.sourceDomains;
            tar_domains = obj.targetDomains;
            
            obj = obj.load_source_domain(str_domains, '');
            Xs = obj.X;
            Ys = obj.Y;
            
            obj = obj.load_target_domain('', tar_domains);
            Xt_all = obj.Xt_all;
            Yt_all = obj.Yt_all;
            
            list_acc = [];
            domains = obj.get_transfer_domains();
            count = size(domains, 2);
            for i = 1 : count
                fprintf('%s\n',domains{i});
                clear Xt;
                clear Yt;
                %% Load data
                Yt = Yt_all(Yt_all == i, :);
                Xt = Xt_all(Yt_all == i, :);
                
                Acc = obj.transferMethod.transfer(Xs,Ys,Xt,Yt);
                
                list_acc = [list_acc;Acc];
                
            end
        end
    end
end

