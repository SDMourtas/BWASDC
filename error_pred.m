function E=error_pred(X,D)

R=X-D; T=length(D);
E=sum(abs(R))/T; % MAE
fprintf('The test data MAE is: %f \n',E)
