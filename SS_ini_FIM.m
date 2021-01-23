%==========================================================================
% In this file: Intitialization of the IOCE and SPE methods
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


% given the intial x, xid,
% this file computes the MEP, 
% and integrate them to estimate the intial estimate of theta 
% using the curve fitting algorithm 

            xid=xid_ini;% initial x
            xid_paper=xid;
            xid_new=xid_ini;
           
            % corresponding MEPs
            yid_new(1:n) = virtualsubjectEIVStimulate_01(xid, myp(MCsim,:));%noise will be added in the fitting routine
            yid_paper=yid_new;
            
            
            % sort them 
            xid=sort(xid);
            
            i_xidnew=find(xid_new==xid(1));
            yid(1)=yid_new(i_xidnew);
            
            i_xidnew=find(xid_new==xid(2));
            yid(2)=yid_new(i_xidnew);
            
            i_xidnew=find(xid_new==xid(3));
            yid(3)=yid_new(i_xidnew);
            
            % mix them with baseline data
            xid_cf=[xeq0 xid];
            yid_cf=[yid_xeq0(MCsim,:) yid];

            
            
            % fit
            [xData, yData] = prepareCurveData( xid_cf, log10(yid_cf) );

            ft = fittype( 'a+(b-a)./(1+10^((c-x)*d))', 'independent', 'x', 'dependent', 'y' );
           
            opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
            opts.Display = 'Off';
            pts.Algorithm = 'Trust-Region';
            opts.Lower = paramLB;
            opts.Upper = paramUB;
            opts.Robust ='LAR';
            ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
            opts.StartPoint =ini_guess;           
            
            [fitresult, gof] = fit( xData, yData, ft, opts );
            % get the estimate of the parameters
            theta_est(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
            % compute the errors
            er_theta(n,:)=(theta_est(n,:)-theta_true')./theta_true';
    
            % y_est of the estimate model
            yest_val(n,1:size_val)=theta_est(n,1) + ...
                (theta_est(n,2)-theta_est(n,1)) ./ (1 + 10.^((theta_est(n,3)-xval)*theta_est(n,4)));
             
           yprime_est_val(n,1:size_val)=log(10)*(theta_est(n,2)-theta_est(n,1))*theta_est(n,4)...
                    *10.^((theta_est(n,3)-xval)*theta_est(n,4))...
                    ./(1+10.^((theta_est(n,3)-xval)*theta_est(n,4))).^2;
             
           
            %%%%  Find the x_max which maximizes y'=dy/dx
            x_yprime_max(MCsim,n)=theta_est(n,3);
            yprime_max(MCsim,n)=log(10)*(theta_est(n,2)-theta_est(n,1))*theta_est(n,4)...
                    *10^((theta_est(n,3)-x_yprime_max(MCsim,n))*theta_est(n,4))...
                    /(1+10.^((theta_est(n,3)-x_yprime_max(MCsim,n))*theta_est(n,4)))^2;
            y_yprime_max(MCsim,n)=theta_est(n,1) + ...
                (theta_est(n,2)-theta_est(n,1)) ./ (1 + 10.^((theta_est(n,3)-x_yprime_max(MCsim,n))*theta_est(n,4)));
            
            
            
            %% plot
            
      if plot_animation == 1 
          figure(1)
                    %subplot(3,4,[1,2,5,6]);
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
        
        delete(pnewpoint)
        
        % pdpnt plot data points
        
        
        pdpnts=plot(xeq0,yid_xeq0(MCsim,:),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','none');
        
        pnewpoint=plot(xid,(yid),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','r');
            
        
        
        pnewfit=plot(xval,10.^(yest_val(n,1:end)),...
            'LineStyle','-',...
            'LineWidth',1,...
            'Color','r');
        
      %  AX=legend('data','true model','samples','fit','Location','northeast');%''southeast');

        test_d=[theta_true';theta_est(n-1,:);
           theta_est(n,:)];
        % Create the column and row names in cell arrays 
        % cnames = {'Mean','Variance'};
        rnames = {'True Values','Previous estimate','Current estimate'};
        
        % Create the uitable
%          table_t = uitable(f1,'Data',test_d,...
%             'ColumnName',cnames,... 
%             'RowName',rnames,...
%             'FontName','Times New Roman',...
%             'FontSize',14);
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
        
        % parameters
        subplot(fig1_r,fig1_c,[9:13,22:26]);
        plot([1 n],[theta_true(1),theta_true(1)],'k-','LineWidth',1)
        hold on
        plot(1:n,theta_est(:,1),'r--','LineWidth',1);
        ylab=ylabel('$y_l$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
        title('True Value k-  Estimation r--','fontweight','normal')
        
        ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
        subplot(fig1_r,fig1_c,[48:52,61:65]);
        plot([1 n],[theta_true(2),theta_true(2)],'k-','LineWidth',1)
        hold on
        plot(1:n,theta_est(:,2),'r--','LineWidth',1)
         ylab=ylabel('$y_h$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
         subplot(fig1_r,fig1_c,[87:91,100:104]);
        plot([1 n],[theta_true(3),theta_true(3)],'k-','LineWidth',1)
        hold on
        plot(1:n,theta_est(:,3),'r--','LineWidth',1)
         ylab=ylabel('$m$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
         subplot(fig1_r,fig1_c,[126:130,139:143]);
        plot([1 n],[theta_true(4),theta_true(4)],'k-','LineWidth',1)
        hold on
        plot(1:n,theta_est(:,4),'r--','LineWidth',1)
         ylab=ylabel('$s$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
        
%text(eqx,eqy,str,'Interpreter','latex','FontSize',20)

       
        %%%%%%%%save gif
        
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigFIM'  num2str(MCsim) '.gif'];
        imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',ini_est_plot_delay);%dtime);
        %pause(2);
        
        %% figure v2
        figure(5)
        hold on            %subplot(3,4,[1,2,5,6]);
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
        
        delete(pnewpointv2)
        % pdpnt plot data points
        
        
        pdpntsv2=plot(xeq0,yid_xeq0(MCsim,:),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','none');
        
        pnewpointv2=plot(xid,(yid),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','r');
               
        
        
        pnewfitv2=plot(xval,10.^(yest_val(n,1:end)),...
            'LineStyle','--',...
            'LineWidth',1,...
            'Color','r');
        
        AX=legend('data','true model','samples','fit','Location','southeast');%'northeast');%''southeast');

        test_d=[theta_true';%theta_est(n-1,:);
           theta_est(n,:)];
        % Create the column and row names in cell arrays 
         %cnames = {'Mean','Variance'};
        rnames = {'True Values','Recent estimate'};
        
        % Create the uitable
%          table_t = uitable(f1,'Data',test_d,...
%             'ColumnName',cnames,... 
%             'RowName',rnames,...
%             'FontName','Times New Roman',...
%             'FontSize',14);
        table_t = uitable(f5,'Data',test_d,...
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
        plot([1 n],[theta_true(1),theta_true(1)],'k-','LineWidth',1)
        hold on
        plot(1:n,theta_est(:,1),'r--','LineWidth',1);
        ylab=ylabel('$y_l$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
        title('True Value k-  Estimation r--','fontweight','normal')
        
        ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
        subplot(fig1_r,fig1_c,[48:52,61:65]);
        plot([1 n],[theta_true(2),theta_true(2)],'k-','LineWidth',1)
        hold on
        plot(1:n,theta_est(:,2),'r--','LineWidth',1)
         ylab=ylabel('$y_h$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
         subplot(fig1_r,fig1_c,[87:91,100:104]);
        plot([1 n],[theta_true(3),theta_true(3)],'k-','LineWidth',1)
        hold on
        plot(1:n,theta_est(:,3),'r--','LineWidth',1)
         ylab=ylabel('$m$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
         subplot(fig1_r,fig1_c,[126:130,139:143]);
        plot([1 n],[theta_true(4),theta_true(4)],'k-','LineWidth',1)
        hold on
        plot(1:n,theta_est(:,4),'r--','LineWidth',1)
         ylab=ylabel('$s$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
       
        %%%%%%%%save gif
        
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigFIMv2'  num2str(MCsim) '.gif'];
        imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',ini_est_plot_delay);%dtime);
        %pause(2);
        
      end