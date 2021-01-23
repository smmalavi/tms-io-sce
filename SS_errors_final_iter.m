%==========================================================================
% This file: compute errors at final iteration for T=5
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

% compute error at the end itertaion 


if length(iter_rtheta_converged5)~=0 && length(iter_rtheta_converged_comp5)~=0  
     n_plot(MCsim)=max(iter_rtheta_converged5(1),iter_rtheta_converged_comp5(1)) ;
     final_iter(MCsim)=max(iter_rtheta_converged5(1),iter_rtheta_converged_comp5(1));
     
    
            er_theta1_F_final_iter=[er_theta1_F_final_iter er_theta1_F(MCsim,final_iter(MCsim))];
            er_theta2_F_final_iter=[er_theta2_F_final_iter er_theta2_F(MCsim,final_iter(MCsim))];
            er_theta3_F_final_iter=[er_theta3_F_final_iter er_theta3_F(MCsim,final_iter(MCsim))];
            er_theta4_F_final_iter=[er_theta4_F_final_iter er_theta4_F(MCsim,final_iter(MCsim))];
            
            er_theta1_U_final_iter=[er_theta1_U_final_iter er_theta1_U(MCsim,final_iter(MCsim))];
            er_theta2_U_final_iter=[er_theta2_U_final_iter er_theta2_U(MCsim,final_iter(MCsim))];
            er_theta3_U_final_iter=[er_theta3_U_final_iter er_theta3_U(MCsim,final_iter(MCsim))];
            er_theta4_U_final_iter=[er_theta4_U_final_iter er_theta4_U(MCsim,final_iter(MCsim))];

            
            e_logy_F_final_iter=[e_logy_F_final_iter log_ey_FIM(MCsim,final_iter(MCsim))];
            e_logy_U_final_iter=[e_logy_U_final_iter log_ey_uniform(MCsim,final_iter(MCsim))];
     
     
     
 elseif length(iter_rtheta_converged5)==0 && length(iter_rtheta_converged_comp5)==0
     
     n_plot(MCsim)=total_no_iterations;
     final_iter(MCsim)=total_no_iterations;
     
            er_theta1_F_final_iter=[er_theta1_F_final_iter er_theta1_F(MCsim,final_iter(MCsim))];
            er_theta2_F_final_iter=[er_theta2_F_final_iter er_theta2_F(MCsim,final_iter(MCsim))];
            er_theta3_F_final_iter=[er_theta3_F_final_iter er_theta3_F(MCsim,final_iter(MCsim))];
            er_theta4_F_final_iter=[er_theta4_F_final_iter er_theta4_F(MCsim,final_iter(MCsim))];
            
            er_theta1_U_final_iter=[er_theta1_U_final_iter er_theta1_U(MCsim,final_iter(MCsim))];
            er_theta2_U_final_iter=[er_theta2_U_final_iter er_theta2_U(MCsim,final_iter(MCsim))];
            er_theta3_U_final_iter=[er_theta3_U_final_iter er_theta3_U(MCsim,final_iter(MCsim))];
            er_theta4_U_final_iter=[er_theta4_U_final_iter er_theta4_U(MCsim,final_iter(MCsim))];

            
            e_logy_F_final_iter=[e_logy_F_final_iter log_ey_FIM(MCsim,final_iter(MCsim))];
            e_logy_U_final_iter=[e_logy_U_final_iter log_ey_uniform(MCsim,final_iter(MCsim))];
     
     
   
     
 elseif length(iter_rtheta_converged5)~=0 && length(iter_rtheta_converged_comp5)==0
 
     n_plot(MCsim)=total_no_iterations;
     final_iter(MCsim)=total_no_iterations;
     
            er_theta1_F_final_iter=[er_theta1_F_final_iter er_theta1_F(MCsim,final_iter(MCsim))];
            er_theta2_F_final_iter=[er_theta2_F_final_iter er_theta2_F(MCsim,final_iter(MCsim))];
            er_theta3_F_final_iter=[er_theta3_F_final_iter er_theta3_F(MCsim,final_iter(MCsim))];
            er_theta4_F_final_iter=[er_theta4_F_final_iter er_theta4_F(MCsim,final_iter(MCsim))];
            
            er_theta1_U_final_iter=[er_theta1_U_final_iter er_theta1_U(MCsim,final_iter(MCsim))];
            er_theta2_U_final_iter=[er_theta2_U_final_iter er_theta2_U(MCsim,final_iter(MCsim))];
            er_theta3_U_final_iter=[er_theta3_U_final_iter er_theta3_U(MCsim,final_iter(MCsim))];
            er_theta4_U_final_iter=[er_theta4_U_final_iter er_theta4_U(MCsim,final_iter(MCsim))];

            
            e_logy_F_final_iter=[e_logy_F_final_iter log_ey_FIM(MCsim,final_iter(MCsim))];
            e_logy_U_final_iter=[e_logy_U_final_iter log_ey_uniform(MCsim,final_iter(MCsim))];
     
     
     
 elseif length(iter_rtheta_converged5)==0 && length(iter_rtheta_converged_comp5)~=0
 
     n_plot(MCsim)=total_no_iterations;
     final_iter(MCsim)=total_no_iterations;
     
     
             er_theta1_F_final_iter=[er_theta1_F_final_iter er_theta1_F(MCsim,final_iter(MCsim))];
            er_theta2_F_final_iter=[er_theta2_F_final_iter er_theta2_F(MCsim,final_iter(MCsim))];
            er_theta3_F_final_iter=[er_theta3_F_final_iter er_theta3_F(MCsim,final_iter(MCsim))];
            er_theta4_F_final_iter=[er_theta4_F_final_iter er_theta4_F(MCsim,final_iter(MCsim))];
            
            er_theta1_U_final_iter=[er_theta1_U_final_iter er_theta1_U(MCsim,final_iter(MCsim))];
            er_theta2_U_final_iter=[er_theta2_U_final_iter er_theta2_U(MCsim,final_iter(MCsim))];
            er_theta3_U_final_iter=[er_theta3_U_final_iter er_theta3_U(MCsim,final_iter(MCsim))];
            er_theta4_U_final_iter=[er_theta4_U_final_iter er_theta4_U(MCsim,final_iter(MCsim))];

            
            e_logy_F_final_iter=[e_logy_F_final_iter log_ey_FIM(MCsim,final_iter(MCsim))];
            e_logy_U_final_iter=[e_logy_U_final_iter log_ey_uniform(MCsim,final_iter(MCsim))];
     
 
 end
        
 