classdef TCAMethod < TransferMethod
    
    properties
        options
    end
    
    methods
        function obj = TCAMethod()
            obj.methodName = 'TCA';
            options.lambda = 1;
            options.dim = 30;
            options.kernel_type = 'linear';
            options.gamma = 1;
            obj.options = options;
        end
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            Xs = double(Xs);
            Ys = double(Ys);
            Xt = double(Xt);
            Yt = double(Yt);
            [Xs_new,Xt_new,A] = TCA(Xs,Xt, obj.options);
            knn_model = fitcknn(Xs_new, Ys,'NumNeighbors',1);
            y_pred = knn_model.predict(Xt_new);
            list_acc = length(find(y_pred==Yt))/length(Yt);
        end
    end
end

