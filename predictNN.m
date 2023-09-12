function [Ypred,docYpred]=predictNN(Model,X,docY)

Ypred = Model.predictFcn(X); 
docYpred=docY(Ypred,:)';