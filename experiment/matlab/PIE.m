classdef PIE < Dataset
        
    properties
    end
    
    methods
        function obj = PIE(datasetpath)
            obj@Dataset();
            obj.datasetPath = datasetpath;
            obj.datasetName = 'PIE';
            obj.sourceDomains = { 'PIE05', 'PIE07', 'PIE09', 'PIE27', 'PIE29' };
            obj.targetDomains = { 'PIE05', 'PIE07', 'PIE09', 'PIE27', 'PIE29' };
            obj.new_sourceDomains = { 'PIE05_new', 'PIE07_new', 'PIE09_new', 'PIE27_new', 'PIE29_new' };
            obj.new_targetDomains = { 'PIE05_new', 'PIE07_new', 'PIE09_new', 'PIE27_new', 'PIE29_new' };
            obj.show_rotation = -60;
        end
        
       function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name '_cleaned.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([tar_name '_cleaned.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
    end
end