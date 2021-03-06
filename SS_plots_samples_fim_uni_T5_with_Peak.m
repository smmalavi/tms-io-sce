%==========================================================================
% In this file: plot and save final IO curve, estimations, samples, ...
%   when SCE method stops
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

if ~isnan(iter_F_conv5_with_Peak(MCsim))
    
    plot_to_iter=iter_F_conv5_with_Peak(MCsim);

f110=figure;

    

plot(x_dg,myy(MCsim,:),'x','Color', [0.5 0.5 0.5]);
        %plot(x_dg,logyt_m,'o','Color', 'b');
        hold on
        plot(xval,10.^myy_true_4par(MCsim,:),'k','LineWidth',1);
        %axis([0 1 0 2]);
        xlabel('Input: x')
        ylabel('Output: y')
        ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 18;
        ax1.XLim=[0 1.2]
        ax1.YScale='log'


  baselinepnts=plot(xeq0,(yid_xeq0(MCsim,:)),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','d',...
            'MarkerSize',8,...
            'MarkerEdgeColor','c',...
            'MarkerFaceColor','none');
           
        
        
% sample points unifrom
xid_comp_plot_T5_with_Peak(MCsim,1:plot_to_iter)=xid_min:(xid_max-xid_min)/(plot_to_iter-1):xid_max;

ysamples_uni_all_runs_FIM_T5_with_Peak(MCsim,1:plot_to_iter)=yid_comp_plot(plot_to_iter,1:plot_to_iter);
 
sample_pnts_uni=plot(xid_comp_plot_T5_with_Peak(MCsim,1:plot_to_iter),ysamples_uni_all_runs_FIM_T5_with_Peak(MCsim,1:plot_to_iter), ...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','^',...
            'MarkerSize',8,...
            'MarkerEdgeColor','b',...
            'MarkerFaceColor','none');

ycurve_uni_FIM_T5_with_Peak(MCsim,:)=theta1_U(MCsim,plot_to_iter)+ ...
    (theta2_U(MCsim,plot_to_iter)-theta1_U(MCsim,plot_to_iter))...
    ./(1+10.^((theta3_U(MCsim,plot_to_iter)-xval)*theta4_U(MCsim,plot_to_iter)));

         

poldfit=plot(xval,10.^(ycurve_uni_FIM_T5_with_Peak(MCsim,:)),...
            'LineStyle','- -',...
            'LineWidth',2,...
            'Marker','none',...
            'MarkerSize',8,...
            'MarkerEdgeColor','b',...
            'Color','b');
        
        
% FIM sample points and curve
sample_pnts_FIM=plot(x_FIM_all_runs(MCsim,1:plot_to_iter),y_FIM_all_runs(MCsim,1:plot_to_iter), ...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','none');


ycurve_FIM_T5_with_Peak(MCsim,:)=theta1_F(MCsim,plot_to_iter)+ ...
    (theta2_F(MCsim,plot_to_iter)-theta1_F(MCsim,plot_to_iter))...
    ./(1+10.^((theta3_F(MCsim,plot_to_iter)-xval)*theta4_F(MCsim,plot_to_iter)));

           
pnewfit=plot(xval,10.^(ycurve_FIM_T5_with_Peak(MCsim,:)),...
            'LineStyle','--',...
            'LineWidth',2,...
            'Color','r');
                
        
%% x_max points
         pdpnts=plot(x_yprime_max(MCsim,3:plot_to_iter),10.^(y_yprime_max(MCsim,3:plot_to_iter)),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','s',...
            'MarkerSize',8,...
            'MarkerEdgeColor','m',...
            'MarkerFaceColor','none');

        
        pdpnts=plot(x_yprime_max_uni(MCsim,3:plot_to_iter),10.^(y_yprime_max_uni(MCsim,3:plot_to_iter)),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','v',...
            'MarkerSize',8,...
            'MarkerEdgeColor','g',...
            'MarkerFaceColor','none');

        
%AX=legend('data','True model','Uniform sample','Uniform SPE','FIM sample','FIM SPE','Location','Northeast');%''southeast');
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;


fname = ['results_F' num2str(kkk)];
filename = sprintf(['io_T5_with_Peak_%d'],MCsim);
saveas(gca, fullfile(fname, filename), 'fig');
saveas(gca, fullfile(fname, filename), 'png');

end
        