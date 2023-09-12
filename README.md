# A bio-inspired WASD neural network for multiclass classification
Implementation of a 3-layer feed-forward neural network model that is trained using a bio-inspired weights-and-structure-determination for multiclass classification algorithm, termed BWASDC.\
The purpose of this package is to enhance the WASD algorithm's learning process with a bio-inspired optimization algorithm, called the beetle antennae search (BAS).\
The BWASDC's effectiveness is evaluated through applications in occupational classification systems, such as the O\*NET-SOC 2010 and ISCO-08.\
The main articles used are the followings:
*	R. Xu, B. Sun, C. Lin, T.E. Simos, S.D. Mourtas, V.N. Katsikis, D. Lagios, P. Zervas and G. Tzimas, "A bio-inspired weights and structure determination neural network for multiclass classification: Applications in occupational classification systems," (submitted)

Also, the kit includes the following four datasets:
*	ONETD, taken from https://www.onetcenter.org/dl_files/database/db_20_1_excel/Sample%20of%20Reported%20Titles.xlsx
*	ISCOD, taken from https://www.ilo.org/ilostat-files/ISCO/newdocs-08-2021/ISCO-08/ISCO-08\%20EN\%20Structure\%20and\%20definitions.xlsx
*	ONET-ISCO, taken from https://www.bls.gov/soc/ISCO_SOC_Crosswalk.xls
*	ISCO-ONET, taken from https://www.bls.gov/soc/ISCO_SOC_Crosswalk.xls

# M-files Description
*	Main_BWASDC.m: the main function
*	problem.m: input data of the neural networks
*	preprocessText.m: function for preprocessing data
*	problem_figures.m: figures illustrating the problem's findings
*	BWASDC.m: function for finding the optimal number of hidden-layer neurons, along with the optimal weights of the neural network
*	Kmatrix.m: function for calculating the matrix K
*	fitness.m: the objective function that must be minimized
*	predictN.m: function for WASD neural network model predictions
*	predictNN.m: function for MATLAB's neural network models predictions 
*	error_pred.m: function for calculating the mean absolute error (MAE) of the prediction
*	FTR.mat: MATLAB's fine Tree model 
*	FKN.mat: MATLAB's fine KNN model 
*	EBT.mat: MATLAB's Ensemble Bagged Trees model
*	NNN.mat: MATLAB's Narrow Neural Network model

Also, the kit includes the following two functions:
* kappa.m, taken from https://www.mathworks.com/matlabcentral/fileexchange/15365-cohen-s-kappa
* confusion.m, taken from https://www.mathworks.com/matlabcentral/fileexchange/60900-multi-class-confusion-matrix?s_tid=srchtitle

# Installation
*	Unzip the file you just downloaded and copy the WASDC directory to a location,e.g.,/my-directory/
*	Run Matlab/ Octave, Go to /my-directory/BWASDC/ at the command prompt
*	run 'Main_BWASDC (Matlab/Octave)

# Results
After running the 'Main_BWASDC.m file, the package outputs are the following:
*	The optimal number of hidden-layer neurons.
*	The neural network models' statistics on the testing set of the datasets.
*	The graphic illustration of the classification performance.

# Environment
The BWASDC kit has been tested in Matlab 2022a on OS: Windows 10 64-bit.
