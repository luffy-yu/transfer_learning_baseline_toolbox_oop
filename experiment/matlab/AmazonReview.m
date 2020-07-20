classdef AmazonReview < Dataset
    %AMAZONREVIEW Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = AmazonReview(datasetpath)
            %AMAZONREVIEW Construct an instance of this class
            %   Detailed explanation goes here
            obj@Dataset();
            obj.datasetName = 'Amazon Review';
            obj.datasetPath = datasetpath;
            obj.sourceDomains = {'books','dvd','elec','kitchen'};
            obj.targetDomains = {'books','dvd','elec','kitchen'};
            obj.new_sourceDomains = {'books_new','dvd_new','elec_new','kitchen_new'};
            obj.new_targetDomains = {'books_new','dvd_new','elec_new','kitchen_new'};
        end
        
        function obj = load_source_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name, '_400.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
        function obj = load_target_domain(obj, name, tar_name)
            clear fts;
            clear labels;
            obj.X = [];
            obj.Y = [];
            load([name, '_400.mat']);
            obj.X = fts;
            obj.Y = labels;
        end
        
    end
end

