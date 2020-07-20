classdef Office31 < ImageCLEF
        
    properties
    end
    
    methods
        function obj = Office31(datasetpath)
            obj@ImageCLEF(datasetpath);
            obj.datasetName = 'Office 31';
            obj.sourceDomains = {'amazon', 'dslr', 'webcam'}; 
            obj.targetDomains = {'amazon', 'dslr', 'webcam'}; 
            obj.new_sourceDomains = {'amazon_new', 'dslr_new', 'webcam_new'}; 
            obj.new_targetDomains = {'amazon_new', 'dslr_new', 'webcam_new'}; 
        end
    end
end