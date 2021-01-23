%==========================================================================
% Plot distributions of nf vs. true thetas 
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


legend_fontsize=18;
axes_fontsize=18;

data=[total_theta_true_all_runs total_nf_F_T5_with_Peak'];
data(any(isnan(data),2),:) = []; %remove theta trues, in which modeified FIM-SPE did not converge



figd=figure;
set(figd, 'Position', [100, 100, 800, 500]);



%% theta 1
[rval_c pval_c]=corrcoef(data(:,1),data(:,end))
subplot(2,2,1),
plot(data(:,1),data(:,end),'or'); 
hl=lsline;
set(hl,'color','k','LineWidth',1);
strmin1 = ['{\it r} = ' ,num2str(round(rval_c(2,1),3)) ];
strmin2 = [', '];
strmin3 = ['{\it p} < ', num2str(round(pval_c(2,1),4))];
text(-5.37,250,[strmin1,strmin2,strmin3] ,'HorizontalAlignment','l','FontName','Times New Roman','FontSize', legend_fontsize);
strmax = ['(a)'];
text(-4.53,140,strmax,'HorizontalAlignment','left','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = axes_fontsize;
ax1.YScale='log';
ax1.XLim=[-5.4 -4.4];
xc=xlabel('$y^l$');
set(xc,'interpreter','latex','FontName','Times New Roman','FontSize', axes_fontsize) ;
ya=ylabel('$n_f$');
set(ya,'interpreter','latex','FontName','Times New Roman','FontSize', axes_fontsize)
ax1.YGrid='on';

%% theta 2

[rval_c pval_c]=corrcoef(data(:,2),data(:,end))
subplot(2,2,2),
plot(data(:,2),data(:,end),'or'); 
hl=lsline;
set(hl,'color','k','LineWidth',1);
strmin1 = ['{\it r} = ' ,num2str(round(rval_c(2,1),3)) ];
strmin2 = [', '];
strmin3 = ['{\it p} < ', num2str(round(pval_c(2,1),4))];
text(-3.9,250,[strmin1,strmin2,strmin3] ,'HorizontalAlignment','l','FontName','Times New Roman','FontSize', legend_fontsize);
strmax = ['(b)'];
text(-1.4,140,strmax,'HorizontalAlignment','left','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = axes_fontsize;
ax1.YScale='log';
% ax1.XLim=[0.04 0.2];
xc=xlabel('$y^h$');
set(xc,'interpreter','latex','FontName','Times New Roman','FontSize', axes_fontsize) ;
ya=ylabel('$n_f$');
set(ya,'interpreter','latex','FontName','Times New Roman','FontSize', axes_fontsize)
ax1.YGrid='on';

%% theta 3

[rval_c pval_c]=corrcoef(data(:,3),data(:,end))
subplot(2,2,3),
plot(data(:,3),data(:,end),'or'); 
hl=lsline;
set(hl,'color','k','LineWidth',1);
strmin1 = ['{\it r} = ' ,num2str(round(rval_c(2,1),3)) ];
strmin2 = [', '];
strmin3 = ['{\it p} < ', num2str(round(pval_c(2,1),4))];
text(.42,250,[strmin1,strmin2,strmin3] ,'HorizontalAlignment','l','FontName','Times New Roman','FontSize', legend_fontsize);
strmax = ['(c)'];
text(.923,140,strmax,'HorizontalAlignment','left','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = axes_fontsize;
ax1.YScale='log';
% ax1.XLim=[0.04 0.2];
xc=xlabel('$m$');
set(xc,'interpreter','latex','FontName','Times New Roman','FontSize', axes_fontsize) ;
ya=ylabel('$n_f$');
set(ya,'interpreter','latex','FontName','Times New Roman','FontSize', axes_fontsize)
ax1.YGrid='on';

%% theta 4
[rval_c pval_c]=corrcoef(data(:,4),data(:,end))
subplot(2,2,4),
plot(data(:,4),data(:,end),'or'); 
hl=lsline;
set(hl,'color','k','LineWidth',1);
strmin1 = ['{\it r} = ' ,num2str(round(rval_c(2,1),3)) ];
strmin2 = [', '];
strmin3 = ['{\it p} < ', num2str(round(pval_c(2,1),4))];
text(1.5,250,[strmin1,strmin2,strmin3] ,'HorizontalAlignment','l','FontName','Times New Roman','FontSize', legend_fontsize);
strmax = ['(d)'];
text(43.4,140,strmax,'HorizontalAlignment','left','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = axes_fontsize;
ax1.YScale='log';
ax1.XLim=[0 50];
xc=xlabel('$s$');
set(xc,'interpreter','latex','FontName','Times New Roman','FontSize', axes_fontsize) ;
ya=ylabel('$n_f$');
set(ya,'interpreter','latex','FontName','Times New Roman','FontSize', axes_fontsize)
ax1.YGrid='on';


%% save figure
saveas(figd,sprintf('Fig_Data_Distributions.fig'))
saveas(figd,sprintf('Fig_Data_Distributions.png'))
saveas(figd,sprintf('Fig_Data_Distributions.eps'),'epsc')
