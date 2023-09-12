function K=Kmatrix(X,M,K,A)
% function for calculating the matrix K

d=length(A);
K=zeros(K,M*d); 
for i=1:d    
    r=X.^(A(i)-1); r(r<max(r,[],2))=0; % Maxout
    K(:,M*(i-1)+1:M*i)=r;
end