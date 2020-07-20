classdef SVMMethod < TransferMethod
    %SVMMETHOD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = SVMMethod()
            obj.methodName = 'SVM';
        end
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            Xs = double(Xs);
            Ys = double(Ys);
            Xt = double(Xt);
            Yt = double(Yt);
            [list_acc,~] = SVM(Xs,Ys,Xt,Yt);
        end
    end
end

