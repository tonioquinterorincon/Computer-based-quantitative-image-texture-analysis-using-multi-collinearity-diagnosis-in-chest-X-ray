%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COVID-19 chest X-ray detection through texture analysis using
% multi-colinearity diagnosis
% Antonio Quintero-Rincón code
% Collinearity diagnostics 
% input:  VarDecomp: numVars-by-numVars array of variance-decomposition proportions.
% output: Table with singular values and conditional indices scaled by
% tuning weight omega
%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath mats\
load ('VarDecompositions.mat');
weightsnormal= VarDecomposition(CLM_ncovid_VarDecomp);
weightscovids= VarDecomposition(CLM_covid_VarDecomp);
weightspneumo= VarDecomposition(CLM_viralPneumonia_VarDecomp);
weightslungop= VarDecomposition(CLM_lungop_VarDecomp);
save('weightsVarDec.mat')

% load singular values and conditional indices data to compute the
% Coefficient of variation based on the minimum covariance determinant
load("MultiDataCollintest.mat");
clear CLM* T* covid lungop noncovid viralPneumonia

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coefficient of variation (cv) based on the minimum covariance determinant
[sigc,muc] = robustcov(weightscovids);
[sign,mun] = robustcov(weightsnormal);
[sigp,mup] = robustcov(weightspneumo);
[sigl,mul] = robustcov(weightslungop);

cvwcovids= sigc./muc;
cvwnormal= sign./mun;
cvwpneumo= sigp./mup;
cvwlingop= sigl./mul;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Table classifier: singular values and conditional indices are scale by 
% the tunign weight omega (cv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T1 = table;
T1 = table;
T2 = table;
T3 = table;
T4 = table;
T1.svd = sort(cell2mat(cat(1,sValueCovid(:))).*cvwcovids);
T2.svd = sort(cell2mat(cat(1,sValueNonCovid(:))).*cvwnormal);
T3.svd = sort(cell2mat(cat(1,sValuePneumo(:))).*cvwpneumo);
T4.svd = sort(cell2mat(cat(1,sValueLungOp(:))).*cvwlingop);

T1.idx = sort(cell2mat(cat(1,condIdxCovid(:))).*cvwcovids);
T2.idx = sort(cell2mat(cat(1,condIdxNonCovid(:))).*cvwnormal);
T3.idx = sort(cell2mat(cat(1,condIdxPneumo(:))).*cvwpneumo);
T4.idx = sort(cell2mat(cat(1,condIdxLungOp(:))).*cvwlingop);

T1.labels = ones(size(T1.svd));   % covids
T2.labels = zeros(size(T2.svd));  % normal
T3.labels = 2*ones(size(T3.svd)); % pneumo
T4.labels = 3*ones(size(T4.svd)); % lungop
% 
Tcvr= vertcat(T1,T2,T3,T4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('MultiDataCollintestWeights.mat')
%svd
fprintf("mean & %f & %f & %f & %f]\n",mean(T1.svd),mean(T2.svd),...
    mean(T3.svd),mean(T4.svd))
fprintf("std & %f & %f & %f & %f \n",std(T1.svd),std(T2.svd),...
    std(T3.svd),std(T4.svd))
fprintf("Bounds & [%f,%f]&[%f,%f]&[%f,%f]&[%f,%f]  \n",...
    min(T1.svd),max(T1.svd),min(T2.svd),max(T2.svd),...
    min(T3.svd),max(T3.svd),min(T4.svd),max(T4.svd));
%idx
fprintf("mean & %f & %f & %f & %f\n",mean(T1.idx),mean(T2.idx),...
    mean(T3.idx),mean(T4.idx))
fprintf("std & %f & %f & %f & %f \n",std(T1.idx),std(T2.idx),...
    std(T3.idx),std(T4.idx))
fprintf("Bounds & [%f,%f]&[%f,%f]&[%f,%f]&[%f,%f]  \n",...
    min(T1.idx),max(T1.idx),min(T2.idx),max(T2.idx),...
    min(T3.idx),max(T3.idx),min(T4.idx),max(T4.idx))




