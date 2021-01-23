%==========================================================================
% In this file: plot data of FIM- and uniform-based methods
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



figure(3)
  hold on
           %subplot(3,4,[1,2,5,6]);
           %subplot(4,7,[1:4,8:11,15:18,22:25]);
          subplot(fig1_r,fig1_c,[1:1+fwdth,14:14+fwdth,27:27+fwdth,40:40+fwdth,53:53+fwdth,66:66+fwdth,79:79+fwdth]);
         %set(gca, 'YScale', 'log')
           
          %if n >= no_ini_samples_fim
                delete(unipnts)
                delete(FIMpnts)
          %end
           unipnts=plot(xid_comp_cf,(yid_comp_cf),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','^',...
            'MarkerSize',8,...
            'MarkerEdgeColor','b',...
            'MarkerFaceColor','none');
           
        %pause(dtime);
           FIMpnts=plot(xid_cf,(yid_cf),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','none');
            
       % pause(dtime);
        
        if n > no_ini_samples_fim
            delete(Unifit)
            delete(FIMfit)
        end
           
            Unifit=plot(xval,10.^(yest_val_comp(n,1:end)),...
            'LineStyle','--',...
            'LineWidth',1,...
            'Color','b');
        
            FIMfit=plot(xval,10.^(yest_val(n,1:end)),...
            'LineStyle','--',...
            'LineWidth',1,...
            'Color','r');
        
         AX=legend('data','true model','Uniform samples','FIM samples','Uniform SPE','FIM SPE','Location','southeast');%''southeast');

        % data table  
        test_d=[theta_true';theta_est_comp(n,:);
           theta_est(n,:)];
        % Create the column and row names in cell arrays 
          % cnames = {'Mean','Variance'};
        rnames = {'True Values','Uniform SPE','FIM SPE'};
      
        % Create the uitable
       table_t = uitable(f3,'Data',test_d,...
            'ColumnName',cnames,... 
            'ColumnWidth',{105 105 105 80},...
            'RowName',rnames);
        table_t.FontName='Times New Roman';
        table_t.FontSize=16;
        table_t.Position(1) = table_x;
        table_t.Position(2) = table_y;
        table_t.Position(3) = table_t.Extent(3);
        table_t.Position(4) = table_t.Extent(4);
        
        % parameters 
        subplot(fig1_r,fig1_c,[9:13,22:26]);
        plot([1 n],[(theta_true(1)),(theta_true(1))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est(:,1)),'r--','LineWidth',1);
        hold on
        plot(1:n,(theta_est_comp(:,1)),'b--','LineWidth',1);
       ylab=ylabel('$y_l$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        title('True Value k-  FIM r--  Uniform b--','fontweight','normal')
        
        subplot(fig1_r,fig1_c,[48:52,61:65]);
        plot([1 n],[(theta_true(2)),(theta_true(2))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est(:,2)),'r--','LineWidth',1)
        hold on
        plot(1:n,(theta_est_comp(:,2)),'b--','LineWidth',1);
        ylab=ylabel('$y_h$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        
           
        
        subplot(fig1_r,fig1_c,[87:91,100:104]);
        plot([1 n],[(theta_true(3)),(theta_true(3))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est(:,3)),'r--','LineWidth',1)
        hold on
        plot(1:n,(theta_est_comp(:,3)),'b--','LineWidth',1);
       ylab=ylabel('$m$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        
        subplot(fig1_r,fig1_c,[126:130,139:143]);
        plot([1 n],[(theta_true(4)),(theta_true(4))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est(:,4)),'r--','LineWidth',1)
        hold on
        plot(1:n,(theta_est_comp(:,4)),'b--','LineWidth',1);
        ylab=ylabel('$s$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        
        
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
        
        %text(eqx,eqy,str,'Interpreter','latex','FontSize',20)
       
        %SS_figCRB_vs_n;
       
        %%%%%%%%save gif
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigUniFIM'  num2str(MCsim) '.gif'];
        if n-no_ini_samples_fim == 1
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay1);
        elseif n-no_ini_samples_fim < 3 && n-no_ini_samples_fim >1
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay2);
        else
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay3);
        end
        

