%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  A 3-layer feed-forward neuronet model, trained by a BWASDC       %
%  algorithm. (version 1.0 )                                        %
%                                                                   %
%  Developed in MATLAB R2021a                                       %
%                                                                   %
%  Author and programmer: Y. He, X. Dong, T.E. Simos, S.D. Mourtas, %
%                         V.N. Katsikis, D. Lagios,                 %
%                         P. Zervas, G. Tzimas                      %
%                                                                   %
%   e-Mail: spirosmourtas@gmail.com, vaskatsikis@econ.uoa.gr        %
%                                                                   %
%   Main paper: Y. He, X. Dong, T.E. Simos, S.D. Mourtas,           %
%               V.N. Katsikis, D. Lagios, P. Zervas and G. Tzimas,  %
%              "A bio-inspired weights and structure determination  %
%              neural network for multiclass classification:        %
%              Applications in occupational classification systems,"%
%              (submitted)                                          %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

x=1; % Choose between Examples 1, 2, 3 and 4
[Xtr,Ytr,Xte,Yte,docYtr]=problem(x);

%% Neuronet model Training
Nmax=10;tmax=20;d=20;delta=10;

tic
[W,Em,A,E,N,R]=BWASDC(Xtr,Ytr,Nmax,tmax,d,delta);  % BWASDC's optimal hidden-layer structure
toc

col=size(Xtr,2); y_min=min(Ytr); y_max=max(Ytr); 
tic
FTR_Model=FTR([Xtr,Ytr],col);   % Fine Tree model 
toc

tic
NNN_Model=NNN([Xtr,Ytr],col);   % Narrow Neural Network model 
toc

tic
EBT_Model=EBT([Xtr,Ytr],col);   % Ensemble Bagged Trees model 
toc

tic
FKN_Model=FKN([Xtr,Ytr],col);   % Fine KNN model 
toc

%% Predict
[BWASDC_Ytr,BWASDC_docYtr_pr]=predictN(Xtr,W,A,y_min,y_max,docYtr);  % BWASDC: train data prediction
[BWASDC_Yte,BWASDC_docYte_pr]=predictN(Xte,W,A,y_min,y_max,docYtr);  % BWASDC: test data prediction
[FTR_Ytr,FTR_docYtr_pr]=predictNN(FTR_Model,Xtr,docYtr);  % FTR: train data prediction
[FTR_Yte,FTR_docYte_pr]=predictNN(FTR_Model,Xte,docYtr);  % FTR: test data prediction
[NNN_Ytr,NNN_docYtr_pr]=predictNN(NNN_Model,Xtr,docYtr);  % NNN: train data prediction
[NNN_Yte,NNN_docYte_pr]=predictNN(NNN_Model,Xte,docYtr);  % NNN: test data prediction
[EBT_Ytr,EBT_docYtr_pr]=predictNN(EBT_Model,Xtr,docYtr);  % EBT: train data prediction
[EBT_Yte,EBT_docYte_pr]=predictNN(EBT_Model,Xte,docYtr);  % EBT: test data prediction
[FKN_Ytr,FKN_docYtr_pr]=predictNN(FKN_Model,Xtr,docYtr);  % FKN: train data prediction
[FKN_Yte,FKN_docYte_pr]=predictNN(FKN_Model,Xte,docYtr);  % FKN: test data prediction

% Models statistics on test data
fprintf('BWASDC statistics: \n'); error_pred(BWASDC_Yte,Yte); 
c_matrix= confusionmat(BWASDC_Yte,Yte);  % confusion matrix
BWASDC_Result=confusion.getValues(c_matrix); BWASDC_k=kappa(c_matrix);
fprintf('FTR statistics: \n'); error_pred(FTR_Yte,Yte);
c_matrix= confusionmat(FTR_Yte,Yte);    % confusion matrix
FTR_Result=confusion.getValues(c_matrix); FTR_k=kappa(c_matrix);
fprintf('NNN statistics: \n'); error_pred(NNN_Yte,Yte);
c_matrix= confusionmat(NNN_Yte,Yte);    % confusion matrix
NNN_Result=confusion.getValues(c_matrix); NNN_k=kappa(c_matrix);
fprintf('EBT statistics: \n'); error_pred(EBT_Yte,Yte);
c_matrix= confusionmat(EBT_Yte,Yte);    % confusion matrix
EBT_Result=confusion.getValues(c_matrix); EBT_k=kappa(c_matrix);
fprintf('FKN statistics: \n'); error_pred(FKN_Yte,Yte);
c_matrix= confusionmat(FKN_Yte,Yte);    % confusion matrix
FKN_Result=confusion.getValues(c_matrix); FKN_k=kappa(c_matrix);


%% Figures
Ytr_pr=[BWASDC_Ytr,FTR_Ytr,NNN_Ytr,EBT_Ytr,FKN_Ytr];
Yte_pr=[BWASDC_Yte,FTR_Yte,NNN_Yte,EBT_Yte,FKN_Yte];
Problem_figures(Ytr_pr,Ytr,Yte_pr,Yte,E,Em,A,N,R,x)
