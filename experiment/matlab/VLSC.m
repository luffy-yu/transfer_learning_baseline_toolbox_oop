classdef VLSC < Dataset
    
    properties
    end
    
    methods
        function obj = VLSC(datasetpath)
            obj@Dataset();
            obj.datasetName = 'VLSC';
            obj.datasetPath = datasetpath;
            obj.sourceDomains = { 'Caltech101', 'ImageNet', 'LabelMe', 'SUN09', 'VOC2007' };
            obj.targetDomains = { 'Caltech101', 'ImageNet', 'LabelMe', 'SUN09', 'VOC2007' };
            obj.new_sourceDomains = { 'Caltech101_new', 'ImageNet_new', 'LabelMe_new', 'SUN09_new', 'VOC2007_new' };
            obj.new_targetDomains = { 'Caltech101_new', 'ImageNet_new', 'LabelMe_new', 'SUN09_new', 'VOC2007_new' };
            obj.show_rotation = -60;
        end
        
        function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name, '_cleaned.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([tar_name, '_cleaned.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
    end
end

