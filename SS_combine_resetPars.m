%==========================================================================
% This file: data initialization of multiple folders runs
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


%% When FIM converge at T5

total_er_t1_F_T5=[];
total_er_t2_F_T5=[];
total_er_t3_F_T5=[];
total_er_t4_F_T5=[];
            
            
total_er_t1_U_whenFconv_T5=[];
total_er_t2_U_whenFconv_T5=[];
total_er_t3_U_whenFconv_T5=[];
total_er_t4_U_whenFconv_T5=[];

total_e_logy_F_T5=[];
total_e_logy_U_whenFconv_T5=[];

total_e_x_yprime_max_F_T5=[];
total_e_x_yprime_max_U_T5=[];

total_e_yprime_max_F_T5=[];
total_e_yprime_max_U_T5=[];

total_e_y_yprime_max_F_T5=[];
total_e_y_yprime_max_U_T5=[];

total_no_of_runs_Fconv_T5=0;
total_nf_F_T5=[];


%% When FIM converge at T5+Peak


total_er_t1_F_T5_with_Peak=[];
total_er_t2_F_T5_with_Peak=[];
total_er_t3_F_T5_with_Peak=[];
total_er_t4_F_T5_with_Peak=[];
            
            
total_er_t1_U_whenFconv_T5_with_Peak=[];
total_er_t2_U_whenFconv_T5_with_Peak=[];
total_er_t3_U_whenFconv_T5_with_Peak=[];
total_er_t4_U_whenFconv_T5_with_Peak=[];

total_e_logy_F_T5_with_Peak=[];
total_e_logy_U_whenFconv_T5_with_Peak=[];

total_e_x_yprime_max_F_T5_with_Peak=[];
total_e_x_yprime_max_U_T5_with_Peak=[];

total_e_yprime_max_F_T5_with_Peak=[];
total_e_yprime_max_U_T5_with_Peak=[];

total_e_y_yprime_max_F_T5_with_Peak=[];
total_e_y_yprime_max_U_T5_with_Peak=[];

total_no_of_runs_Fconv_T5_with_Peak=0;
total_nf_F_T5_with_Peak=[];
     
total_no_of_runs_Uconv_T5=0;
total_nf_Uconv_T5=[];

%%
total_theta_true_all_runs=[];
         