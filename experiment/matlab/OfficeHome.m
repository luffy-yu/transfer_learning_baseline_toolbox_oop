classdef OfficeHome < ImageCLEF
        
    properties
    end
    
    methods
        function obj = OfficeHome(datasetpath)
            obj@ImageCLEF(datasetpath);
            obj.datasetName = 'Office Home';
            obj.sourceDomains = {'Art', 'Clipart', 'Product', 'RealWorld'}; 
            obj.targetDomains = {'Art', 'Clipart', 'Product', 'RealWorld'}; 
            obj.new_sourceDomains = {'Art_new', 'Clipart_new', 'Product_new', 'RealWorld_new'}; 
            obj.new_targetDomains = {'Art_new', 'Clipart_new', 'Product_new', 'RealWorld_new'}; 
            obj.show_rotation = -60;
        end
    end
end