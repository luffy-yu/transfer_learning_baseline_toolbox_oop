classdef Dataset
    %DATASET Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        datasetName
        datasetPath
        sourceDomains
        targetDomains
        transferMethod
        X
        Y
        new_sourceDomains
        new_targetDomains
        show_dodge
        show_rotation
    end
    
    methods
        function obj = Dataset()
            %DATASET Construct an instance of this class
            %   Detailed explanation goes here
            obj.datasetName = '';
            obj.datasetPath = '';
            obj.sourceDomains = [];
            obj.targetDomains = [];
            obj.show_dodge = 1;
            obj.show_rotation = 0;
        end
        
        function domains = get_transfer_domains(obj)
            str_domains = obj.sourceDomains;
            X = {};
            count = size(str_domains, 2);
            for i = 1 : count
                for j = 1 : count
                    if i == j
                        continue;
                    end
                    fprintf('%s - %s\n',str_domains{i}, str_domains{j});
                    s = [str_domains{i} '-' str_domains{j}];
                    X = [X {s}];
                end
                domains = X;
                
            end
        end
        
        function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            load(name);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            load(name);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function list_acc = run(obj)
            str_domains = obj.sourceDomains;
            tar_domains = obj.targetDomains;
            list_acc = [];
            count = size(str_domains, 2);
            for i = 1 : count
                for j = 1 : count
                    if i == j
                        continue;
                    end
                    fprintf('%s - %s\n',str_domains{i}, tar_domains{j});
                    %% Load data
                    %                     load([str_domains{i},'_400.mat']);
                    obj = obj.load_source_domain(str_domains{i}, tar_domains{j});
                    Xs = obj.X;
                    Ys = obj.Y;
                    %                     load([tar_domains{j},'_400.mat']);
                    obj = obj.load_target_domain(str_domains{j}, tar_domains{j});
                    Xt = obj.X;
                    Yt = obj.Y;
                    if min(unique(Ys)) == 0
                        Ys = Ys + 1;
                    end
                    if min(unique(Yt)) == 0
                        Yt = Yt + 1;
                    end
                    
                    Xs = Xs ./ repmat(sum(Xs,2),1,size(Xs,2));
                    Xs = zscore(Xs,1);
                    Xt = Xt ./ repmat(sum(Xt,2),1,size(Xt,2));
                    Xt = zscore(Xt,1);
                    
                    Acc = obj.transferMethod.transfer(Xs,Ys,Xt,Yt);
                   
                    list_acc = [list_acc;Acc];
                    
                end
            end
        end
        
        function list_acc = run_new(obj)
            list_acc = [];
            % backup
            src_domains = obj.sourceDomains;
            tar_domains = obj.targetDomains;
            % run
            obj.sourceDomains = obj.new_sourceDomains;
            obj.targetDomains = obj.new_targetDomains;
            list_acc = obj.run();
            % backup
            obj.sourceDomains = src_domains;
            obj.targetDomains = tar_domains;
        end
    end
end

