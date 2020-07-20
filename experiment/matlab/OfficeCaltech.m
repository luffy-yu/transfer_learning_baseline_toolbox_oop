classdef OfficeCaltech < Dataset
        
    properties
    end
    
    methods
        function obj = OfficeCaltech(datasetpath)
            obj@Dataset();
            obj.datasetPath = datasetpath;
            obj.datasetName = 'Office Caltech';
            obj.sourceDomains = { 'Caltech10', 'amazon', 'webcam', 'dslr' };
            obj.targetDomains = { 'Caltech10', 'amazon', 'webcam', 'dslr' };
            obj.new_sourceDomains = { 'Caltech10_new', 'amazon_new', 'webcam_new', 'dslr_new' };
            obj.new_targetDomains = { 'Caltech10_new', 'amazon_new', 'webcam_new', 'dslr_new' };
            obj.show_rotation = -60;
        end
        
       function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name '_SURF_L10.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([tar_name '_SURF_L10.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
    end
end