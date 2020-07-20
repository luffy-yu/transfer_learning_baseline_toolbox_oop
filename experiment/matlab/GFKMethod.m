classdef GFKMethod < TransferMethod
    
    properties
        dim
    end
    
    methods
        function obj = GFKMethod()
            obj.methodName = 'GFK';
            obj.dim = 30;
        end
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            [list_acc,G,Cls] = GFK(Xs,Ys,Xt,Yt,obj.dim);
        end
    end
end

