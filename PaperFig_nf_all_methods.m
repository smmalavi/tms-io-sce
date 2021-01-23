%==========================================================================
% Statistics of runs satisfying the stopping rule  
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


figa=figure;
set(figa, 'Position', fig_size);




%%
itr_F_boxplotT=[total_nf_Uconv_T5' total_nf_F_T5' total_nf_F_T5_with_Peak'];

% %replace maximum number of samples of the non-converged runs from 'NaN' to 'Nmax' 
% s1=size(itr_F_boxplotT,1);
% for i= 1: s1
%      msubs=itr_F_boxplotT(i,1:end); % Save existing data in ith row of m_data
%      msubs=msubs(isnan(itr_F_boxplotT(i,1:end))==0); %Substitute matrix/ taking only non-NaN values
%      itr_F_boxplotT(i,1:end)=total_no_iterations; %Erase all existing values in ith row of m_data and REPLACE by 0s
%      itr_F_boxplotT(i,1:size(msubs,2))=msubs; %Substitute values without NaN
% end

%%

mean_itr_F_boxplotT=ceil(nanmean(itr_F_boxplotT));
median_itr_F_boxplotT=ceil(nanmedian(itr_F_boxplotT));
std_itr_F_boxplotT=std(itr_F_boxplotT);


hhhh1={itr_F_boxplotT};

aboxplot(hhhh1,1,'labels',[1,2,3],'OutlierMarker','x','OutlierMarkerSize',6,'OutlierMarkerEdgeColor','r','OutlierMarkerFaceColor','[1 1 1]');
hold on
plot(1:1:3,median_itr_F_boxplotT,'--c','LineWidth',1)
hold on
plot(1:1:3,mean_itr_F_boxplotT,'--m','LineWidth',1)


strmax = ['No'];
tex=text(1,23,strmax,'HorizontalAlignment','center','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
set(tex,'Rotation',0);
strmax = ['Convergence'];
tex=text(1,20,strmax,'HorizontalAlignment','center','FontName', 'Times New Roman', 'FontSize', legend_fontsize);
set(tex,'Rotation',0);

ax1=gca;
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = axes_fontsize;
ax1.YLim=[10 220];
ax1.YScale='log';
ax1.YGrid='on';
% ax1.XLim=[0 4];
%ax1.XLim=[0 4];

ax1.XTickLabel={'Uniform','IOCE','SCE'};



ya=ylabel('$n_f$')
set(ya,'interpreter','latex');
%xa=xlabel('$T$')
%set(xa,'interpreter','latex');
saveas(figa,sprintf('Fig_NoSamplToTerm.fig'))
saveas(figa,sprintf('Fig_NoSamplToTerm.png'))
saveas(figa,sprintf('Fig_NoSamplToTerm.eps'),'epsc')