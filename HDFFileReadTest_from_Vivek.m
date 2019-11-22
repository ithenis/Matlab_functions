% Test for reading in HDF file
clc
clear all
close all
fileName='';

%Parms.SamplingRes = h5readatt(FF,'/Acquisition/Attributes','Data Context.Lateral Resolution:Value');  
data.intensity = h5read(fileName,'/Acquisition/FrameBuffer');

avgIntensity=mean(data.intensity,3);

imagesc(avgIntensity)
axis equal