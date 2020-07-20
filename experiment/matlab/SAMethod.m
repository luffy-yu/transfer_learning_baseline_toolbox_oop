classdef SAMethod < TransferMethod
    
    properties
    end
    
    methods
        function obj = SAMethod()
            obj.methodName = 'SA';
        end
        
        function list_acc = transfer(obj, Xs,Ys,Xt,Yt)
            Xs = double(Xs);
            Ys = double(Ys);
            Xt = double(Xt);
            Yt = double(Yt);
            subspace_dim_d = 80;
            [Xss,~,~] = pca(Xs);
            [Xtt,~,~] = pca(Xt);
            Xs_ = Xss(:,1:subspace_dim_d);
            Xt_ = Xtt(:,1:subspace_dim_d);
            [list_acc,y_pred,time_pass] =  SA_SVM(Xs,Ys,Xt,Yt,Xs_,Xt_);
        end
    end
end

