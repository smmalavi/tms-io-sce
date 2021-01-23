%==========================================================================
% In this file: Define and reset variable of stopping rule with T=5
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

% reset all parameters for both methods with T=5

no_of_runs_F_conv5_with_Peak=0;
MCsim_F_conv5_with_Peak=[];
theta_F_conv5_with_Peak=[];
iter_F_conv5_with_Peak=[];
     
no_of_runs_U_conv5_with_Peak=0;
MCsim_U_conv5_with_Peak=[];
theta_U_conv5_with_Peak=[];
iter_U_conv5_with_Peak=[];


no_of_runs_FandU_conv5_with_Peak=0;
MCsim_FandU_conv5_with_Peak=[];
theta_FandU_conv5_with_Peak=[];

no_of_runs_FandU_conv_eq5_with_Peak=0;
MCsim_FandU_conv_eq5_with_Peak=[];
theta_FandU_conv_eq5_with_Peak=[];

no_of_runs_F_conv_faster5_with_Peak=0;
MCsim_F_conv_faster5_with_Peak=[];
theta_F_conv_faster5_with_Peak=[];

no_of_runs_U_conv_faster5_with_Peak=0;
MCsim_U_conv_faster5_with_Peak=[];
theta_U_conv_faster5_with_Peak=[];

no_of_runs_F_force5_with_Peak=0;
MCsim_F_force5_with_Peak=[];
theta_F_force5_with_Peak=[];

no_of_runs_U_force5_with_Peak=0;
MCsim_U_force5_with_Peak=[];
theta_U_force5_with_Peak=[];

no_of_runs_FandU_force5_with_Peak=0;
MCsim_FandU_force5_with_Peak=[];
theta_FandU_force5_with_Peak=[];

er_theta1_F_conv5_with_Peak=[];
er_theta2_F_conv5_with_Peak=[];
er_theta3_F_conv5_with_Peak=[];
er_theta4_F_conv5_with_Peak=[];
            
er_theta1_U_whenFconv5_with_Peak=[];
er_theta2_U_whenFconv5_with_Peak=[];
er_theta3_U_whenFconv5_with_Peak=[];
er_theta4_U_whenFconv5_with_Peak=[];
            
e_logy_F_conv5_with_Peak=[];
e_logy_U_whenFconv5_with_Peak=[];
e_yprime_F_conv5_with_Peak=[];
e_yprime_U_whenFconv5_with_Peak=[];


iter_F_conv5_with_Peak=[];
iter_rtheta_converged_with_Peak=[];     
  
iter_rtheta_converged_comp5=[];
