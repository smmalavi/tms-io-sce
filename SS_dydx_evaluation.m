%==========================================================================
% This file: Evaluation of slope curve estimation 
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



%%%%  Find yprime_max_true, and x_yprime_max_true
            
x_yprime_max_true(MCsim)=theta_true(3);
yprime_max_true(MCsim)=log(10)*(theta_true(2)-theta_true(1))*theta_true(4)...
    *10^((theta_true(3)-x_yprime_max_true(MCsim))*theta_true(4))...
    /(1+10.^((theta_true(3)-x_yprime_max_true(MCsim))*theta_true(4)))^2;

y_yprime_max_true(MCsim)=theta_true(1) + ...
     (theta_true(2)-theta_true(1)) ./ (1 + 10.^((theta_true(3)-x_yprime_max_true(MCsim))*theta_true(4)));

 
%% error when FIM converged for T=1,2,3,4,5
            
e_yprime_max_FIM_end(MCsim)=abs(yprime_max_true(MCsim)-yprime_max(MCsim,n_plot(MCsim)));
e_x_yprime_max_FIM_end(MCsim)=abs(x_yprime_max_true(MCsim)-x_yprime_max(MCsim,n_plot(MCsim)));
e_y_yprime_max_FIM_end(MCsim)=abs(y_yprime_max_true(MCsim)-y_yprime_max(MCsim,n_plot(MCsim)));

e_yprime_max_uni_end(MCsim)=abs(yprime_max_true(MCsim)-yprime_max_uni(MCsim,n_plot(MCsim)));
e_x_yprime_max_uni_end(MCsim)=abs(x_yprime_max_true(MCsim)-x_yprime_max_uni(MCsim,n_plot(MCsim)));
e_y_yprime_max_uni_end(MCsim)=abs(y_yprime_max_true(MCsim)-y_yprime_max_uni(MCsim,n_plot(MCsim)));

%iter_rtheta_converged5

if ~isempty(iter_rtheta_converged5)
    e_yprime_max_FIM_T5(MCsim)=abs(yprime_max_true(MCsim)-yprime_max(MCsim,iter_rtheta_converged5(1)));
    e_x_yprime_max_FIM_T5(MCsim)=abs(x_yprime_max_true(MCsim)-x_yprime_max(MCsim,iter_rtheta_converged5(1)));
    e_y_yprime_max_FIM_T5(MCsim)=abs(y_yprime_max_true(MCsim)-y_yprime_max(MCsim,iter_rtheta_converged5(1)));
    e_yprime_max_uni_T5(MCsim)=abs(yprime_max_true(MCsim)-yprime_max_uni(MCsim,iter_rtheta_converged5(1)));
    e_x_yprime_max_uni_T5(MCsim)=abs(x_yprime_max_true(MCsim)-x_yprime_max_uni(MCsim,iter_rtheta_converged5(1)));
    e_y_yprime_max_uni_T5(MCsim)=abs(y_yprime_max_true(MCsim)-y_yprime_max_uni(MCsim,iter_rtheta_converged5(1)));
    
else
    e_yprime_max_FIM_T5(MCsim)=nan;%e_yprime_max_FIM_end(MCsim);
    e_x_yprime_max_FIM_T5(MCsim)=nan;%e_x_yprime_max_FIM_end(MCsim);
    e_y_yprime_max_FIM_T5(MCsim)=nan;%e_y_yprime_max_FIM_end(MCsim);
    e_yprime_max_uni_T5(MCsim)=nan;%e_yprime_max_uni_end(MCsim);
    e_x_yprime_max_uni_T5(MCsim)=nan;%e_x_yprime_max_uni_end(MCsim);
    e_y_yprime_max_uni_T5(MCsim)=nan;%e_y_yprime_max_uni_end(MCsim);
end


%iter_rtheta_converged_with_peak
if ~isempty(iter_rtheta_converged_with_Peak)
    e_yprime_max_FIM_T5_with_Peak(MCsim)=abs(yprime_max_true(MCsim)-yprime_max(MCsim,iter_rtheta_converged_with_Peak(1)));
    e_x_yprime_max_FIM_T5_with_Peak(MCsim)=abs(x_yprime_max_true(MCsim)-x_yprime_max(MCsim,iter_rtheta_converged_with_Peak(1)));
    e_y_yprime_max_FIM_T5_with_Peak(MCsim)=abs(y_yprime_max_true(MCsim)-y_yprime_max(MCsim,iter_rtheta_converged_with_Peak(1)));
    e_yprime_max_uni_T5_with_Peak(MCsim)=abs(yprime_max_true(MCsim)-yprime_max_uni(MCsim,iter_rtheta_converged_with_Peak(1)));
    e_x_yprime_max_uni_T5_with_Peak(MCsim)=abs(x_yprime_max_true(MCsim)-x_yprime_max_uni(MCsim,iter_rtheta_converged_with_Peak(1)));
    e_y_yprime_max_uni_T5_with_Peak(MCsim)=abs(y_yprime_max_true(MCsim)-y_yprime_max_uni(MCsim,iter_rtheta_converged_with_Peak(1)));

else
    e_yprime_max_FIM_T5_with_Peak(MCsim)=nan;%e_yprime_max_FIM_end(MCsim);
    e_x_yprime_max_FIM_T5_with_Peak(MCsim)=nan;%e_x_yprime_max_FIM_end(MCsim);
    e_y_yprime_max_FIM_T5_with_Peak(MCsim)=nan;%e_y_yprime_max_FIM_end(MCsim);
    e_yprime_max_uni_T5_with_Peak(MCsim)=nan;%e_yprime_max_uni_end(MCsim);
    e_x_yprime_max_uni_T5_with_Peak(MCsim)=nan;%e_x_yprime_max_uni_end(MCsim);
    e_y_yprime_max_uni_T5_with_Peak(MCsim)=nan;%e_y_yprime_max_uni_end(MCsim);    
end
