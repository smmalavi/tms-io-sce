%==========================================================================
% This is the >>  Main  << file for simulation of multiple runs 
%     and saving the data in a folder  
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

%clear all
close all
clc


rng('shuffle'); 

%Total_runs=input('Total runs=');
%Total_runs=5;
no_ini_samples_fim=3;
%Nmax=input('Maximum numbers of TMS stimuli=')
%Nmax=200;
total_no_iterations=Nmax;
no_next_iter=total_no_iterations-no_ini_samples_fim;

%nxeq0=input('Numbers of baseline data=')
%nxeq0=20;
xeq0=zeros(1,nxeq0);

% relative error tolerance for termination
tol_rtheta=.001*ones(1,4);

plot_animation = 0; %  To run saving animation, set this to 1

save_er_plot_after_each_run=1; %To save plots after each run set this to 1
 
no_of_parameters=4; %number of parameters of the estimate model

total_theta_true_6par=[];
total_theta_true=[];
total_sigma_y=[];% variance of y-axis variability
total_sigma_x=[];% variance of x-axis variability

paramLB=[-7 -4 0.01   .01];% upper limit of the parameter vector
paramUB=[-3 -1 1.00    100];% lower limit of the parameter vector
    
% these parameters are used for bad fit detetction     
fmr=0.1;
fmr3=0.01;
sac=0.1;
sac3=0.01;


% variables for evaluations 
% index F denotes FIM-SPE
% index U denotes uniform sampling

% estimation of theta
theta1_F=[];
theta2_F=[];
theta3_F=[];
theta4_F=[];


theta1_U=[];
theta2_U=[];
theta3_U=[];
theta4_U=[];

% errors
er_theta1_F=[];
er_theta1_F_final_iter=[];

er_theta2_F=[];
er_theta2_F_final_iter=[];

er_theta3_F=[];
er_theta3_F_final_iter=[];

er_theta4_F=[];
er_theta4_F_final_iter=[];

er_theta=[];
e_logy_F_final_iter=[];

log_ey_FIM=[];

rtheta_FIM=[];

er_theta1_U=[];
er_theta1_U_final_iter=[];

er_theta2_U=[];
er_theta2_U_final_iter=[];

er_theta3_U=[];
er_theta3_U_final_iter=[];

er_theta4_U=[];
er_theta4_U_final_iter=[];

er_theta_comp=[];
e_logy_uniform=[];

e_logy_U_final_iter=[];

rtheta_uniform=[];

%outSim=[];

% reset parameters 
SS_resetPars_T5;
SS_resetPars_T5_with_Peak;

myp=[]; % keep true parameters of the Stefan model of all runs  
myy=[]; % keep MEPs of the Stefan model of all runs (all data shown by x signs)  
myy_true=[]; % keep MEP of the true model (using Stefan model) of all runs

myp0=[]; % generate the data with sigma_y=0 to estimate the 4-par reference model
myy0=[]; % keep MEP of the Stefan model of all runs


myy_true_4par=[]; % MEP of the 4-par reference model
yid_xeq0=[]; % Baseline data used for indentification 
add_yvar=[]; % y-axix varaibility (mean of baseline data, used in SELP)

e_4_6par_model=[]; % error between the estimated reference and Stefan's 
log_e_4_6par_model=[]; % log og the error between the estimated reference and Stefan's 


x_yprime_max_true=[];
yprime_max_true=[];
y_yprime_max_true=[];


x_yprime_max=[];
yprime_max=[];
y_yprime_max=[];

x_yprime_max_uni=[];
yprime_max_uni=[];
y_yprime_max_uni=[];



e_x_yprime_max_FIM_T5=[];
e_yprime_max_FIM_T5=[];
e_y_yprime_max_FIM_T5=[];

e_x_yprime_max_FIM_end=[];
e_yprime_max_FIM_end=[];
e_y_yprime_max_FIM_end=[];

e_x_yprime_max_uni_T5=[];
e_yprime_max_uni_T5=[];
e_y_yprime_max_uni_T5=[];

e_x_yprime_max_uni_end=[];
e_yprime_max_uni_end=[];
e_y_yprime_max_uni_end=[];



e_yprime_max_FIM_T5_with_Peak=[];
e_x_yprime_max_FIM_T5_with_Peak=[];
e_y_yprime_max_FIM_T5_with_Peak=[];
e_yprime_max_uni_T5_with_Peak=[];
e_x_yprime_max_uni_T5_with_Peak=[];
e_y_yprime_max_uni_T5_with_Peak=[];
    
    
x_FIM_all_runs=nan(Total_runs,Nmax);
y_FIM_all_runs=nan(Total_runs,Nmax);
yprime_FIM_all_runs=nan(Total_runs,Nmax);




