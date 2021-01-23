%==========================================================================
% In this file: save iterations where stopping rule are satisfied for
%               T=5 for IOCE and SCE methods
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

% record iteration that converge stopping rule for T=1,...5
% for FIM-SPE method

        if length(find(abs(log(theta_est(n,:))-log(theta_est(n-1,:)))/abs(log(theta_est(n,:))) < tol_rtheta)) == 4 && abs(log(theta_est(n,1))-log(paramLB(1)))>sac && abs(log(theta_est(n,1))-log(paramUB(1)))>sac && abs(log(theta_est(n,2))-log(paramLB(2)))>sac && abs(log(theta_est(n,2))-log(paramUB(2)))>sac && abs(log(theta_est(n,3))-log(paramLB(3)))>sac && abs(log(theta_est(n,3))-log(paramUB(3)))>sac && abs(log(theta_est(n,4))-log(paramLB(4)))>sac && abs(log(theta_est(n,4))-log(paramUB(4)))>sac 
           
            rtheta_converge_flag(n) = 1;
            
            
            
        else
            rtheta_converge_flag(n) = 0;
        end

        if n>4
            if rtheta_converge_flag(n)==1 && rtheta_converge_flag(n-1)==1 && rtheta_converge_flag(n-2)==1 && rtheta_converge_flag(n-3)==1 && rtheta_converge_flag(n-4)==1 %&& rtheta_converge_flag(n-5)==1 && rtheta_converge_flag(n-6)==1 && rtheta_converge_flag(n-7)==1 && rtheta_converge_flag(n-8)==1 && rtheta_converge_flag(n-9)==1
                iter_rtheta_converged5=[iter_rtheta_converged5 n];
                if ~isempty(iter_rtheta_converged5) && (n-iter_rtheta_converged5(1))>=5
                    iter_rtheta_converged_with_Peak=[iter_rtheta_converged_with_Peak n];
                end
                
            elseif rtheta_converge_flag(n)==1 && rtheta_converge_flag(n-1)==1 && rtheta_converge_flag(n-2)==1 && rtheta_converge_flag(n-3)==1
                iter_rtheta_converged4=[iter_rtheta_converged4 n];
                
            elseif rtheta_converge_flag(n)==1 && rtheta_converge_flag(n-1)==1 && rtheta_converge_flag(n-2)==1 
                iter_rtheta_converged3=[iter_rtheta_converged3 n];
                
            elseif rtheta_converge_flag(n)==1 && rtheta_converge_flag(n-1)==1 
                iter_rtheta_converged2=[iter_rtheta_converged2 n];
                
            elseif rtheta_converge_flag(n)==1 
                iter_rtheta_converged1=[iter_rtheta_converged1 n];
            end
        end



%% normal scale
% if  length(find(abs(theta_est(n,:)-theta_est(n-1,:))/abs(theta_est(n,:)) < tol_rtheta)) == 4 && abs(theta_est(n,1)-paramLB(1))>sac && abs(theta_est(n,1)-paramUB(1))>sac && abs(theta_est(n,2)-paramLB(2))>sac && abs(theta_est(n,2)-paramUB(2))>sac && abs(theta_est(n,3)-paramLB(3))>0.1*sac && abs(theta_est(n,3)-paramUB(3))>0.1*sac && abs(theta_est(n,4)-paramLB(4))>sac && abs(theta_est(n,4)-paramUB(4))>sac 
%              
%             rtheta_converge_flag(n) = 1;
%         else
%             rtheta_converge_flag(n) = 0;
%         end
% 
%         if n>4
%             if rtheta_converge_flag(n)==1 && rtheta_converge_flag(n-1)==1 && rtheta_converge_flag(n-2)==1 && rtheta_converge_flag(n-3)==1 && rtheta_converge_flag(n-4)==1 %&& rtheta_converge_flag(n-5)==1 && rtheta_converge_flag(n-6)==1 && rtheta_converge_flag(n-7)==1 && rtheta_converge_flag(n-8)==1 && rtheta_converge_flag(n-9)==1
%                 iter_rtheta_converged5=[iter_rtheta_converged5 n];
%                 
%             elseif rtheta_converge_flag(n)==1 && rtheta_converge_flag(n-1)==1 && rtheta_converge_flag(n-2)==1 && rtheta_converge_flag(n-3)==1
%                 iter_rtheta_converged4=[iter_rtheta_converged4 n];
%                 
%             elseif rtheta_converge_flag(n)==1 && rtheta_converge_flag(n-1)==1 && rtheta_converge_flag(n-2)==1 
%                 iter_rtheta_converged3=[iter_rtheta_converged3 n];
%                 
%             elseif rtheta_converge_flag(n)==1 && rtheta_converge_flag(n-1)==1 
%                 iter_rtheta_converged2=[iter_rtheta_converged2 n];
%                 
%             elseif rtheta_converge_flag(n)==1 
%                 iter_rtheta_converged1=[iter_rtheta_converged1 n];
%             end
%         end