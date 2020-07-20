classdef COIL20 < Dataset
    properties
    end
    
    methods
        function obj = COIL20(datasetpath)
            obj@Dataset();
            obj.datasetName = 'COIL 20';
            obj.datasetPath = datasetpath;
            obj.sourceDomains = {'COIL_1', 'COIL_2'};
            obj.targetDomains = {'COIL_1', 'COIL_2'};
            obj.new_sourceDomains = {'COIL_1_new', 'COIL_2_new'};
            obj.new_targetDomains = {'COIL_1_new', 'COIL_2_new'};
        end
        
        function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name, '_SRC.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name, '_TAR.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function list_acc = run(obj)
            str_domains = obj.sourceDomains;
            tar_domains = obj.targetDomains;
            list_acc = [];
            count = size(str_domains, 2);
            for i = 1 : count
                %% Load data
                obj = obj.load_source_domain(str_domains{i}, tar_domains{i});
                Xs = obj.X;
                Ys = obj.Y;
                
                obj = obj.load_target_domain(str_domains{i}, tar_domains{i});
                Xt = obj.X;
                Yt = obj.Y;
                
                Xs = Xs ./ repmat(sum(Xs,2),1,size(Xs,2));
                Xs = zscore(Xs,1);
                Xt = Xt ./ repmat(sum(Xt,2),1,size(Xt,2));
                Xt = zscore(Xt,1);
                
                Acc = obj.transferMethod.transfer(Xs,Ys,Xt,Yt);
                
                list_acc = [list_acc;Acc];
                
            end
        end
        
    end
end

