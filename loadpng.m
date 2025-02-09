%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COVID-19 chest X-ray detection through texture analysis using
% multi-colinearity diagnosis
% Antonio Quintero-Rincón code
% You must put this .m file inside each folder that contains the png format images.
% input: Chest X-ray images in png format from the COVID-19 Radiography Database
% Output: Image save each Chest X-ray image, such as COVID-19, Normal, lungOpacity, and viralPneumonia  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc

f=dir('*.png');
files={f.name};
for k=1:numel(files)
  Image{k}=imread(files{k});
end

%noncovid       = Image;
covid           = Image;
%lungop         = Image;
%viralPneumonia = Image;

