classdef ImageCLEF < Dataset
    
    properties
    end
    
    methods
        function obj = ImageCLEF(datasetpath)
            obj@Dataset();
            obj.datasetName = 'Image CLEF';
            obj.datasetPath = datasetpath;
            obj.sourceDomains = {'c', 'i', 'p'};
            obj.targetDomains = {'c', 'i', 'p'};
            obj.new_sourceDomains = {'c_new','i_new','p_new'};
            obj.new_targetDomains = {'c_new','i_new','p_new'};
        end
        
        function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            data = load([name '_' name '.csv']);
            fts = data(1:end,1:end-1);
            labels = data(1:end,end);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            data = load([name '_' tar_name '.csv']);
            fts = data(1:end,1:end-1);
            labels = data(1:end,end);
            obj.X = fts;
            obj.Y = labels;
        end
        
    end
end

