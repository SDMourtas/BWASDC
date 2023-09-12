function [W,Em,Nbest,E,Ns,R]=BWASDC(X,Y,n,tmax,d,delta)
% function for finding the optimal hidden-layer neurons powers and weights
% of the neuronet

eta_delta=0.95; eta_d=0.95; L=length(Y);
x0=(1-round(n/2):n-round(n/2))'; 
E=zeros(tmax+1,1); Ns=zeros(tmax+1,1); R=1;
Em=fitness(X,Y,L,x0); E(1)=Em; Nsm=sum(x0>0); Ns(1)=Nsm; 

% iteration
for t=1:tmax 
    r=rands(n,1); r=r/(eps+norm(r));
    xr=round(x0+d*r); xl=round(x0-d*r);
    Er=fitness(X,Y,L,xr);
    El=fitness(X,Y,L,xl);
    x=round(x0+delta*r*sign(Er-El)); 
    E(t+1)=fitness(X,Y,L,x); Ns(t+1)=sum(x>0);
    if E(t+1)<Em
        x0=x; Em=E(t+1); Nsm=Ns(t+1); R=t+1;
    elseif E(t+1)==Em
        if Nsm>Ns(t+1)
            x0=x; Nsm=Ns(t+1); R=t+1;
        end
    end
    delta=eta_delta*delta;
    d=eta_d*d+0.001;
end

% output
Nbest=x0; Nbest(Nbest<1)=[];
K=Kmatrix(X,L,L,Nbest);
W=pinv(K)*Y; 
