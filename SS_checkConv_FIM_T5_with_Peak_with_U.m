%==========================================================================
% This file: ckeck convergence and compute errors between Uniform and SCE
%    methods for for T=5 
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


% Same comments as in SS_checkConv_compE_T1 apply 

if length(iter_rtheta_converged_with_Peak)~=0 && length(iter_rtheta_converged_comp5)~=0  
    
     er_theta1_F_conv5_with_Peak=[er_theta1_F_conv5_with_Peak er_theta1_F(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta2_F_conv5_with_Peak=[er_theta2_F_conv5_with_Peak er_theta2_F(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta3_F_conv5_with_Peak=[er_theta3_F_conv5_with_Peak er_theta3_F(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta4_F_conv5_with_Peak=[er_theta4_F_conv5_with_Peak er_theta4_F(MCsim,iter_rtheta_converged_with_Peak(1))];
            
            
     er_theta1_U_whenFconv5_with_Peak=[er_theta1_U_whenFconv5_with_Peak er_theta1_U(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta2_U_whenFconv5_with_Peak=[er_theta2_U_whenFconv5_with_Peak er_theta2_U(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta3_U_whenFconv5_with_Peak=[er_theta3_U_whenFconv5_with_Peak er_theta3_U(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta4_U_whenFconv5_with_Peak=[er_theta4_U_whenFconv5_with_Peak er_theta4_U(MCsim,iter_rtheta_converged_with_Peak(1))];
            
     e_logy_F_conv5_with_Peak=[e_logy_F_conv5_with_Peak log_ey_FIM(MCsim,iter_rtheta_converged_with_Peak(1))];
     e_logy_U_whenFconv5_with_Peak=[e_logy_U_whenFconv5_with_Peak log_ey_uniform(MCsim,iter_rtheta_converged_with_Peak(1))];
     e_yprime_F_conv5_with_Peak=[e_yprime_F_conv5_with_Peak eyprime_FIM(MCsim,iter_rtheta_converged_with_Peak(1))];
     e_yprime_U_whenFconv5_with_Peak=[e_yprime_U_whenFconv5_with_Peak eyprime_uniform(MCsim,iter_rtheta_converged_with_Peak(1))];
     
     no_of_runs_F_conv5_with_Peak=no_of_runs_F_conv5_with_Peak+1;
     MCsim_F_conv5_with_Peak=[MCsim_F_conv5_with_Peak MCsim];
     theta_F_conv5_with_Peak=[theta_F_conv5_with_Peak [theta_true;sigma_y;sigma_x]];
     iter_F_conv5_with_Peak=[iter_F_conv5_with_Peak iter_rtheta_converged_with_Peak(1)];
     
     no_of_runs_U_conv5_with_Peak=no_of_runs_U_conv5_with_Peak+1;
     MCsim_U_conv5_with_Peak=[MCsim_U_conv5_with_Peak MCsim];
     theta_U_conv5_with_Peak=[theta_U_conv5_with_Peak [theta_true;sigma_y;sigma_x]];
     iter_U_conv5_with_Peak=[iter_U_conv5_with_Peak iter_rtheta_converged_comp5(1)];
     
     no_of_runs_FandU_conv5_with_Peak=no_of_runs_FandU_conv5_with_Peak+1;
     MCsim_FandU_conv5_with_Peak=[MCsim_FandU_conv5_with_Peak MCsim];
     theta_FandU_conv5_with_Peak=[theta_FandU_conv5_with_Peak theta_true]; 
     
     if iter_rtheta_converged_with_Peak(1) == iter_rtheta_converged_comp5(1)
          no_of_runs_FandU_conv_eq5_with_Peak=no_of_runs_FandU_conv_eq5_with_Peak+1; 
          MCsim_FandU_conv_eq5_with_Peak=[MCsim_FandU_conv_eq5_with_Peak MCsim];
          theta_FandU_conv_eq5_with_Peak=[theta_FandU_conv_eq5_with_Peak [theta_true;sigma_y;sigma_x]];
     elseif iter_rtheta_converged_with_Peak(1) < iter_rtheta_converged_comp5(1)
          no_of_runs_F_conv_faster5_with_Peak=no_of_runs_F_conv_faster5_with_Peak+1;      
          MCsim_F_conv_faster5_with_Peak=[MCsim_F_conv_faster5_with_Peak MCsim];
          theta_F_conv_faster5_with_Peak=[theta_F_conv_faster5_with_Peak [theta_true;sigma_y;sigma_x]];
     else
          no_of_runs_U_conv_faster5_with_Peak=no_of_runs_U_conv_faster5_with_Peak+1;      
          MCsim_U_conv_faster5_with_Peak=[MCsim_U_conv_faster5_with_Peak MCsim];
          theta_U_conv_faster5_with_Peak=[theta_U_conv_faster5_with_Peak [theta_true;sigma_y;sigma_x]];
     end
     
 elseif length(iter_rtheta_converged_with_Peak)==0 && length(iter_rtheta_converged_comp5)==0
     
     
     er_theta1_F_conv5_with_Peak=[er_theta1_F_conv5_with_Peak nan];
     er_theta2_F_conv5_with_Peak=[er_theta2_F_conv5_with_Peak nan];
     er_theta3_F_conv5_with_Peak=[er_theta3_F_conv5_with_Peak nan];
     er_theta4_F_conv5_with_Peak=[er_theta4_F_conv5_with_Peak nan];
            
            
     er_theta1_U_whenFconv5_with_Peak=[er_theta1_U_whenFconv5_with_Peak nan];
     er_theta2_U_whenFconv5_with_Peak=[er_theta2_U_whenFconv5_with_Peak nan];
     er_theta3_U_whenFconv5_with_Peak=[er_theta3_U_whenFconv5_with_Peak nan];
     er_theta4_U_whenFconv5_with_Peak=[er_theta4_U_whenFconv5_with_Peak nan];
            
     e_logy_F_conv5_with_Peak=[e_logy_F_conv5_with_Peak nan];
     e_logy_U_whenFconv5_with_Peak=[e_logy_U_whenFconv5_with_Peak nan];
     e_yprime_F_conv5_with_Peak=[e_yprime_F_conv5_with_Peak nan];
     e_yprime_U_whenFconv5_with_Peak=[e_yprime_U_whenFconv5_with_Peak nan];
        
         
     
     no_of_runs_F_force5_with_Peak=no_of_runs_F_force5_with_Peak+1;
     MCsim_F_force5_with_Peak=[MCsim_F_force5_with_Peak MCsim];
     theta_F_force5_with_Peak=[theta_F_force5_with_Peak [theta_true;sigma_y;sigma_x]];
     
     no_of_runs_U_force5_with_Peak=no_of_runs_U_force5_with_Peak+1;
     MCsim_U_force5_with_Peak=[MCsim_U_force5_with_Peak MCsim];
     theta_U_force5_with_Peak=[theta_U_force5_with_Peak [theta_true;sigma_y;sigma_x]];
     
     no_of_runs_FandU_force5_with_Peak=no_of_runs_FandU_force5_with_Peak+1;
     MCsim_FandU_force5_with_Peak=[MCsim_FandU_force5_with_Peak MCsim];
     theta_FandU_force5_with_Peak=[theta_FandU_force5_with_Peak [theta_true;sigma_y;sigma_x]];
     
      % other data
     iter_F_conv5_with_Peak=[iter_F_conv5_with_Peak nan];
     iter_U_conv5_with_Peak=[iter_U_conv5_with_Peak nan];
     
     
 elseif length(iter_rtheta_converged_with_Peak)~=0 && length(iter_rtheta_converged_comp5)==0
 
    
     
     er_theta1_F_conv5_with_Peak=[er_theta1_F_conv5_with_Peak er_theta1_F(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta2_F_conv5_with_Peak=[er_theta2_F_conv5_with_Peak er_theta2_F(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta3_F_conv5_with_Peak=[er_theta3_F_conv5_with_Peak er_theta3_F(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta4_F_conv5_with_Peak=[er_theta4_F_conv5_with_Peak er_theta4_F(MCsim,iter_rtheta_converged_with_Peak(1))];
            
            
     er_theta1_U_whenFconv5_with_Peak=[er_theta1_U_whenFconv5_with_Peak er_theta1_U(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta2_U_whenFconv5_with_Peak=[er_theta2_U_whenFconv5_with_Peak er_theta2_U(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta3_U_whenFconv5_with_Peak=[er_theta3_U_whenFconv5_with_Peak er_theta3_U(MCsim,iter_rtheta_converged_with_Peak(1))];
     er_theta4_U_whenFconv5_with_Peak=[er_theta4_U_whenFconv5_with_Peak er_theta4_U(MCsim,iter_rtheta_converged_with_Peak(1))];
            
     e_logy_F_conv5_with_Peak=[e_logy_F_conv5_with_Peak log_ey_FIM(MCsim,iter_rtheta_converged_with_Peak(1))];
     e_logy_U_whenFconv5_with_Peak=[e_logy_U_whenFconv5_with_Peak log_ey_uniform(MCsim,iter_rtheta_converged_with_Peak(1))];
     e_yprime_F_conv5_with_Peak=[e_yprime_F_conv5_with_Peak eyprime_FIM(MCsim,iter_rtheta_converged_with_Peak(1))];
     e_yprime_U_whenFconv5_with_Peak=[e_yprime_U_whenFconv5_with_Peak eyprime_uniform(MCsim,iter_rtheta_converged_with_Peak(1))];
     
           
     no_of_runs_F_conv5_with_Peak=no_of_runs_F_conv5_with_Peak+1;
     MCsim_F_conv5_with_Peak=[MCsim_F_conv5_with_Peak MCsim];
     theta_F_conv5_with_Peak=[theta_F_conv5_with_Peak [theta_true;sigma_y;sigma_x]];
     iter_F_conv5_with_Peak=[iter_F_conv5_with_Peak iter_rtheta_converged_with_Peak(1)];
     
     no_of_runs_U_force5_with_Peak=no_of_runs_U_force5_with_Peak+1;
     MCsim_U_force5_with_Peak=[MCsim_U_force5_with_Peak MCsim];
     theta_U_force5_with_Peak=[theta_U_force5_with_Peak [theta_true;sigma_y;sigma_x]];
     
     no_of_runs_F_conv_faster5_with_Peak=no_of_runs_F_conv_faster5_with_Peak+1;      
     MCsim_F_conv_faster5_with_Peak=[MCsim_F_conv_faster5_with_Peak MCsim];
     theta_F_conv_faster5_with_Peak=[theta_F_conv_faster5_with_Peak [theta_true;sigma_y;sigma_x]];
     
      % other data
     %iter_F_conv1=[iter_F_conv1 nan];
     iter_U_conv5_with_Peak=[iter_U_conv5_with_Peak nan];
     
 elseif length(iter_rtheta_converged_with_Peak)==0 && length(iter_rtheta_converged_comp5)~=0
 
     
     er_theta1_F_conv5_with_Peak=[er_theta1_F_conv5_with_Peak nan];
     er_theta2_F_conv5_with_Peak=[er_theta2_F_conv5_with_Peak nan];
     er_theta3_F_conv5_with_Peak=[er_theta3_F_conv5_with_Peak nan];
     er_theta4_F_conv5_with_Peak=[er_theta4_F_conv5_with_Peak nan];
            
            
     er_theta1_U_whenFconv5_with_Peak=[er_theta1_U_whenFconv5_with_Peak nan];
     er_theta2_U_whenFconv5_with_Peak=[er_theta2_U_whenFconv5_with_Peak nan];
     er_theta3_U_whenFconv5_with_Peak=[er_theta3_U_whenFconv5_with_Peak nan];
     er_theta4_U_whenFconv5_with_Peak=[er_theta4_U_whenFconv5_with_Peak nan];
            
     e_logy_F_conv5_with_Peak=[e_logy_F_conv5_with_Peak nan];
     e_logy_U_whenFconv5_with_Peak=[e_logy_U_whenFconv5_with_Peak nan];
     e_yprime_F_conv5_with_Peak=[e_yprime_F_conv5_with_Peak nan];
     e_yprime_U_whenFconv5_with_Peak=[e_yprime_U_whenFconv5_with_Peak nan];
     
           
     no_of_runs_F_force5_with_Peak=no_of_runs_F_force5_with_Peak+1;
     MCsim_F_force5_with_Peak=[MCsim_F_force5_with_Peak MCsim];
     theta_F_force5_with_Peak=[theta_F_force5_with_Peak [theta_true;sigma_y;sigma_x]];
     
     no_of_runs_U_conv5_with_Peak=no_of_runs_U_conv5_with_Peak+1; 
     MCsim_U_conv5_with_Peak=[MCsim_U_conv5_with_Peak MCsim];
     theta_U_conv5_with_Peak=[theta_U_conv5_with_Peak [theta_true;sigma_y;sigma_x]];
     iter_U_conv5_with_Peak=[iter_U_conv5_with_Peak iter_rtheta_converged_comp5(1)];
     
     
     no_of_runs_U_conv_faster5_with_Peak=no_of_runs_U_conv_faster5_with_Peak+1;
     MCsim_U_conv_faster5_with_Peak=[MCsim_U_conv_faster5_with_Peak MCsim];
     theta_U_conv_faster5_with_Peak=[theta_U_conv_faster5_with_Peak [theta_true;sigma_y;sigma_x]];
 
      % other data
     iter_F_conv5_with_Peak=[iter_F_conv5_with_Peak nan];
     %iter_U_conv1=[iter_U_conv1 nan];
     
 end
        
 