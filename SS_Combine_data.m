%==========================================================================
% This file: combine data of multiple folders
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


%% when FIM-SPE conve at T5

total_er_t1_F_T5=[total_er_t1_F_T5 er_theta1_F_conv5];
total_er_t2_F_T5=[total_er_t2_F_T5 er_theta2_F_conv5];
total_er_t3_F_T5=[total_er_t3_F_T5 er_theta3_F_conv5];
total_er_t4_F_T5=[total_er_t4_F_T5 er_theta4_F_conv5];
            
            
total_er_t1_U_whenFconv_T5=[total_er_t1_U_whenFconv_T5 er_theta1_U_whenFconv5];
total_er_t2_U_whenFconv_T5=[total_er_t2_U_whenFconv_T5 er_theta2_U_whenFconv5];
total_er_t3_U_whenFconv_T5=[total_er_t3_U_whenFconv_T5 er_theta3_U_whenFconv5];
total_er_t4_U_whenFconv_T5=[total_er_t4_U_whenFconv_T5 er_theta4_U_whenFconv5];
            
total_e_logy_F_T5=[total_e_logy_F_T5 e_logy_F_conv5];
total_e_logy_U_whenFconv_T5=[total_e_logy_U_whenFconv_T5 e_logy_U_whenFconv5];

total_e_x_yprime_max_F_T5=[total_e_x_yprime_max_F_T5 e_x_yprime_max_FIM_T5./abs(x_yprime_max_true)];
total_e_x_yprime_max_U_T5=[total_e_x_yprime_max_U_T5 e_x_yprime_max_uni_T5./abs(x_yprime_max_true)];

total_e_yprime_max_F_T5=[total_e_yprime_max_F_T5 e_yprime_max_FIM_T5./abs(yprime_max_true)];
total_e_yprime_max_U_T5=[total_e_yprime_max_U_T5 e_yprime_max_uni_T5./abs(yprime_max_true)];
   
total_e_y_yprime_max_F_T5=[total_e_y_yprime_max_F_T5 e_y_yprime_max_FIM_T5./abs(y_yprime_max_true)];
total_e_y_yprime_max_U_T5=[total_e_y_yprime_max_U_T5 e_y_yprime_max_uni_T5./abs(y_yprime_max_true)];

total_no_of_runs_Fconv_T5=total_no_of_runs_Fconv_T5+no_of_runs_F_conv5;
total_nf_F_T5=[total_nf_F_T5 iter_F_conv5];
     
total_no_of_runs_Uconv_T5=total_no_of_runs_Uconv_T5+no_of_runs_U_conv5;
total_nf_Uconv_T5=[total_nf_Uconv_T5 iter_U_conv5];

%% when FIM-SPE conve at T5+Peak


total_er_t1_F_T5_with_Peak=[total_er_t1_F_T5_with_Peak er_theta1_F_conv5_with_Peak];
total_er_t2_F_T5_with_Peak=[total_er_t2_F_T5_with_Peak er_theta2_F_conv5_with_Peak];
total_er_t3_F_T5_with_Peak=[total_er_t3_F_T5_with_Peak er_theta3_F_conv5_with_Peak];
total_er_t4_F_T5_with_Peak=[total_er_t4_F_T5_with_Peak er_theta4_F_conv5_with_Peak];
            
            
total_er_t1_U_whenFconv_T5_with_Peak=[total_er_t1_U_whenFconv_T5_with_Peak er_theta1_U_whenFconv5_with_Peak];
total_er_t2_U_whenFconv_T5_with_Peak=[total_er_t2_U_whenFconv_T5_with_Peak er_theta2_U_whenFconv5_with_Peak];
total_er_t3_U_whenFconv_T5_with_Peak=[total_er_t3_U_whenFconv_T5_with_Peak er_theta3_U_whenFconv5_with_Peak];
total_er_t4_U_whenFconv_T5_with_Peak=[total_er_t4_U_whenFconv_T5_with_Peak er_theta4_U_whenFconv5_with_Peak];
            
total_e_logy_F_T5_with_Peak=[total_e_logy_F_T5_with_Peak e_logy_F_conv5_with_Peak];
total_e_logy_U_whenFconv_T5_with_Peak=[total_e_logy_U_whenFconv_T5_with_Peak e_logy_U_whenFconv5_with_Peak];

total_e_x_yprime_max_F_T5_with_Peak=[total_e_x_yprime_max_F_T5_with_Peak e_x_yprime_max_FIM_T5_with_Peak./abs(x_yprime_max_true)];
total_e_x_yprime_max_U_T5_with_Peak=[total_e_x_yprime_max_U_T5_with_Peak e_x_yprime_max_uni_T5_with_Peak./abs(x_yprime_max_true)];

total_e_yprime_max_F_T5_with_Peak=[total_e_yprime_max_F_T5_with_Peak e_yprime_max_FIM_T5_with_Peak./abs(yprime_max_true)];
total_e_yprime_max_U_T5_with_Peak=[total_e_yprime_max_U_T5_with_Peak e_yprime_max_uni_T5_with_Peak./abs(yprime_max_true)];
   
total_e_y_yprime_max_F_T5_with_Peak=[total_e_y_yprime_max_F_T5_with_Peak e_y_yprime_max_FIM_T5_with_Peak./abs(y_yprime_max_true)];
total_e_y_yprime_max_U_T5_with_Peak=[total_e_y_yprime_max_U_T5_with_Peak e_y_yprime_max_uni_T5_with_Peak./abs(y_yprime_max_true)];

total_no_of_runs_Fconv_T5_with_Peak=total_no_of_runs_Fconv_T5_with_Peak+no_of_runs_F_conv5_with_Peak;
total_nf_F_T5_with_Peak=[total_nf_F_T5_with_Peak iter_F_conv5_with_Peak];


%% Total theta true of all runs

total_theta_true_all_runs=[total_theta_true_all_runs;[total_theta_true [total_sigma_x;total_sigma_y]']];
