classdef MnistUSPS < Dataset
    
    properties
    end
    
    methods
        function obj = MnistUSPS(datasetpath)
            obj@Dataset();
            obj.datasetName = 'Mnist-USPS';
            obj.datasetPath = datasetpath;
            obj.sourceDomains = {'MNIST', 'USPS'}; 
            obj.targetDomains = {'MNIST', 'USPS'}; 
            obj.new_sourceDomains = {'MNIST_new', 'USPS_new'}; 
            obj.new_targetDomains = {'MNIST_new', 'USPS_new'}; 
            obj.show_dodge = 0.2;
        end
        
        function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name '_' name '.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name '_' tar_name '.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
    end
end

