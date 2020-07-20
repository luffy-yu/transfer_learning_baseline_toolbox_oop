classdef MEDAMethod < TransferMethod
    
    properties
        options
    end
    
    methods
        function obj = MEDAMethod()
            obj.methodName = 'MEDA';
            options.d = 20;
            options.rho = 1.0;
            options.p = 10;
            options.lambda = 10.0;
            options.eta = 0.1;
            options.T = 10;
            obj.options = options;
        end
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            Xs = double(Xs);
            Ys = double(Ys);
            Xt = double(Xt);
            Yt = double(Yt);
            [list_acc,~,~,~] = MEDA(Xs,Ys,Xt,Yt,obj.options);
        end
    end
end

