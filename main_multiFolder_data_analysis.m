%==========================================================================
% This is the >>  Main  << file for data anlysis of multi-folder runs
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

SS_combine_resetPars;


for i=1:kkk
    
    FileName   = ['test' num2str(Total_runs) '.mat'];
    FolderName = ['results_F' num2str(i)];
    File       = fullfile(FolderName, FileName);
    load(File);
    
    SS_Combine_data;
end

mean_total_e_x_yprime_max_F_T5=nanmean(total_e_x_yprime_max_F_T5)
mean_total_e_x_yprime_max_F_T5_with_Peak=nanmean(total_e_x_yprime_max_F_T5_with_Peak)
mean_total_e_x_yprime_max_U_T5=nanmean(total_e_x_yprime_max_U_T5)
mean_total_e_x_yprime_max_U_T5_with_Peak=nanmean(total_e_x_yprime_max_U_T5_with_Peak)


mean_total_e_yprime_max_F_T5=nanmean(total_e_yprime_max_F_T5)
mean_total_e_yprime_max_F_T5_with_Peak=nanmean(total_e_yprime_max_F_T5_with_Peak)
mean_total_e_yprime_max_U_T5=nanmean(total_e_yprime_max_U_T5)
mean_total_e_yprime_max_U_T5_with_Peak=nanmean(total_e_yprime_max_U_T5_with_Peak)


mean_total_e_y_yprime_max_F_T5=nanmean(total_e_y_yprime_max_F_T5)
mean_total_e_y_yprime_max_F_T5_with_Peak=nanmean(total_e_y_yprime_max_F_T5_with_Peak)
mean_total_e_y_yprime_max_U_T5=nanmean(total_e_y_yprime_max_U_T5)
mean_total_e_y_yprime_max_U_T5_with_Peak=nanmean(total_e_y_yprime_max_U_T5_with_Peak)


%%
total_no_of_runs_Fconv_T5=total_no_of_runs_Fconv_T5
mean_total_nf_F_T5=ceil(nanmean(total_nf_F_T5))

total_no_of_runs_Fconv_T5_with_Peak=total_no_of_runs_Fconv_T5_with_Peak
mean_total_nf_F_T5_with_Peak=ceil(nanmean(total_nf_F_T5_with_Peak))

%%
total_no_of_runs_Uconv_T5=total_no_of_runs_Uconv_T5
mean_total_nf_Uconv_T5=ceil(nanmean(total_nf_Uconv_T5))



save([ 'test_total_' num2str(length(total_theta_true_all_runs)) 'runs.mat' ]);

PaperFig_Error_thetas_linear;
PaperFig_Error_x_max_lin;
PaperFig_nf_all_methods;
PaperFig_Data_Distributions;