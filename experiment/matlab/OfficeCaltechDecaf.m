classdef OfficeCaltechDecaf < Dataset
        
    properties
    end
    
    methods
        function obj = OfficeCaltechDecaf(datasetpath)
            obj@Dataset();
            obj.datasetPath = datasetpath;
            obj.datasetName = 'Office Caltech Decaf';
            obj.sourceDomains = { 'caltech', 'amazon', 'webcam', 'dslr' };
            obj.targetDomains = { 'caltech', 'amazon', 'webcam', 'dslr' };
            obj.new_sourceDomains = { 'Caltech10_new', 'amazon_new', 'webcam_new', 'dslr_new' };
            obj.new_targetDomains = { 'Caltech10_new', 'amazon_new', 'webcam_new', 'dslr_new' };
            obj.show_rotation = -60;
        end
        
       function obj = load_source_domain(obj, name, tar_name)
            clear feas;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name '_decaf.mat']);
            obj.X = normr(feas);
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear feas;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([tar_name '_decaf.mat']);
            obj.X = normr(feas);
            obj.Y = labels;
        end
        
        function list_acc = run_new(obj)
            list_acc = [];
        end
    end
end