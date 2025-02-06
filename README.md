# Computer-based-quantitative-image-texture-analysis-using-multi-collinearity-diagnosis-in-chest-X-ray
This MATLAB code is about COVID-19 detection in Chest X-ray images based in the paper "Computer-based quantitative image texture analysis using multi-collinearity diagnosis in chest X-ray images" published in PlosOne.
4 types of images from the "COVID-19 Radiography Database" are used. Each image folder can be loaded using the following code:
  f=dir('*.png');
  files={f.name};
  for k=1:numel(files)
    Im{k}=imread(files{k});
  end
For each image, the variable "Im" must be assigned:
normal, covid, lungOpacity, viralPneumonia = Im; 
You can generate two files: imagesCovidNormal.mat and imagesViralLung.mat

There two main files to run all: (1) mainMulticlass.m and (2) mainVarDecomposition.m. (1) in necesary to generate all variables and .mats to run (2).


