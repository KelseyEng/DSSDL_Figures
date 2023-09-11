%% Compact models and consolidate

clear all
close all
clc


load model_full_KS
mdlKS = compact(gprMdlKS);
clear gprMdlKS

load model_Zoomed_KS.mat gprMdlKSZoom yObsKSZoom xObsZoom
mdlKSzoom = compact(gprMdlKSZoom);
clear gprMdlKSZoom

load model_Zoomed2_KS.mat gprMdlKSZoom2 yObsKSZoom2 xObsZoom2
mdlKSzoom2 = compact(gprMdlKSZoom2);
clear gprMdlKSZoom2

save model_all
