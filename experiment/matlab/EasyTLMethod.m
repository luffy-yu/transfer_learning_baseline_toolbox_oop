classdef EasyTLMethod < TransferMethod
    %EASYTLMETHOD Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function obj = EasyTLMethod()
            %SVMMETHOD Construct an instance of this class
            %   Detailed explanation goes here
            obj.methodName = 'EasyTL';
        end
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            [list_acc,~] = EasyTL(Xs,Ys,Xt,Yt);
        end
    end
end

