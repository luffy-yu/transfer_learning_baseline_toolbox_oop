classdef DomainNet < Dataset
    
    properties
    end
    
    methods
        function obj = DomainNet(datasetpath)
            obj@Dataset();
            obj.datasetName = 'DomainNet';
            obj.datasetPath = datasetpath;
            obj.sourceDomains = {'clipart', 'infograph', 'painting', 'quickdraw', 'real', 'sketch'};
            obj.targetDomains = {'clipart', 'infograph', 'painting', 'quickdraw', 'real', 'sketch'};
            obj.new_sourceDomains = {'clipart_new', 'infograph_new', 'painting_new', 'quickdraw_new', 'real_new', 'sketch_new'};
            obj.new_targetDomains = {'clipart_new', 'infograph_new', 'painting_new', 'quickdraw_new', 'real_new', 'sketch_new'};
            obj.show_rotation = -60;
        end
        
        function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name, '_10_train.txt.mat']);
            obj.X = fts;
            obj.Y = labels';
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name, '_10_train.txt.mat']);
            obj.X = fts;
            obj.Y = labels';
        end
        
    end
end

