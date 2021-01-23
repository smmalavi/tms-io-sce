%==========================================================================
% In this file: Optimal Sampling for IOCE and SCE methods
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


            xidnm1_cf=xid_cf;% to use for plot
            yidnm1_cf=yid_cf;% to use for plot
      
            
            xidnm1=xid;% to use for plot
            yidnm1=yid;% to use for plot
      
          
            
            
if isempty(iter_rtheta_converged5)
     ObjFunc_FIM = @(x) SSfim_cost_modified(no_ini_samples_fim,n,x,xid,theta_est(n-1,:),sigma_y,1);% 
     optsFIM = optimoptions(@fmincon,'Algorithm','interior-point');
                
     problem = createOptimProblem('fmincon','x0',xid_max*rand,...
                    'objective',ObjFunc_FIM,'lb',xid_min,'ub',xid_max,'options',optsFIM);
     [xid_new(n),fval_x(n),flagm_gs,outptm_gs,manyminsm_gs] = run(GlobalSearch,problem);
else
     xid_new(n)=theta_est(n-1,3);
end
            
            
            
            
            
           %add new x to all xid, sort them
           xid=[xid xid_new(end)];
           xid_paper=[xid_paper xid_new(end)];
           xid=sort(xid);
           i_xidnew=find(xid==xid_new(end));
           yid_new(n) = virtualsubjectEIVStimulate_01(xid_new(n), myp(MCsim,:));%noise will be added in the fitting routine
          
           yid_paper=[yid_paper yid_new(n)];
           
           if i_xidnew == 1
               yid=[yid_new(end) yid];
               
           elseif i_xidnew == n
               yid=[yid yid_new(end)];
             
           else
               yidtemp=yid;
               yid=[yidtemp(1:i_xidnew-1) yid_new(end) yidtemp(i_xidnew:end)];
               
           end
         
      
           % add baseline data to all data
           
           xid_cf=[xeq0 xid];
           yid_cf=[yid_xeq0(MCsim,:) yid];
           
           % curve fitting
           [xData, yData] = prepareCurveData( xid_cf, log10(yid_cf));

          
           ft = fittype( 'a+(b-a)./(1+10^((c-x)*d))', 'independent', 'x', 'dependent', 'y' );
           
            opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
            opts.Display = 'Off';
            pts.Algorithm = 'Trust-Region';
            opts.Lower = paramLB;
            opts.Upper = paramUB;
            opts.Robust ='LAR';%'LAR';% 'Bisquare';
            ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
            opts.StartPoint =ini_guess;           
            
            [fitresult, gof] = fit( xData, yData, ft, opts );
           
            % get estimate of data
            theta_est(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
            %%%%% =====>fitting improvement 
            % --> avoid saturation
            
             if abs(theta_est(n,1) - paramLB(1))<sac || abs(theta_est(n,2)-paramLB(2))<sac || abs(theta_est(n,3) - paramLB(3))<sac3 || abs(theta_est(n,4)-paramLB(4))<sac || abs(theta_est(n,1)-paramUB(1))<sac || abs(theta_est(n,2)-paramUB(2))<sac  || abs(theta_est(n,3)-paramUB(3))<sac3 || abs(theta_est(n,4)-paramUB(4))<sac
                    ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                    opts.StartPoint =ini_guess;           
                    [fitresult, gof] = fit( xData, yData, ft, opts );
                    theta_est(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                    
                    if abs(theta_est(n,1) - paramLB(1))<sac || abs(theta_est(n,2)-paramLB(2))<sac || abs(theta_est(n,3) - paramLB(3))<sac3 || abs(theta_est(n,4)-paramLB(4))<sac || abs(theta_est(n,1)-paramUB(1))<sac || abs(theta_est(n,2)-paramUB(2))<sac  || abs(theta_est(n,3)-paramUB(3))<sac3 || abs(theta_est(n,4)-paramUB(4))<sac
                        ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                        opts.StartPoint =ini_guess;           
                        [fitresult, gof] = fit( xData, yData, ft, opts );
                        theta_est(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                    end
             end
        
            
            
            if n>10%no_ini_samples_fim+3
                %theta_est_ave(n,:)=1/3.*(theta_est(n-1,:)+theta_est(n-2,:)+theta_est(n-3,:));
                theta_est_ave(n,:)=theta_est(n-1,:);
                er_a_abs_ave(MCsim,n)=abs(abs(theta_est(n,1))-abs(theta_est_ave(n,1)));
                er_b_abs_ave(MCsim,n)=abs(abs(theta_est(n,2))-abs(theta_est_ave(n,2)));
                er_c_abs_ave(MCsim,n)=abs(abs(theta_est(n,3))-abs(theta_est_ave(n,3)));
                er_d_abs_ave(MCsim,n)=abs(abs(theta_est(n,4))-abs(theta_est_ave(n,4)));
            
            
                if er_a_abs_ave(MCsim,n) > fmr || er_b_abs_ave(MCsim,n) > fmr || er_c_abs_ave(MCsim,n) > fmr3 || er_d_abs_ave(MCsim,n) > fmr
                    ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                    opts.StartPoint =ini_guess;           
                    [fitresult, gof] = fit( xData, yData, ft, opts );
                    theta_est(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                    er_a_abs_ave2(MCsim,n)=abs(abs(theta_est(n,1))-abs(theta_est_ave(n,1)));
                    er_b_abs_ave2(MCsim,n)=abs(abs(theta_est(n,2))-abs(theta_est_ave(n,2)));
                    er_c_abs_ave2(MCsim,n)=abs(abs(theta_est(n,3))-abs(theta_est_ave(n,3)));
                    er_d_abs_ave2(MCsim,n)=abs(abs(theta_est(n,4))-abs(theta_est_ave(n,4)));
                    
                    if er_a_abs_ave2(MCsim,n) > fmr || er_b_abs_ave2(MCsim,n) > fmr || er_c_abs_ave2(MCsim,n) > fmr3 || er_d_abs_ave2(MCsim,n) > fmr
                        ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                        opts.StartPoint =ini_guess;           
                        [fitresult, gof] = fit( xData, yData, ft, opts );
                        theta_est(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                        er_a_abs_ave3(MCsim,n)=abs(abs(theta_est(n,1))-abs(theta_est_ave(n,1)));
                        er_b_abs_ave3(MCsim,n)=abs(abs(theta_est(n,2))-abs(theta_est_ave(n,2)));
                        er_c_abs_ave3(MCsim,n)=abs(abs(theta_est(n,3))-abs(theta_est_ave(n,3)));
                        er_d_abs_ave3(MCsim,n)=abs(abs(theta_est(n,4))-abs(theta_est_ave(n,4)));
                        
                        if er_a_abs_ave3(MCsim,n) > fmr || er_b_abs_ave3(MCsim,n) > fmr || er_c_abs_ave3(MCsim,n) > fmr3 || er_d_abs_ave3(MCsim,n) > fmr
                            ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                            opts.StartPoint =ini_guess;           
                            [fitresult, gof] = fit( xData, yData, ft, opts );
                            theta_est(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                            er_a_abs_ave4(MCsim,n)=abs(abs(theta_est(n,1))-abs(theta_est_ave(n,1)));
                            er_b_abs_ave4(MCsim,n)=abs(abs(theta_est(n,2))-abs(theta_est_ave(n,2)));
                            er_c_abs_ave4(MCsim,n)=abs(abs(theta_est(n,3))-abs(theta_est_ave(n,3)));
                            er_d_abs_ave4(MCsim,n)=abs(abs(theta_est(n,4))-abs(theta_est_ave(n,4)));
                            
                            if er_a_abs_ave4(MCsim,n) > fmr || er_b_abs_ave4(MCsim,n) > fmr || er_c_abs_ave4(MCsim,n) > fmr3 || er_d_abs_ave4(MCsim,n) > fmr
                                ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                                opts.StartPoint =ini_guess;           
                                [fitresult, gof] = fit( xData, yData, ft, opts );
                                theta_est(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                            end
                        
                        end
                    end
                    
            
                end
            end
            %%%%% <===== end fitting improvement 
            

            
            
            % computations of error
            er_theta(n,:)=(theta_est(n,:)-theta_true')./theta_true';
           
            % compute MEP with the estimated model

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
            
            %%%% find y' for all FIM samples
            yprime_FIM_all_runs(MCsim,n)=log(10)*(theta_est(n,2)-theta_est(n,1))*theta_est(n,4)...
                    *10^((theta_est(n,3)-xid_new(n))*theta_est(n,4))...
                    /(1+10.^((theta_est(n,3)-xid_new(n))*theta_est(n,4)))^2;

            
           %% plot
           
           if plot_animation == 1
           figure(1)
           hold on
           %subplot(3,4,[1,2,5,6]);
           %subplot(4,7,[1:4,8:11,15:18,22:25]);
          subplot(fig1_r,fig1_c,[1:1+fwdth,14:14+fwdth,27:27+fwdth,40:40+fwdth,53:53+fwdth,66:66+fwdth,79:79+fwdth]);
         %set(gca, 'YScale', 'log')
           delete(pdpnts)
          % if n > no_ini_samples_fim+1
            delete(pnewpoint)
          % end
           pdpnts=plot(xidnm1_cf,(yidnm1_cf),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',6,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','none');
           
        %pause(dtime);
           pnewpoint=plot(xid_new(end),(yid_new(end)),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','r');
            
       % pause(dtime);
        delete(pnewfit);
        if n > no_ini_samples_fim+1
            delete(poldfit)
        end
           
            poldfit=plot(xval,10.^(yest_val(n-1,1:end)),...
            'LineStyle','--',...
            'LineWidth',1,...
            'Color','r');
        
            pnewfit=plot(xval,10.^(yest_val(n,1:end)),...
            'LineStyle','-',...
            'LineWidth',1,...
            'Color','r');
        
        AX=legend('data','true model','previous samples','new sample','previous fit','new fit','Location','southeast');%''southeast');

        % data table  
        test_d=[theta_true';theta_est(n-1,:);
           theta_est(n,:)];
        % Create the column and row names in cell arrays 
          % cnames = {'Mean','Variance'};
        rnames = {'True Values','Previous estimate','Current estimate'};
      
        % Create the uitable
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
        plot([1 n],[(theta_true(1)),(theta_true(1))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est(:,1)),'r--','LineWidth',1);
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
        plot(1:n,(theta_est(:,2)),'r--','LineWidth',1)
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
        plot(1:n,(theta_est(:,3)),'r--','LineWidth',1)
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
        plot(1:n,(theta_est(:,4)),'r--','LineWidth',1)
         ylab=ylabel('$s$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        
        
     
        %SS_figCRB_vs_n;
       
        %%%%%%%%save gif
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigFIM'  num2str(MCsim) '.gif'];
        if n-no_ini_samples_fim == 1
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay1);
        elseif n-no_ini_samples_fim < 3 && n-no_ini_samples_fim >1
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay2);
        else
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay3);
        end
        

%% figure v2

           figure(5)
           hold on
           %subplot(3,4,[1,2,5,6]);
           %subplot(4,7,[1:4,8:11,15:18,22:25]);
          subplot(fig1_r,fig1_c,[1:1+fwdth,14:14+fwdth,27:27+fwdth,40:40+fwdth,53:53+fwdth,66:66+fwdth,79:79+fwdth]);
         %set(gca, 'YScale', 'log')
           delete(pdpntsv2)
           %if n > no_ini_samples_fim+1
                delete(pnewpointv2)
           %end
           pdpntsv2=plot(xidnm1_cf,(yidnm1_cf),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',6,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','none');
           
        %pause(dtime);
           pnewpointv2=plot(xid_new(end),(yid_new(end)),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','r');
            
       % pause(dtime);
        delete(pnewfitv2);
%         if n > no_ini_samples_fim+1
%             delete(poldfit)
%         end
           
%             poldfit=plot(xval,yest_val(n-1,1:end),...
%             'LineStyle','--',...
%             'LineWidth',1,...
%             'Color','r');
        
            pnewfitv2=plot(xval,10.^(yest_val(n,1:end)),...
            'LineStyle','--',...
            'LineWidth',1,...
            'Color','r');
        
         AX=legend('data','true model','previous samples','new sample','new fit','Location','southeast');%''southeast');

        % data table  
         test_d=[theta_true';%theta_est(n-1,:);
           theta_est(n,:)];
        % Create the column and row names in cell arrays 
         %cnames = {'Mean','Variance'};
        rnames = {'True Values','Recent estimate'};
        
        
        % Create the uitable
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
        plot([1 n],[(theta_true(1)),(theta_true(1))],'k-','LineWidth',1)
        hold on
        plot(1:n,(theta_est(:,1)),'r--','LineWidth',1);
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
        plot(1:n,(theta_est(:,2)),'r--','LineWidth',1)
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
        plot(1:n,(theta_est(:,3)),'r--','LineWidth',1)
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
        plot(1:n,(theta_est(:,4)),'r--','LineWidth',1)
         ylab=ylabel('$s$');
        set(ylab,'interpreter','latex')
        xlabel('Sample')
        %title({'True Value g--';'Estimation r-'},'fontweight','normal')
          ax1=gca;
        ax1.FontName = 'Times New Roman';
        ax1.FontSize = 14;
        %SS_figCRB_vs_n;
       
        %%%%%%%%save gif
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigFIMv2'  num2str(MCsim) '.gif'];
        if n-no_ini_samples_fim == 1
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay1);
        elseif n-no_ini_samples_fim < 3 && n-no_ini_samples_fim >1
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay2);
        else
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay3);
        end
        

           end