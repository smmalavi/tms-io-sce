%==========================================================================
% This is the >>  Main  << file for simulation of several folders, multiple
%   runs in each folder. 
%   For instance, if 100 runs is the goal, you can run 10 times, 
%   10 runs each time, and save the results in 10 folders.
%========================================================================== 
%
% Matlab Code: 
%  Optimal Sampling Fundamentals for Input-Output Slope Curve Estimation 
%         in Noninvasive Brain Stimulation
%
% Seyed Mohammad Mahdi Alavi+, Stefan M. Goetz, Mehrdad Saif
%
%
% S.M.M. Alavi is with the Department of Applied Computing and Engineering,
%         School of Technologies, Cardiff Metropolitan University,
%         Llandaff Campus, Western Avenue, Cardiff, UK, CF5 2YB. 
%         e-mail: mahdi.alavi.work@gmail.com
%
% S.M. Goetz is with the Departments of Psychiatry and Behavioral Sciences,
%         and Electrical and Computer Engineering, and Neurosurgery
%         as well as with the Brain Initiative,
%         Duke University, Durham, NC 27708, USA,
%         and with the Department of Engineering,
%         University of Cambridge, Cambridge CB2 1PZ, UK. 
%          e-mail: stefan.goetz@duke.edu; smg84@cam.ac.uk
%
% M. Saif is with the Department of Electrical Engineering, 
%         University of Windsor, Windsor, ON, Canada N9B 3P4.
%         e-mail: msaif@uwindsor.ca
%
%  +: code written by
% ++: corresponding author
%
% January 2021
%==========================================================================

close all
clear all

Total_runs=2;% in each folder
Nmax=200;% maximum number of pluse for each run
nxeq0=20;%numebr of baseline for each run

for kkk=1:2 % number of folders: total runs=number of folder*total_runs
   close all;
   parent_folder=['results_F' num2str(kkk)];
   mkdir(parent_folder);
   main_singleFolder_run;
end

main_multiFolder_data_analysis;