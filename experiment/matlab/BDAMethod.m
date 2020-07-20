classdef BDAMethod < TransferMethod
    
    properties
        options
    end
    
    methods
        function obj = BDAMethod()
            obj.methodName = 'BDA';
            options.gamma = 1.0;
            options.lambda = 0.1;
            options.kernel_type = 'linear';
            options.T = 10;
            options.dim = 100;
            options.mu = 0;
            options.mode = 'W-BDA';
            obj.options = options;
        end
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            Xs = double(Xs);
            Ys = double(Ys);
            Xt = double(Xt);
            Yt = double(Yt);
            [list_acc,acc_ite,~] = BDA(Xs,Ys,Xt,Yt,obj.options);
        end
    end
end

