classdef CORALMethod < TransferMethod
    
    properties
    end
    
    methods
        function obj = CORALMethod()
            obj.methodName = 'CORAL';
        end
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            Xs = double(Xs);
            Ys = double(Ys);
            Xt = double(Xt);
            Yt = double(Yt);
            [list_acc,y_pred,time_pass] = CORAL_SVM(Xs,Ys,Xt,Yt);
        end
    end
end

