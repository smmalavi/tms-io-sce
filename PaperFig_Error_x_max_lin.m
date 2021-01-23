%==========================================================================
% Plot AREs for peak slop errors 
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


fig_size=[100, 100, 500, 300];

legend_fontsize=12;
axes_fontsize=14;

%% error y' at x_max

figb=figure;
set(figb, 'Position', fig_size);

error_yprime_max_boxplot=[
    total_e_yprime_max_U_T5'...
    total_e_yprime_max_U_T5_with_Peak'...
    total_e_yprime_max_F_T5' ...
    total_e_yprime_max_F_T5_with_Peak' ]*1;

mean_error_yprime_max_boxplot=nanmean(error_yprime_max_boxplot);
median_error_yprime_max_boxplot=nanmedian(error_yprime_max_boxplot);
std_error_yprime_max_boxplot=std(error_yprime_max_boxplot);

hhhh2={error_yprime_max_boxplot};

[perc5_yprime_xmax perc95_yprime_xmax]=aboxplot(hhhh2,1,'labels',[1,2,3,4]);%,'OutlierMarker','x','OutlierMarkerSize',6,'OutlierMarkerEdgeColor','r','OutlierMarkerFaceColor','[1 1 1]');
hold on
% plot(1:1:4,median_error_yprime_max_boxplot,'--c','LineWidth',1)
hold on
plot(1:1:4,mean_error_yprime_max_boxplot,'--m','LineWidth',1)

lift_=.79
for jjj=1:2
    text(jjj,lift_*mean_error_yprime_max_boxplot(jjj),...
    num2str(round(mean_error_yprime_max_boxplot(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_=.7
for jjj=3:4
    text(jjj,lift_*mean_error_yprime_max_boxplot(jjj),...
    num2str(round(mean_error_yprime_max_boxplot(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=.95
for jjj=1:2
    text(jjj,lift_95*perc95_yprime_xmax(jjj),...
    num2str(round(perc95_yprime_xmax(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=.9
for jjj=3:4
    text(jjj,lift_95*perc95_yprime_xmax(jjj),...
    num2str(round(perc95_yprime_xmax(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize=axes_fontsize;
%ax1.YLim=[1e-2 1e0];
ax1.YScale='lin';
ax1.YGrid='on';
% ax1.XLim=[0 4];
set(gca,'TickLabelInterpreter', 'latex');

ax1.XTickLabel={'U@IOCE','U@SCE','IOCE','SCE'};
ya=ylabel('$|e_{\hat{y}^{\prime}({x^{*}})}| $')
set(ya,'interpreter','latex');
%xa=xlabel('$T$')
%set(xa,'interpreter','latex');

% strmax = ['Mean'];
% text(3.8,1.3,strmax,'interpreter','latex','HorizontalAlignment','left','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
% % strmax = ['Median'];
% % text(3.8,.9,strmax,'interpreter','latex','HorizontalAlignment','left','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
% 
% plot(3.5,1.3, 'Marker','s', 'MarkerSize',8,'MarkerEdgeColor','k');
% % plot(3.5,.9, 'Marker','>', 'MarkerSize',8,'MarkerEdgeColor','k');
% line([3.3 3.7],[1.3 1.3],'Color','k','LineStyle','--');
% % line([3.3 3.7],[.9 .9],'Color','k','LineStyle','--');


saveas(figb,sprintf('Fig_Error_yprime_at_x_max_lin.fig'))
saveas(figb,sprintf('Fig_Error_yprime_at_x_max_lin.png'))
saveas(figb,sprintf('Fig_Error_yprime_at_x_max_lin.eps'),'epsc')


