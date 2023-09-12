function E=fitness(X,Y,L,x)
% fitness function

N=x; N(N<1)=[];

X(X==max(X,[],2))=1; 

% WDD Method
K=Kmatrix(X,L,L,N);
W=pinv(K)*Y; 
E=1/L*sum(abs(K*W-Y));    % MAE: training set