xid_comp_plot_T5=nan(Total_runs,Nmax);
ysamples_uni_all_runs_FIM_T5=nan(Total_runs,Nmax);
ycurve_uni_FIM_T5=[];
ycurve_FIM_T5=[];
yprim_uni_all_runs_FIM_T5=nan(Total_runs,Nmax);


xid_comp_plot_T5_with_Peak=nan(Total_runs,Nmax);
ysamples_uni_all_runs_FIM_T5_with_Peak=nan(Total_runs,Nmax);
ycurve_uni_FIM_T5_with_Peak=[];
ycurve_FIM_T5_with_Peak=[];
yprim_uni_all_runs_FIM_T5_with_Peak=nan(Total_runs,Nmax);



xid_comp_plot_end=nan(Total_runs,Nmax);
ysamples_uni_all_runs_FIM_end=nan(Total_runs,Nmax);
ycurve_uni_FIM_end=[];
ycurve_FIM_end=[];
yprim_uni_all_runs_FIM_end=nan(Total_runs,Nmax);

eyprime_uniform=[];
eyprime_FIM=[];
  
for MCsim=1:Total_runs

close all
clc
    
MCsim

xid=[];% x-data used for the identification 
xid_new=[];% x new (after FIM optimization) of the identification 
xid_byFIM=[];% used as auxiliary 

yid=[];% y-data used for the identification 
yid_new=[];% y of the new x
yid_paper=[];% used as auxiliary 

xid_ga=[];% x-new obtained from the genetic algorithm optimization 
fval_ga=[];% optimal value of the cost function 

xid_ms=[];% x-new obtained from the multiple start-points optimization
fval_ms=[];% optimal value of the cost function 

xid_gs=[];% x-new obtained from the Global Search optimization
fval_gs=[];% optimal value of the cost function
 
theta_est=zeros(1,no_of_parameters);% initialize 4 parameters of the FIM-SPE
yest_val=[];% validation of y from the estimated model

rtheta_converge_flag=[];% flag to check convergence of FIM-SPE


xid_comp=[];% xdata used for unfirom curve fitting
yid_comp=[];% y data used for uniform curve fitting
theta_est_comp=zeros(1,no_of_parameters);% initialize 4 parameters of the Uniform sampling
yest_val_comp=[]; % validation of y from the estimated model
rtheta_converge_flag_comp=[];% flag to check convergence of uniform method

iter_rtheta_converged_with_Peak=[];

