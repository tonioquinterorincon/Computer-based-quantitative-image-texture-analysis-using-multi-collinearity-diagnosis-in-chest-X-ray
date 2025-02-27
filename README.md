# Computer-based-quantitative-image-texture-analysis-using-multi-collinearity-diagnosis-in-chest-X-ray
This MATLAB code is about COVID-19 detection in Chest X-ray images based on the paper "Computer-based quantitative image texture analysis using multi-collinearity diagnosis in chest X-ray images" published in PlosOne doi: 10.1371/journal.pone.0320706.
4 types of chest X-ray images from the "COVID-19 Radiography Database" are used: normal, COVID-19, lung opacity, and viral pneumonia. Each image folder can be loaded using the code loadpng.m. The variable "Image" must be assigned for each chest X-ray image group. With this process, you can generate two .mat files: imagesCovidNormal.mat and imagesViralLung.mat

There are two main files for the reproductivity of the paper: (1) mainMulticlass.m and (2) mainVarDecomposition.m. (1) it is necessary to generate all variables and .mats to run (2).


