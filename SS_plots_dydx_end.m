%==========================================================================
% In this file: plot and save final IO slope curve, estimations, samples, ...
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


f1000=figure;


dydx_curve_true(MCsim,:)=log(10)*(total_theta_true(MCsim,2)-total_theta_true(MCsim,1))*total_theta_true(MCsim,4)...
     .*10.^((total_theta_true(MCsim,3)-xval).*total_theta_true(MCsim,4))...
     ./(1+10.^((total_theta_true(MCsim,3)-xval)*total_theta_true(MCsim,4))).^2;

dydx_curve_FIM(MCsim,:)=log(10)*(theta2_F(MCsim,end)-theta1_F(MCsim,end))*theta4_F(MCsim,end)...
     .*10.^((theta3_F(MCsim,end)-xval).*theta4_F(MCsim,end))...
     ./(1+10.^((theta3_F(MCsim,end)-xval)*theta4_F(MCsim,end))).^2;

dydx_curve_uni(MCsim,:)=log(10)*(theta2_U(MCsim,end)-theta1_U(MCsim,end))*theta4_U(MCsim,end)...
     .*10.^((theta3_U(MCsim,end)-xval).*theta4_U(MCsim,end))...
     ./(1+10.^((theta3_U(MCsim,end)-xval)*theta4_U(MCsim,end))).^2;


plot(xval, dydx_curve_true(MCsim,1:end),'k')
hold on        
plot(xval, dydx_curve_FIM(MCsim,1:end),'--r')
hold on
plot(xval, dydx_curve_uni(MCsim,1:end),'--b')




%% x_max points
xmax_pnts_FIM=plot(x_yprime_max(MCsim,3:end),(yprime_max(MCsim,3:end)),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','s',...
            'MarkerSize',8,...
            'MarkerEdgeColor','m',...
            'MarkerFaceColor','none');

        
xmax_pnts_uni=plot(x_yprime_max_uni(MCsim,3:end),(yprime_max_uni(MCsim,3:end)),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','v',...
            'MarkerSize',8,...
            'MarkerEdgeColor','g',...
            'MarkerFaceColor','none');
        
        
%% FIM Sampling points
sample_pnts_FIM=plot(x_FIM_all_runs(MCsim,1:end),yprime_FIM_all_runs(MCsim,1:end), ...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','none');

        
%% Uniform Sampling points

yprim_uni_all_runs_FIM_end(MCsim,:)=log(10)*(theta2_U(MCsim,end)-theta1_U(MCsim,end))*theta4_U(MCsim,end)...
     .*10.^((theta3_U(MCsim,end)-xid_comp_plot_end(MCsim,1:end)).*theta4_U(MCsim,end))...
     ./(1+10.^((theta3_U(MCsim,end)-xid_comp_plot_end(MCsim,1:end))*theta4_U(MCsim,end))).^2;

    
sample_pnts_uni=plot(xid_comp_plot(end,1:end),yprim_uni_all_runs_FIM_end(MCsim,:), ...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','^',...
            'MarkerSize',8,...
            'MarkerEdgeColor','b',...
            'MarkerFaceColor','none');
        
set(gca, 'XScale', 'lin', 'YScale', 'lin')
xlabel('x'), ylabel('dy/dx')
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = 18;
ax1.XLim=[0 1.2]
 

leg=legend('True','FIM','Uniform',...
    'Peak points:FIM', 'Peak Points: Uniform',...
    'Sample Points: FIM', 'Sample Points: Uniform');
set(leg, 'Interpreter','latex');

fname = ['results_F' num2str(kkk)];
filename = sprintf(['dydx_end_%d'],MCsim);
saveas(gca, fullfile(fname, filename), 'fig');
saveas(gca, fullfile(fname, filename), 'png');

     
        