classdef JDAMethod < TransferMethod
    
    properties
        options
    end
    
    methods
        function obj = JDAMethod()
            obj.methodName = 'JDA';
            options.kernel_type = 'primal';
            options.dim = 30;
            options.lambda = 1;
            options.gamma = 1;
            options.T = 10;
            obj.options = options;
        end
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            Xs = double(Xs);
            Ys = double(Ys);
            Xt = double(Xt);
            Yt = double(Yt);
            [list_acc,acc_ite,A] = JDA(Xs,Ys,Xt,Yt,obj.options);
        end
    end
end

