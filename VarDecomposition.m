%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COVID-19 chest X-ray detection through texture analysis using
% multi-colinearity diagnosis
% Antonio Quintero-Rincón code
% Collinearity diagnostics 
% input:  VarDecomp: numVars-by-numVars array of variance-decomposition proportions.
% output: weightsband: smoothing parameters from the non-parametric empirical distribution
%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function weightsband = VarDecomposition(vdp)
for i=1:numel(vdp)
    positionsdisease{i}   = find(vdp{1,i}>0.5);
    values_disease{i}     = vdp{1,i}(positionsdisease{1,i});
    countC(i)             = numel(positionsdisease{i});
end
fprintf("VarDecomposition Values \n")
fprintf("mean: %i, \n",mean(cell2mat(cat(1,values_disease(:)))));
fprintf("std:  %i \n",std(cell2mat(cat(1,values_disease(:)))));
fprintf("Amount \n")
fprintf("mean: %i,\n",round(mean(countC(:))));
fprintf("std: %i, \n",round(std(countC(:))));
fprintf("[min,max]: %i, \n",min(countC(:)),max(countC(:)));  

for i=1:numel(values_disease)
    if( isempty(values_disease{1,i}) )
        values_disease{1,i} = [0.1 0.1 0.1 0.1 0.1]';
    end
    pd = fitdist(values_disease{1,i},'kernel','kernel','normal','support','positive');
    weightsbanddisease(i)= pd.Bandwidth;
    % fprintf("%d\n",i)
end
fprintf("Non-Parametric distribution \n")
fprintf("mean weightsband %f \n",mean(weightsbanddisease));
fprintf("std weightsband %f \n",std(weightsbanddisease));
fprintf("[min, max] weightsband [%f, %f] \n",min(weightsbanddisease(:)),max(weightsbanddisease(:)));
weightsband = weightsbanddisease;
end


