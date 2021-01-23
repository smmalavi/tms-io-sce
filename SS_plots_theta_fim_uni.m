%==========================================================================
% In this file: plot estimation of thetas
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

%-- theta 1
f102=figure(102) ;
plot([0 n_plot(MCsim)],[(theta_true(1)),(theta_true(1))],'k-','LineWidth',1)
hold on
plot(1:n_plot(MCsim),(theta_est_comp(1:n_plot(MCsim),1)),'^b--','LineWidth',1);
hold on
plot(1:n_plot(MCsim),(theta_est(1:n_plot(MCsim),1)),'or--','LineWidth',1);
hold on
ylab=ylabel('$y_l$');
set(ylab,'interpreter','latex')
xlabel('Sample')
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;

fname = ['results_F' num2str(kkk)];
filename = sprintf(['yl%d'],MCsim);
saveas(gca, fullfile(fname, filename), 'fig');
saveas(gca, fullfile(fname, filename), 'png');

%-- theta2
f103=figure(103)  ;     
plot([0 n_plot(MCsim)],[(theta_true(2)),(theta_true(2))],'k-','LineWidth',1)
hold on
plot(1:n_plot(MCsim),(theta_est_comp(1:n_plot(MCsim),2)),'^b--','LineWidth',1);
hold on
plot(1:n_plot(MCsim),(theta_est(1:n_plot(MCsim),2)),'or--','LineWidth',1)
ylab=ylabel('$y_h$')
set(ylab,'interpreter','latex')
xlabel('Sample')
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;

fname = ['results_F' num2str(kkk)];
filename = sprintf(['yh%d'],MCsim);
saveas(gca, fullfile(fname, filename), 'fig');
saveas(gca, fullfile(fname, filename), 'png');

%-- theta3
f104=figure(104)  ;     
plot([0 n_plot(MCsim)],[(theta_true(3)),(theta_true(3))],'k-','LineWidth',1)
hold on
plot(1:n_plot(MCsim),(theta_est_comp(1:n_plot(MCsim),3)),'^b--','LineWidth',1);
hold on
plot(1:n_plot(MCsim),(theta_est(1:n_plot(MCsim),3)),'or--','LineWidth',1)
ylab=ylabel('$m$')
set(ylab,'interpreter','latex')
xlabel('Sample')
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;

fname = ['results_F' num2str(kkk)];
filename = sprintf(['m%d'],MCsim);
saveas(gca, fullfile(fname, filename), 'fig');
saveas(gca, fullfile(fname, filename), 'png');

%-- theta 4
f105=figure(105)  ;     
plot([0 n_plot(MCsim)],[(theta_true(4)),(theta_true(4))],'k-','LineWidth',1)
hold on
plot(1:n_plot(MCsim),(theta_est_comp(1:n_plot(MCsim),4)),'^b--','LineWidth',1);
hold on
plot(1:n_plot(MCsim),(theta_est(1:n_plot(MCsim),4)),'or--','LineWidth',1)
ylab=ylabel('$s$')
set(ylab,'interpreter','latex')
xlabel('Sample')
ax1=gca;
ax1.FontName = 'Times New Roman';
ax1.FontSize = 14;

fname = ['results_F' num2str(kkk)];
filename = sprintf(['s%d'],MCsim);
saveas(gca, fullfile(fname, filename), 'fig');
saveas(gca, fullfile(fname, filename), 'png');


 