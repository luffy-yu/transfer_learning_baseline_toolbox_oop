classdef TransferMethod
    %TRANSFERMETHOD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        methodName
    end
    
    methods
        function obj = TransferMethod()
            %TRANSFERMETHOD Construct an instance of this class
            %   Detailed explanation goes here
            obj.methodName = '';
        end
        
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            list_acc = [];
        end
    end
end
