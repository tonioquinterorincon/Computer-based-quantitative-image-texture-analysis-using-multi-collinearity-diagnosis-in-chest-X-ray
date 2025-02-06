%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COVID-19 chest X-ray detection through texture analysis using
% multi-colinearity diagnosis
% Antonio Quintero-Rincón code
% input:X-ray images
% Output: Table with singular values and conditional indices without the 
% tuning weight omega
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc
addpath mats\

%
%load COVID-19 and nonCOVID-19 chest images
load('imagesCovidNormal.mat');
%load Viral and Lung Opacity chest images
load('imagesViralLung.mat');

% Collinearity diagnostics 
% input:     matrix X
% output:
%   sValue:    Vector of singular values of the scaled design matrix X
%   condIdx:   Vector of condition indices sValue(1)/sValue(j)
%   VarDecomp: numVars-by-numVars array of variance-decomposition proportions.

parfor i=1:numel(covid)
    [sValue,condIdx,VarDecomp] = mycollintest(im2double(covid{1,i}));
    CLM_covid_sValue{i}        = sValue;
    CLM_covid_condIdx{i}       = condIdx;
    CLM_covid_VarDecomp{i}     = VarDecomp;
    fprintf("image-covid:%i",i)
end
%save("allcovid.mat")

parfor i=1:numel(noncovid)
    [sValue,condIdx,VarDecomp] = mycollintest(im2double(noncovid{1,i}));
    CLM_ncovid_sValue{i}       = sValue;
    CLM_ncovid_condIdx{i}      = condIdx;
    CLM_ncovid_VarDecomp{i}    = VarDecomp;
    fprintf("image-noncovid:%i",i)
end
%save("allnoncovid.mat")

for i=1:length(viralPneumonia)
    [sValue,condIdx,VarDecomp] = mycollintest(im2double(viralPneumonia{1,i}));
    CLM_viralPneumonia_sValue{i}    = sValue;
    CLM_viralPneumonia_condIdx{i}   = condIdx;
    CLM_viralPneumonia_VarDecomp{i} = VarDecomp;
    fprintf("image-viral:%i",i)
end
%save("allviral.mat")

parfor i=1:length(lungop)
    [sValue,condIdx,VarDecomp] = mycollintest(im2double(lungop{1,i}));
    CLM_lungop_sValue{i}    = sValue;
    CLM_lungop_condIdx{i}   = condIdx;
    CLM_lungop_VarDecomp{i} = VarDecomp;
    fprintf("image-lungop:%i",i)
end
%save("alllungop.mat")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Only the 5 most representative values of svd (sValue) and conIdx are used
% conIdx values are sorted in descent form
for i=1:numel(CLM_covid_sValue)
    sValueCovid{i}   = CLM_covid_sValue{1,i}(1:5);
    Idxsortedc       = sort(CLM_covid_condIdx{1,i});
    condIdxCovid{i}  = Idxsortedc(1:5);
end
for i=1:numel(CLM_ncovid_sValue)
    sValueNonCovid{i}  = CLM_ncovid_sValue{1,i}(1:5);
    Idxsortednc        = sort(CLM_ncovid_condIdx{1,i});
    condIdxNonCovid{i} = Idxsortednc(1:5);
end

for i=1:numel(CLM_viralPneumonia_sValue)
    sValuePneumo{i}  = CLM_viralPneumonia_sValue{1,i}(1:5);
    Idxsortedc       = sort(CLM_viralPneumonia_condIdx{1,i});
    condIdxPneumo{i} = Idxsortedc(1:5);
end

for i=1:numel(CLM_lungop_sValue)
    sValueLungOp{i}  = CLM_lungop_sValue{1,i}(1:5);
    Idxsortedc       = sort(CLM_lungop_condIdx{1,i});
    condIdxLungOp{i} = Idxsortedc(1:5);
end
%save("data2Table.mat")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Table classifier: only uses the singular values and the conditional
% indices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T1 = table;
T2 = table;
T3 = table;
T4 = table;

T1.svd = sort(cell2mat(cat(1,sValueCovid(:))));
T2.svd = sort(cell2mat(cat(1,sValueNonCovid(:))));
T3.svd = sort(cell2mat(cat(1,sValuePneumo(:))));
T4.svd = sort(cell2mat(cat(1,sValueLungOp(:))));

T1.idx = sort(cell2mat(cat(1,condIdxCovid(:))));
T2.idx = sort(cell2mat(cat(1,condIdxNonCovid(:))));
T3.idx = sort(cell2mat(cat(1,condIdxPneumo(:))));
T4.idx = sort(cell2mat(cat(1,condIdxLungOp(:))));

T1.labels = ones(size(T1.svd));
T2.labels = zeros(size(T2.svd));
T3.labels = 2*ones(size(T3.svd));
T4.labels = 3*ones(size(T4.svd));
% 
T= vertcat(T1,T2,T3,T4);
 
save('MultiDataCollintest.mat')
