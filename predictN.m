function [D,YY]=predictN(X,W,A,y_min,y_max,docTarget)
% function for predicting

[N,M]=size(X);
X(X==max(X,[],2))=1;

K=Kmatrix(X,M,N,A);
D=K*W; 

D=round(D); D(D<y_min)=y_min; D(D>y_max)=y_max;

YY=docTarget(D,:)';