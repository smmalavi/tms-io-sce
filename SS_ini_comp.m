%==========================================================================
% In this file: Intitialization of the uniform-based method
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
     
          xid_comp=xid;% take the same initial data as in FIM-SPE
          yid_comp=yid;
          
          xid_comp_cf=xid_cf;
          yid_comp_cf=yid_cf;
          
          
          theta_est_comp=theta_est; % thus, estimate from the same initial data is also the same  
          er_theta_comp(n,:)=(theta_est_comp(n,:)-theta_true')./theta_true';% The error too           
          yest_val_comp=yest_val;% The validation output too
        
         yprime_est_val_comp=yprime_est_val;
          
           %%%%  Find the x_max which maximizes y'=dy/dx
           x_yprime_max_uni(MCsim,n)=x_yprime_max(MCsim,n);
           yprime_max_uni(MCsim,n)=yprime_max(MCsim,n);
           y_yprime_max_uni(MCsim,n)=y_yprime_max(MCsim,n);
          
comp_flag=1;

          
          
          %% plot
          
          
          if plot_animation == 1
          figure(2)
            hold on;        %subplot(3,4,[1,2,5,6]);
          %subplot(4,7,[1:4,8:11,15:18,22:25]);
         subplot(fig1_r,fig1_c,[1:1+fwdth,14:14+fwdth,27:27+fwdth,40:40+fwdth,53:53+fwdth,66:66+fwdth,79:79+fwdth]);   
         %set(gca, 'YScale', 'log');
%         
%         ax1=gca;
%         grid on
%         ax1.FontName = 'Times New Roman';
%         ax1.FontSize = 20;
% 
%         % x axis
%         ax1.XLabel.String = 'x';
%         ax1.YLabel.String = 'logy';
%         ax1.TickLength = [0.02 0.02];
        
        hold on
        % pdpnt plot data points
        delete(pnewpoint_comp);
        
        
                       
        pnewpoint_comp=plot(xid_comp_cf,yid_comp_cf,...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','^',...
            'MarkerSize',8,...
            'MarkerEdgeColor','b',...
            'MarkerFaceColor','none');
        
        pnewfit_comp=plot(xval,10.^yest_val_comp(n,1:end),...
            'LineStyle','--',...
            'LineWidth',1,...
            'Color','b');
        
       AX=legend('data','true model','samples','fit','Location','southeast');%''southeast');

        test_d=[theta_true';%theta_est_comp(n-1,:);
           theta_est_comp(n,:)];
        % Create the column and row names in cell arrays 
        % cnames = {'Mean','Variance'};
        rnames = {'True Values','Recent estimate'};
        
        % Create the uitable
%          table_t = uitable(f1,'Data',test_d,...
%             'ColumnName',cnames,... 
%             'RowName',rnames,...
%             'FontName','Times New Roman',...
%             'FontSize',14);
        table_t = uitable(f2,'Data',test_d,...
            'ColumnName',cnames,... 
            'ColumnWidth',{105 105 105 80},...
            'RowName',rnames);
        table_t.FontName='Times New Roman';
        table_t.FontSize=14;
        table_t.Position(1) = table_x;
        table_t.Position(2) = table_y;
        table_t.Position(3) = table_t.Extent(3);
        table_t.Position(4) = table_t.Extent(4);
        
        % parameters

         subplot(fig1_r,fig1_c,[9:13,22:26]);
        plot([1 n],[(theta_true(1)),(theta_true(1))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est_comp(:,1)),'r--','LineWidth',1);
        ylab=ylabel('$y_l$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
        title('True Value k-  Estimation r--','fontweight','normal')
        
        ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
        subplot(fig1_r,fig1_c,[48:52,61:65]);
        plot([1 n],[(theta_true(2)),(theta_true(2))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est_comp(:,2)),'r--','LineWidth',1)
         ylab=ylabel('$y_h$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
         subplot(fig1_r,fig1_c,[87:91,100:104]);
        plot([1 n],[(theta_true(3)),(theta_true(3))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est_comp(:,3)),'r--','LineWidth',1)
         ylab=ylabel('$m$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
         subplot(fig1_r,fig1_c,[126:130,139:143]);
        plot([1 n],[(theta_true(4)),(theta_true(4))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est_comp(:,4)),'r--','LineWidth',1)
         ylab=ylabel('$s$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        %SS_figCRB_vs_n;
        
        
        
                
        
       %text(eqx,eqy,str,'Interpreter','latex','FontSize',20)
        %%%%%%%%save gif
        
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigUni'  num2str(MCsim) '.gif'];
        imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',ini_est_plot_delay);%dtime);
        %pause(2);
  
      end