%% Data generation using stefan's model
   
    rng('shuffle');
    xid_min=0;% minimum input
    xid_max=1;% maximum input
        
    x_dg=linspace(xid_min,xid_max,1000);% a set of inputs used for plots
    xval = linspace(0, 1, 100);% a set of inputs used for the identification validation, etc.
    size_val=length(xval);% size of xval
    
    myp(MCsim,:) = virtualsubjectEIVGenerateSubject_01;% all parameters of Stefan model 
    myy(MCsim,:) = virtualsubjectEIVStimulate_01(x_dg, myp(MCsim,:));% original data
       
    sigma_y=myp(MCsim,6);%y-axis variability
    sigma_x=myp(MCsim,7);%x-axis variability
    total_sigma_y=[total_sigma_y sigma_y];% y-axis variability, all runs
    total_sigma_x=[total_sigma_x sigma_x];% x-axis variability all runs
    
   
    % finding true values for the 4 parameter model using 6-parameter model 
   
    % generate the data with sigma_y=0 for the identification of the 4 parameter model 
    myp0(MCsim,:)=[myp(MCsim,1:5) 0 myp(MCsim,7:10)];

    % generate the data with sigma_x=0 for the identification of the 4 parameter model 
    % myp0(MCsim,:)=[myp(MCsim,1:6) 0 myp(MCsim,8:10)];
    % 
    % generate the data with sigma_x=sigma_y=0 for the identification of the 4 parameter model 
    % myp0(MCsim,:)=[myp(MCsim,1:5) 0 0 myp(MCsim,8:10)];

    myy0(MCsim,:) = virtualsubjectEIVStimulate_01(x_dg, myp0(MCsim,:));% get the MEPs
    [xData, yData] = prepareCurveData( x_dg, log10(myy0(MCsim,:)) );% collect data
       
    ft = fittype( 'a+(b-a)./(1+10^((c-x)*d))', 'independent', 'x', 'dependent', 'y' );% do curve fitting
           
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
	pts.Algorithm = 'Trust-Region';
    opts.Lower = paramLB;
    opts.Upper = paramUB;
    opts.Robust ='LAR';
    ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
    opts.StartPoint =ini_guess;
         
    [fitresult, gof] = fit( xData, yData, ft, opts );
            
    theta_true=[fitresult.a; fitresult.b; fitresult.c; fitresult.d ]% true values of the 4-parameter model

    myy_true_4par(MCsim,:)=theta_true(1)+(theta_true(2)-theta_true(1))./(1+10.^((theta_true(3)-xval)*theta_true(4)));% get true MEP of the 4-par model
    
    my_yprime_true(MCsim,:)=log(10)*(theta_true(2)-theta_true(1))*theta_true(4)...
    .*10.^((theta_true(3)-xval)*theta_true(4))...
    ./(1+10.^((theta_true(3)-xval)*theta_true(4))).^2;

    
    % collect baseline data, also used for the computation of the 
    % error between the IO curves
    % compute an estimate of the original IO curve  
    % add_yvar is set to the mean of baseline data 
    yid_xeq0(MCsim,:) = virtualsubjectEIVStimulate_01(xeq0, myp(MCsim,:));% baseline data
    add_yvar(MCsim)=mean(yid_xeq0(MCsim,:));% mean of baseline data
    myy_true(MCsim,:)=virtstimulate_estimationfct(xval,myp(MCsim,:),add_yvar(MCsim));
   
    % false estimation detector>>
    ey_4_6par_model(MCsim)=sum((10.^(myy_true_4par(MCsim,:))-myy_true(MCsim,:)).^2);
    log_e_4_6par_model(MCsim)=abs(log10(ey_4_6par_model(MCsim)));
    if log_e_4_6par_model(MCsim) > 3
        [fitresult, gof] = fit( xData, (yData), ft, opts );
            
        theta_true=[fitresult.a; fitresult.b; fitresult.c; fitresult.d ]

        myy_true_4par(MCsim,:)=theta_true(1)+(theta_true(2)-theta_true(1))./(1+10.^((theta_true(3)-xval)*theta_true(4)));
    end
    % <<
    
    total_theta_true=[total_theta_true;theta_true'];% ture thetas of all runs
    
   
    figure(200)   
    cla
    hold on
    plot(x_dg, myy(MCsim,:), 'sk')
    plot(xval,myy_true(MCsim,:),'b')
    plot(xval, 10.^(myy_true_4par(MCsim,:)), '-r')
    plot(xeq0,yid_xeq0(MCsim,:),'o')
    xlabel('Input: x')
    ylabel('Output: y')
    set(gca, 'XScale', 'lin', 'YScale', 'log')
    ax1=gca;
    ax1.FontName = 'Times New Roman';
    ax1.FontSize = 18;
    box on
    grid on
    legend('data', '6-par model','4-par model','baseline data')
   
 
        %End data generation
%% Animation setups       
        %plot delays:
        dataset_plot_delay=2;
        ini_est_plot_delay=2;
        next_est_plot_delay1=2;
        next_est_plot_delay2=2;
        next_est_plot_delay3=2;
        
        
    if plot_animation == 1    
        %%%%%%%%%%%%%%%%%%%%%%
        %   Debug only: plot IO
        figure(1)
        %title('Input-Output curve estimation in transcranial magnetic stimulation')
        fig1_r=11;
        fig1_c=13;
        
        f1=gcf;
        set(f1, 'Position', [400 50 1400 900]);%,...
        
        
        %%%%%%
        % FIM plot
        %%%%%%% 
        fwdth=6;
        subplot(fig1_r,fig1_c,[1:1+fwdth,14:14+fwdth,27:27+fwdth,40:40+fwdth,53:53+fwdth,66:66+fwdth,79:79+fwdth]);   
        
        plot(x_dg,myy(MCsim,:),'x','Color', [0.5 0.5 0.5]);
        %plot(x_dg,logyt_m,'o','Color', 'b');
        hold on
        plot(xval,10.^myy_true_4par(MCsim,:),'k','LineWidth',1);
        %axis([0 1 0 2]);
        xlabel('Input: x')
        ylabel('Output: y')
        title('FIM SPE')
        ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 18;
        ax1.XLim=[0 1.2]
        ax1.YScale='log'

        
        %%%%%%%%
        % FIM table
        %%%%%%%%
        test_d=[theta_true';zeros(1,4);
           zeros(1,4)];
        % Create the column and row names in cell arrays 
        cnames = {'Low Level: y_l','High Leve: y_h','Mid-point: m','Slope: s'};
        rnames = {'True values','Previous estimate','Current estimate'};
        
        % Create the uitable
        tTxt = uicontrol('style','text');
        set(tTxt,'String','Estimation Results',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[160 160 620 50]);
        table_x=160;
        table_y=100;
        table_t = uitable(f1,'Data',test_d,...
            'ColumnName',cnames,... 
            'ColumnWidth',{105 105 105 80},...
            'RowName',rnames);
        table_t.FontName='Times New Roman';
        table_t.FontSize=16;
        table_t.Position(1) = table_x;
        table_t.Position(2) = table_y;
        table_t.Position(3) = table_t.Extent(3);
        table_t.Position(4) = table_t.Extent(4);
        %table ends
        
                mTextBox = uicontrol('style','text');
        set(mTextBox,'String','2016 Copyright: S.M.M. Alavi, S.M. Goetz, A.V. Peterchev, Brain Stimulation Engineering Lab (BSEL), Duke University',...
            'HorizontalAlignment','left',...
            'FontSize',14,...
            'Position',[120 0 800 50]);
        
 
          mTextBox = uicontrol('style','text');
        set(mTextBox,'String','(b-a)      ',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[480 80 200  225]);
        
        
        mTextBox = uicontrol('style','text');
        set(mTextBox,'String','Model: y = a+---------------',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[360 65 200 220]);
        
        
        mTextBox = uicontrol('style','text');
        set(mTextBox,'String','    (1+10^((c-x)*d))          ',...
            'HorizontalAlignment','left',...
             'FontSize',16,...
            'Position',[430 45 200 220]);
        
  
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigFIM'  num2str(MCsim) '.gif'];
        imwrite(imind,cm,gif_path,'gif','WriteMode','overwrite', 'Loopcount',inf, 'DelayTime',dataset_plot_delay);
        

        
        %%%%%%

         figure(5)
     
        f5=gcf;
        set(f5, 'Position', [400 50 1400 900]);%,...
        
        
        %%%%%%
        % FIM plot
        %%%%%%% 
       % fwdth=4;
        subplot(fig1_r,fig1_c,[1:1+fwdth,14:14+fwdth,27:27+fwdth,40:40+fwdth,53:53+fwdth,66:66+fwdth,79:79+fwdth]);   
        
       plot(x_dg,myy(MCsim,:),'x','Color', [0.5 0.5 0.5]);
        %plot(x_dg,logyt_m,'o','Color', 'b');
        hold on
        plot(xval,10.^myy_true_4par(MCsim,:),'k','LineWidth',1);
        %axis([0 1 0 2]);
        xlabel('Input: x')
        ylabel('Output: y')
        title('FIM SPE')
        ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 18;
        ax1.XLim=[0 1.2]
        ax1.YScale='log'

        
        %%%%%%%%
        % FIM table
        %%%%%%%%
        test_d5=[theta_true';%zeros(1,2);
           zeros(1,4)];
        % Create the column and row names in cell arrays 
        %cnames = {'Mean','Variance'};
        rnames = {'True Values','Recent estimate'};
        
        % Create the uitable
        tTxt = uicontrol('style','text');
        set(tTxt,'String','Estimation Results',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[160 140 620 50]);%160 170 600 50
%         table_x=120;
%         table_y=50;
        table_t = uitable(f5,'Data',test_d5,...
            'ColumnName',cnames,... 
            'ColumnWidth',{105 105 105 80},...
            'RowName',rnames);
        table_t.FontName='Times New Roman';
        table_t.FontSize=16;
        table_t.Position(1) = table_x;
        table_t.Position(2) = table_y;
        table_t.Position(3) = table_t.Extent(3);
        table_t.Position(4) = table_t.Extent(4);
        %table ends
        
        
         mTextBox = uicontrol('style','text');
        set(mTextBox,'String','2016 Copyright: S.M.M. Alavi, S.M. Goetz, A.V. Peterchev, Brain Stimulation Engineering Lab (BSEL), Duke University',...
            'HorizontalAlignment','left',...
            'FontSize',14,...
            'Position',[120 0 800 50]);
        
      mTextBox = uicontrol('style','text');
        set(mTextBox,'String','(b-a)      ',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[480 80 200  225]);
        
        
        mTextBox = uicontrol('style','text');
        set(mTextBox,'String','Model: y = a+---------------',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[360 65 200 220]);
        
        
        mTextBox = uicontrol('style','text');
        set(mTextBox,'String','    (1+10^((c-x)*d))          ',...
            'HorizontalAlignment','left',...
             'FontSize',16,...
            'Position',[430 45 200 220]);
        

   
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigFIMv2'  num2str(MCsim) '.gif'];
        imwrite(imind,cm,gif_path,'gif','WriteMode','overwrite', 'Loopcount',inf, 'DelayTime',dataset_plot_delay);
        
     %%%%%%%%%%%%
     figure(2)
     %%%%%%%%%%%%%%
        %title('Input-Output curve estimation in transcranial magnetic stimulation')
%         fig1_r=10;
%         fig1_c=9;
%         
        f2=gcf;
        set(f2, 'Position', [400 50 1400 900]);%,...
        
        
        %%%%%%
        % uniform plot
        %%%%%%% 
        %fwdth=4;
        subplot(fig1_r,fig1_c,[1:1+fwdth,14:14+fwdth,27:27+fwdth,40:40+fwdth,53:53+fwdth,66:66+fwdth,79:79+fwdth]);   
        
       plot(x_dg,myy(MCsim,:),'x','Color', [0.5 0.5 0.5]);
        %plot(x_dg,logyt_m,'o','Color', 'b');
        hold on
        plot(xval,10.^myy_true_4par(MCsim,:),'k','LineWidth',1);
        %axis([0 1 0 2]);
        xlabel('Input: x')
        ylabel('Output: y')
        title('Uniform SPE')
        ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 18;
        ax1.XLim=[0 1.2]
         ax1.YScale='log'

        
        
         %%%%%%%%
        % uniform table
        %%%%%%%%
        test_d2=[theta_true';%zeros(1,2);
           zeros(1,4)];
        % Create the column and row names in cell arrays 
        %cnames = {'Mean','Variance'};
        rnames = {'True Values','Recent Estimate'};
        
        % Create the uitable
        tTxt = uicontrol('style','text');
        set(tTxt,'String','Estimation Results',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[160 140 620 50]);
%         table_x=120;
%         table_y=50;
        table_t = uitable(f2,'Data',test_d2,...
            'ColumnName',cnames,... 
            'ColumnWidth',{105 105 105 80},...
            'RowName',rnames);
        table_t.FontName='Times New Roman';
        table_t.FontSize=16;
        table_t.Position(1) = table_x;
        table_t.Position(2) = table_y;
        table_t.Position(3) = table_t.Extent(3);
        table_t.Position(4) = table_t.Extent(4);
        %table ends
        
         mTextBox = uicontrol('style','text');
        set(mTextBox,'String','2016 Copyright: S.M.M. Alavi, S.M. Goetz, A.V. Peterchev, Brain Stimulation Engineering Lab (BSEL), Duke University',...
            'HorizontalAlignment','left',...
            'FontSize',14,...
            'Position',[120 0 800 50]);
        
        
         mTextBox = uicontrol('style','text');
        set(mTextBox,'String','(b-a)      ',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[480 80 200  225]);
        
        
        mTextBox = uicontrol('style','text');
        set(mTextBox,'String','Model: y = a+---------------',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[360 65 200 220]);
        
        
        mTextBox = uicontrol('style','text');
        set(mTextBox,'String','    (1+10^((c-x)*d))          ',...
            'HorizontalAlignment','left',...
             'FontSize',16,...
            'Position',[430 45 200 220]);
        
       
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigUni'  num2str(MCsim) '.gif'];
        imwrite(imind,cm,gif_path,'gif','WriteMode','overwrite', 'Loopcount',inf, 'DelayTime',dataset_plot_delay);
        
   
        %%%%%%%%%%%%%%%%
        figure(3)
        %%%%%%%%%%%%%%%%
      
       
        f3=gcf;
        set(f3, 'Position', [400 50 1400 900]);%,...
        
        
        %%%%%%
        % uniform-FIM plot
        %%%%%%% 
        %fwdth=4;
        subplot(fig1_r,fig1_c,[1:1+fwdth,14:14+fwdth,27:27+fwdth,40:40+fwdth,53:53+fwdth,66:66+fwdth,79:79+fwdth]);   
        
        plot(x_dg,myy(MCsim,:),'x','Color', [0.5 0.5 0.5]);
        %plot(x_dg,logyt_m,'o','Color', 'b');
        hold on
        plot(xval,10.^myy_true_4par(MCsim,:),'k','LineWidth',1);
        %axis([0 1 0 2]);
        xlabel('Input: x')
        ylabel('Output: y')
        title('Uniform and FIM SPE')
        ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 18;
        ax1.XLim=[0 1.2]
         ax1.YScale='log'

        
        
         %%%%%%%%
        % uniform-FIM table
        %%%%%%%%
        test_d3=[theta_true';zeros(1,4);
           zeros(1,4)];
        % Create the column and row names in cell arrays 
        %cnames = {'Mean','Variance'};
        rnames = {'True Values','Uniform SPE','FIM SPE'};
        
        % Create the uitable
        tTxt = uicontrol('style','text');
        set(tTxt,'String','Estimation Results',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[160 160 620 50]);
%         table_x=120;
%         table_y=50;
        table_t = uitable(f3,'Data',test_d3,...
            'ColumnName',cnames,... 
            'ColumnWidth',{105 105 105 80},...
            'RowName',rnames);
        table_t.FontName='Times New Roman';
        table_t.FontSize=16;
        table_t.Position(1) = table_x;
        table_t.Position(2) = table_y;
        table_t.Position(3) = table_t.Extent(3);
        table_t.Position(4) = table_t.Extent(4);
        %table ends
        
         mTextBox = uicontrol('style','text');
        set(mTextBox,'String','2016 Copyright: S.M.M. Alavi, S.M. Goetz, A.V. Peterchev, Brain Stimulation Engineering Lab (BSEL), Duke University',...
            'HorizontalAlignment','left',...
            'FontSize',14,...
            'Position',[120 0 800 50]);
        
     mTextBox = uicontrol('style','text');
        set(mTextBox,'String','(b-a)      ',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[480 80 200  225]);
        
        
        mTextBox = uicontrol('style','text');
        set(mTextBox,'String','Model: y = a+---------------',...
            'HorizontalAlignment','left',...
            'FontSize',16,...
            'Position',[360 65 200 220]);
        
        
        mTextBox = uicontrol('style','text');
        set(mTextBox,'String','    (1+10^((c-x)*d))          ',...
            'HorizontalAlignment','left',...
             'FontSize',16,...
            'Position',[430 45 200 220]);
        
       
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigUniFIM'  num2str(MCsim) '.gif'];
        imwrite(imind,cm,gif_path,'gif','WriteMode','overwrite', 'Loopcount',inf, 'DelayTime',dataset_plot_delay);
        
   
        
    end

        %% tune some parameters
        
        xid_comp_plot=zeros(total_no_iterations,total_no_iterations);
        yid_comp_plot=zeros(total_no_iterations,total_no_iterations);
        
        
        success_stop=0;
        sucess_flag=0;
        % FIM case
        xid=[];
        yid=[];
        yest_val=[];
        fit_modification_flag=[];
   
       
        % Uniform selection case
        xid_m2=[];
        yid_m2=[];
        yest_val_m2=[];
        fit_modification_flag_m2=[];
        delta_x=(xid_max-xid_min)/total_no_iterations;
      
        
        rtheta_converge_flag(1:4)=zeros(1,no_of_parameters);
        %iter_rtheta_converged=[];
        
        rtheta_converge_flag_comp(1:4)=zeros(1,no_of_parameters);
        %iter_rtheta_converged_comp=[];
        
        iter_rtheta_converged1=[];
        iter_rtheta_converged_comp1=[];
        iter_rtheta_converged2=[];
        iter_rtheta_converged_comp2=[];
        iter_rtheta_converged3=[];
        iter_rtheta_converged_comp3=[];
        iter_rtheta_converged4=[];
        iter_rtheta_converged_comp4=[];
        iter_rtheta_converged5=[];
        iter_rtheta_converged_comp5=[];
        
        %opt_method=input('optimization method (0 Genetic Algorithm | 1 GlobalSearch-default | 2 MultiStart) =') ;       
        %if length(opt_method) == 0
            opt_method=1;
        %end
      
        %% update the FIM animation figure
        
        if plot_animation == 1
            SS_plot_baseline_fim;
            SS_plot_baseline_uni;
            SS_plot_baseline_uni_fim;
        end
        
        %% --> collect initial data
        %=========================
        %no_ini_samples_fim=10; 
        %xid_ini=xid_min:(xid_max-xid_min)/(no_ini_samples_fim-1):xid_max;
        
        xid_ini=(xid_min+0.1 + (xid_max-(xid_min+0.1))*rand(1,no_ini_samples_fim));
       
      
        
         n=length(xid_ini);
      
         % FIM method
         %--------------
            SS_ini_FIM;
            
            % estimations of theta
            theta1_F(MCsim,n)=theta_est(n,1);
            theta2_F(MCsim,n)=theta_est(n,2);
            theta3_F(MCsim,n)=theta_est(n,3);
            theta4_F(MCsim,n)=theta_est(n,4);
         
            % compute errors
            er_theta1_F(MCsim,n)=er_theta(n,1);
            er_theta2_F(MCsim,n)=er_theta(n,2);
            er_theta3_F(MCsim,n)=er_theta(n,3);
            er_theta4_F(MCsim,n)=er_theta(n,4);
                       
%             log_ey_FIM(MCsim,n)=sum((10.^yest_val(n,:)-10.^myy_true_4par(MCsim,:)).^2);
%             eyprime_FIM(MCsim,n)=sum((yprime_est_val(n,:)-my_yprime_true(MCsim,:)).^2);
%             
            log_ey_FIM(MCsim,n)=sum(abs(10.^yest_val(n,:)-10.^myy_true_4par(MCsim,:))./abs(10.^myy_true_4par(MCsim,:)));
            eyprime_FIM(MCsim,n)=sum(abs(yprime_est_val(n,:)-my_yprime_true(MCsim,:))./abs(my_yprime_true(MCsim,:)));
            
          % Uniform method  
          %-----------------------
          SS_ini_comp;
          
          % estimation of theta
          theta1_U(MCsim,n)=theta_est_comp(n,1);
          theta2_U(MCsim,n)=theta_est_comp(n,2);
          theta3_U(MCsim,n)=theta_est_comp(n,3);
          theta4_U(MCsim,n)=theta_est_comp(n,4);
          
          % compute errors
          er_theta1_U(MCsim,n)=er_theta_comp(n,1);
          er_theta2_U(MCsim,n)=er_theta_comp(n,2);
          er_theta3_U(MCsim,n)=er_theta_comp(n,3);
          er_theta4_U(MCsim,n)=er_theta_comp(n,4);
          
          % log_ey_uniform(MCsim,n)=sum((10.^yest_val_comp(n,:)-10.^myy_true_4par(MCsim,:)).^2);  
          % eyprime_uniform(MCsim,n)=sum((yprime_est_val_comp(n,:)-my_yprime_true(MCsim,:)).^2);
            
          log_ey_uniform(MCsim,n)=sum(abs(10.^yest_val_comp(n,:)-10.^myy_true_4par(MCsim,:))./abs(10.^myy_true_4par(MCsim,:)));   
          eyprime_uniform(MCsim,n)=sum(abs(yprime_est_val_comp(n,:)-my_yprime_true(MCsim,:))./(my_yprime_true(MCsim,:)));
          
             
          % update animation 
          if plot_animation == 1
            SS_plot_comp_Univ_FIM;
          end
         
        %% next iterations
        %========================
        for n=no_ini_samples_fim+1:no_ini_samples_fim+no_next_iter
           
           MCsim
            n     

           
            % FIM Method
            % -------------
            SS_nextiter_FIM_ModifiedCost;
            % estimations of theta
            theta1_F(MCsim,n)=theta_est(n,1);
            theta2_F(MCsim,n)=theta_est(n,2);
            theta3_F(MCsim,n)=theta_est(n,3);
            theta4_F(MCsim,n)=theta_est(n,4);
            % compute error
            er_theta1_F(MCsim,n)=er_theta(n,1);
            er_theta2_F(MCsim,n)=er_theta(n,2);
            er_theta3_F(MCsim,n)=er_theta(n,3);
            er_theta4_F(MCsim,n)=er_theta(n,4);
            
            %log_ey_FIM(MCsim,n)=sum((10.^yest_val(n,:)-10.^myy_true_4par(MCsim,:)).^2);
            %eyprime_FIM(MCsim,n)=sum((yprime_est_val(n,:)-my_yprime_true(MCsim,:)).^2);
            
            log_ey_FIM(MCsim,n)=sum(abs(10.^yest_val(n,:)-10.^myy_true_4par(MCsim,:))./abs(10.^myy_true_4par(MCsim,:)));
            eyprime_FIM(MCsim,n)=sum(abs(yprime_est_val(n,:)-my_yprime_true(MCsim,:))./abs(my_yprime_true(MCsim,:)));
            
            % check convergence
            SS_stopping_rtheta;
            
            
                        
            % Unifrom sampling Method
            % -------------
         
             SS_nextiter_comp;
             % estimations of theta
             theta1_U(MCsim,n)=theta_est_comp(n,1);
             theta2_U(MCsim,n)=theta_est_comp(n,2);
             theta3_U(MCsim,n)=theta_est_comp(n,3);
             theta4_U(MCsim,n)=theta_est_comp(n,4);
             
             % compute error
             er_theta1_U(MCsim,n)=er_theta_comp(n,1);
             er_theta2_U(MCsim,n)=er_theta_comp(n,2);
             er_theta3_U(MCsim,n)=er_theta_comp(n,3);
             er_theta4_U(MCsim,n)=er_theta_comp(n,4);
             
             %log_ey_uniform(MCsim,n)=sum((10.^yest_val_comp(n,:)-10.^myy_true_4par(MCsim,:)).^2);   
             %eyprime_uniform(MCsim,n)=sum((yprime_est_val_comp(n,:)-my_yprime_true(MCsim,:)).^2);
          
             log_ey_uniform(MCsim,n)=sum(abs(10.^yest_val_comp(n,:)-10.^myy_true_4par(MCsim,:))./abs(10.^myy_true_4par(MCsim,:)));   
             eyprime_uniform(MCsim,n)=sum(abs(yprime_est_val_comp(n,:)-my_yprime_true(MCsim,:))./(my_yprime_true(MCsim,:)));
          
             
             % check convergence
             SS_stopping_rtheta_comp;
             
        
         % update animation 
         if plot_animation == 1
            SS_plot_comp_Univ_FIM;
         end
         
         
         
%             if length(iter_rtheta_converged5)~=0 && length(iter_rtheta_converged_comp5)~=0
% 
%                     break; % break the iterations 
%                             
%                 
%             end
           
        end % end iterations
        
                x_FIM_all_runs(MCsim,1:length(xid_paper))=xid_paper;
                y_FIM_all_runs(MCsim,1:length(xid_paper))=yid_paper;
                
              
                % compute convergence parameters and AREs 
                SS_checkConv_compE_T5;
                
                SS_checkConv_FIM_T5_with_Peak_with_U;
                
                SS_errors_final_iter;
                
                % plot and save the IO curve
                SS_plots_samples_fim_uni_T5;
                SS_plots_samples_fim_uni_T5_with_Peak;
                SS_plots_samples_fim_uni_end;
                % plot and save the theta's versus samples
                SS_plots_theta_fim_uni;
               
 
                % eval &  plot dy/dt
                SS_dydx_evaluation;
                SS_plots_dydx_T5;
                SS_plots_dydx_T5_with_Peak
                SS_plots_dydx_end;
                
                close all;
                
                
                
                mean_e_x_yprime_max_FIM_end=nanmean(e_x_yprime_max_FIM_end);
                mean_e_x_yprime_max_FIM_T5=nanmean(e_x_yprime_max_FIM_T5)
                mean_e_x_yprime_max_FIM_T5_with_Peak=nanmean(e_x_yprime_max_FIM_T5_with_Peak)
                
                mean_e_x_yprime_max_uni_end=nanmean(e_x_yprime_max_uni_end);
                mean_e_x_yprime_max_uni_T5=nanmean(e_x_yprime_max_uni_T5)
                mean_e_x_yprime_max_uni_T5_with_Peak=nanmean(e_x_yprime_max_uni_T5_with_Peak)
                
                mean_e_yprime_max_FIM_end=nanmean(e_yprime_max_FIM_end);
                mean_e_yprime_max_FIM_T5=nanmean(e_yprime_max_FIM_T5)
                mean_e_yprime_max_FIM_T5_with_Peak=nanmean(e_yprime_max_FIM_T5_with_Peak)
                
                mean_e_yprime_max_uni_end=nanmean(e_yprime_max_uni_end);
                mean_e_yprime_max_uni_T5=nanmean(e_yprime_max_uni_T5)
                mean_e_yprime_max_uni_T5_with_Peak=nanmean(e_yprime_max_uni_T5_with_Peak)
                
                
                mean_e_y_yprime_max_FIM_end=nanmean(e_y_yprime_max_FIM_end);
                mean_e_y_yprime_max_FIM_T5=nanmean(e_y_yprime_max_FIM_T5)
                mean_e_y_yprime_max_FIM_T5_with_Peak=nanmean(e_y_yprime_max_FIM_T5_with_Peak)
                
                mean_e_y_yprime_max_uni_end=nanmean(e_y_yprime_max_uni_end);
                mean_e_y_yprime_max_uni_T5=nanmean(e_y_yprime_max_uni_T5)
                mean_e_y_yprime_max_uni_T5_with_Peak=nanmean(e_y_yprime_max_uni_T5_with_Peak)
                
                
                % save the data at the end of Total runs
                if MCsim==Total_runs
                    %save([ 'gfx_new' num2str(folder_index) '/mat/test' num2str(MCsim) '.mat' ]);
                    save([ 'results_F' num2str(kkk) '/test' num2str(MCsim) '.mat' ]);
                end
        
 
       
end
