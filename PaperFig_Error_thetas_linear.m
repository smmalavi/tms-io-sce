%==========================================================================
% Plot statistics of thetas' AREs 
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

%% theta 1

figa=figure;
set(figa, 'Position', fig_size);

error_t1_max_boxplot=abs([
    total_er_t1_U_whenFconv_T5'...
    total_er_t1_U_whenFconv_T5_with_Peak'...
    total_er_t1_F_T5' ...
    total_er_t1_F_T5_with_Peak']*1);

mean_error_t1_max_boxplot=nanmean(error_t1_max_boxplot);
median_error_t1_max_boxplot=nanmedian(error_t1_max_boxplot);
std_error_t1_max_boxplot=std(error_t1_max_boxplot);

hhhh1={error_t1_max_boxplot};

[perc5_t1 perc95_t1]=aboxplot(hhhh1,1,'labels',[1,2,3,4]);%,'OutlierMarker','x','OutlierMarkerSize',6,'OutlierMarkerEdgeColor','r','OutlierMarkerFaceColor','[1 1 1]');
hold on
% plot(1:1:4,median_error_t1_max_boxplot,'--c','LineWidth',1)
hold on
plot(1:1:4,mean_error_t1_max_boxplot,'--m','LineWidth',1)


ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize=axes_fontsize;
%ax1.YLim=[1e-3 1e-1];
ax1.YScale='lin';
ax1.YGrid='on';
% ax1.XLim=[0 4];
%ax1.XTickLabelInterpreter = 'latex';
set(gca,'TickLabelInterpreter', 'latex');

ax1.XTickLabel={'U@IOCE','U@SCE','IOCE','SCE'};
%ax1.XTickLabel=[];

lift_=.77;
for jjj=1:2
    text(jjj,lift_*mean_error_t1_max_boxplot(jjj),...
    num2str(round(mean_error_t1_max_boxplot(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_=.85;
for jjj=3:4
    text(jjj,lift_*mean_error_t1_max_boxplot(jjj),...
    num2str(round(mean_error_t1_max_boxplot(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=.93;
for jjj=1:2
    text(jjj,lift_95*perc95_t1(jjj),...
    num2str(round(perc95_t1(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=.96;
for jjj=3:4
    text(jjj,lift_95*perc95_t1(jjj),...
    num2str(round(perc95_t1(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

% strmax = ['Met. 1 @'];
% text(1,0.6e-6,strmax,...
%     'interpreter','latex',...
%     'HorizontalAlignment','center',...
%     'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
% 
% strmax = ['Conv. Met. 2'];
% text(1,0.2e-6,strmax,...
%     'interpreter','latex',...
%     'HorizontalAlignment','center',...
%     'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);

ya=ylabel('$|e_{\hat{y}^l,n_f} | $')
set(ya,'interpreter','latex');
%xa=xlabel('$T$')
%set(xa,'interpreter','latex');

% strmax = ['Mean'];
% text(3.8,.00021,strmax,'interpreter','latex','HorizontalAlignment','left','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
% % strmax = ['Median'];
% % text(3.8,.00015,strmax,'interpreter','latex','HorizontalAlignment','left','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
% 
% plot(3.5,0.00021, 'Marker','s', 'MarkerSize',8,'MarkerEdgeColor','');
% %plot(3.5,0.00015, 'Marker','>', 'MarkerSize',8,'MarkerEdgeColor','k');
% line([3.3 3.7],[0.00021 0.00021],'Color','m','LineStyle','--');
% %line([3.3 3.7],[0.00015 0.00015],'Color','k','LineStyle','--');


saveas(figa,sprintf('Fig_Error_t1_lin.fig'))
saveas(figa,sprintf('Fig_Error_t1_lin.png'))
saveas(figa,sprintf('Fig_Error_t1_lin.eps'),'epsc')

%% theta 2

figa=figure;
set(figa, 'Position', fig_size);

error_t2_max_boxplot=abs([
    total_er_t2_U_whenFconv_T5'...
    total_er_t2_U_whenFconv_T5_with_Peak'...
    total_er_t2_F_T5' ...
    total_er_t2_F_T5_with_Peak']*1);

mean_error_t2_max_boxplot=nanmean(error_t2_max_boxplot);
median_error_t2_max_boxplot=nanmedian(error_t2_max_boxplot);
std_error_t2_max_boxplot=std(error_t2_max_boxplot);

hhhh1={error_t2_max_boxplot};

[perc5_t2 perc95_t2]=aboxplot(hhhh1,1,'labels',[1,2,3,4]);%,'OutlierMarker','x','OutlierMarkerSize',6,'OutlierMarkerEdgeColor','r','OutlierMarkerFaceColor','[1 1 1]');
hold on
% plot(1:1:4,median_error_t2_max_boxplot,'--c','LineWidth',1)
% hold on
plot(1:1:4,mean_error_t2_max_boxplot,'--m','LineWidth',1)

lift_=.77;
for jjj=1:4
    text(jjj,lift_*mean_error_t2_max_boxplot(jjj),...
    num2str(round(mean_error_t2_max_boxplot(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=.95;
for jjj=1:2
    text(jjj,lift_95*perc95_t2(jjj),...
    num2str(round(perc95_t2(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=.93;
for jjj=3:4
    text(jjj,lift_95*perc95_t2(jjj),...
    num2str(round(perc95_t2(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end


ax1=gca;
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize=axes_fontsize;
%ax1.YLim=[1e-3 1e-1];
ax1.YScale='lin';
ax1.YGrid='on';
% ax1.XLim=[0 4];
set(gca,'TickLabelInterpreter', 'latex');

ax1.XTickLabel={'U@IOCE','U@SCE','IOCE','SCE'};
ya=ylabel('$|e_{\hat{y}^h,n_f} | $')
set(ya,'interpreter','latex');
%xa=xlabel('$T$')
%set(xa,'interpreter','latex');
saveas(figa,sprintf('Fig_Error_t2_lin.fig'))
saveas(figa,sprintf('Fig_Error_t2_lin.png'))
saveas(figa,sprintf('Fig_Error_t2_lin.eps'),'epsc')



%% Error theta3

figa=figure;
set(figa, 'Position', fig_size);

error_t3_max_boxplot=abs([
    total_er_t3_U_whenFconv_T5'...
    total_er_t3_U_whenFconv_T5_with_Peak'...
    total_er_t3_F_T5' ...
    total_er_t3_F_T5_with_Peak']*1);

mean_error_t3_max_boxplot=nanmean(error_t3_max_boxplot);
median_error_t3_max_boxplot=nanmedian(error_t3_max_boxplot);
std_error_t3_max_boxplot=std(error_t3_max_boxplot);

hhhh1={error_t3_max_boxplot};

[perc5_t3 perc95_t3]=aboxplot(hhhh1,1,'labels',[1,2,3,4]);%,'OutlierMarker','x','OutlierMarkerSize',6,'OutlierMarkerEdgeColor','r','OutlierMarkerFaceColor','[1 1 1]');
hold on
% plot(1:1:4,median_error_t3_max_boxplot,'--c','LineWidth',1)
% hold on
plot(1:1:4,mean_error_t3_max_boxplot,'--m','LineWidth',1)

lift_=.77
for jjj=1:4
    text(jjj,lift_*mean_error_t3_max_boxplot(jjj),...
    num2str(round(mean_error_t3_max_boxplot(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=0.95;
for jjj=1:2
    text(jjj,lift_95*perc95_t3(jjj),...
    num2str(round(perc95_t3(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=0.93;
for jjj=3:4
    text(jjj,lift_95*perc95_t3(jjj),...
    num2str(round(perc95_t3(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end


ax1=gca;
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize=axes_fontsize;
%ax1.YLim=[1e-3 1e-1];
ax1.YScale='lin';
ax1.YGrid='on';
% ax1.XLim=[0 4];
set(gca,'TickLabelInterpreter', 'latex');

ax1.XTickLabel={'U@IOCE','U@SCE','IOCE','SCE'};
ya=ylabel('$|e_{\hat{m},n_f} | $ or $|e_{\hat{x}^\ast,n_f}|$')
set(ya,'interpreter','latex');
%xa=xlabel('$T$')
%set(xa,'interpreter','latex');
saveas(figa,sprintf('Fig_Error_t3_lin.fig'))
saveas(figa,sprintf('Fig_Error_t3_lin.png'))
saveas(figa,sprintf('Fig_Error_t3_lin.eps'),'epsc')


%% theta 4
figa=figure;
set(figa, 'Position', fig_size);

% total_er_t4_U_whenFconv_T5(54)=0, it is replaced with 1e-10;
%total_er_t4_U_whenFconv_T5(54)=1e-4;

error_t4_max_boxplot=abs([
    total_er_t4_U_whenFconv_T5'...
    total_er_t4_U_whenFconv_T5_with_Peak'...
    total_er_t4_F_T5' ...
    total_er_t4_F_T5_with_Peak']*1);

mean_error_t4_max_boxplot=nanmean(error_t4_max_boxplot);
median_error_t4_max_boxplot=nanmedian(error_t4_max_boxplot);
std_error_t4_max_boxplot=std(error_t4_max_boxplot);

hhhh1={error_t4_max_boxplot};

[perc5_t4 perc95_t4]=aboxplot(hhhh1,1,'labels',[1,2,3,4]);%,'OutlierMarker','x','OutlierMarkerSize',6,'OutlierMarkerEdgeColor','r','OutlierMarkerFaceColor','[1 1 1]');
hold on
% plot(1:1:4,median_error_t4_max_boxplot,'--c','LineWidth',1)
hold on
plot(1:1:4,mean_error_t4_max_boxplot,'--m','LineWidth',1)

lift_=.75;
for jjj=1:2
    text(jjj,lift_*mean_error_t4_max_boxplot(jjj),...
    num2str(round(mean_error_t4_max_boxplot(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_=.6;
for jjj=3:4
    text(jjj,lift_*mean_error_t4_max_boxplot(jjj),...
    num2str(round(mean_error_t4_max_boxplot(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=0.95;
for jjj=1
    text(jjj,lift_95*perc95_t4(jjj),...
    num2str(round(perc95_t4(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=0.92;
for jjj=2
    text(jjj,lift_95*perc95_t4(jjj),...
    num2str(round(perc95_t4(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end

lift_95=0.89;
for jjj=3:4
    text(jjj,lift_95*perc95_t4(jjj),...
    num2str(round(perc95_t4(jjj),4)),...
    'interpreter','latex',...
    'HorizontalAlignment','left',...
    'FontName', 'Times New Roman', 'FontSize', axes_fontsize-4);
end


ax1=gca;
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize=axes_fontsize;
%ax1.YLim=[1e-2 1e0];
ax1.YScale='lin';
ax1.YGrid='on';
% ax1.XLim=[0 4];
set(gca,'TickLabelInterpreter', 'latex');

ax1.XTickLabel={'U@IOCE','U@SCE','IOCE','SCE'};
ya=ylabel('$|e_{\hat{s},n_f}|$')
set(ya,'interpreter','latex');
%xa=xlabel('$T$')
%set(xa,'interpreter','latex');
saveas(figa,sprintf('Fig_Error_t4_lin.fig'))
saveas(figa,sprintf('Fig_Error_t4_lin.png'))
saveas(figa,sprintf('Fig_Error_t4_lin.eps'),'epsc')

