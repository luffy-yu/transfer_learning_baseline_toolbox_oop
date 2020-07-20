classdef CrossDataset < Dataset
    
    properties
    end
    
    methods
        function obj = CrossDataset(datasetpath)
            obj@Dataset();
            obj.datasetName = 'Cross Dataset';
            obj.datasetPath = datasetpath;
            obj.sourceDomains = {'caltech256', 'imagenet', 'sun'};
            obj.targetDomains = {'caltech256', 'imagenet', 'sun'};
            obj.new_sourceDomains = {'caltech256_new', 'imagenet_new', 'sun_new'};
            obj.new_targetDomains = {'caltech256_new', 'imagenet_new', 'sun_new'};
        end
        
        function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load(['dense_' name '_decaf7_subsampled.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load(['dense_' name '_decaf7_subsampled.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
    end
end

