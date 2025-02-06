%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COVID-19 chest X-ray detection through texture analysis using
% multi-colinearity diagnosis
% Antonio Quintero-Rincón code
% Collinearity diagnostics 
% input:  X-ray image matrix 
% output: Singular values + Conditional indices + variance-decomposition proportions
%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sValue,condIdx,VarDecomp]=mycollintest(X)

[numObs,numVars,colorinfo] = size(X); % X is the matrix data
if colorinfo ~= 0 
    X = im2gray(X);
end
% Scale columns to length 1:
colNormsX = sqrt(sum(X.^2));
colNormsX(colNormsX == 0) = 1; % Avoid divide by 0
XS = X./repmat(colNormsX,numObs,1); % Scaled X

% Compute SVD:
[~,S,V] = svd(XS,"econ");
sValue = diag(S);

% Compute condition indices:
sValue(sValue < eps) = eps; % Avoid divide by 0
condIdx = sValue(1)./sValue;

% Compute variance decomposition proportions:
PHI = (V.^2)./repmat((sValue.^2)',numVars,1);
phi = sum(PHI,2);
VarDecomp = PHI'./repmat(phi',numVars,1);
