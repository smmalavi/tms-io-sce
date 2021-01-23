%==========================================================================
% In this file: uniform-based method (after initialization)
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


    % get inputs (uniformly distributed)
    xid_comp=xid_min:(xid_max-xid_min)/(n-1):xid_max;
    
    % get the MEPs
    yid_comp(1:n)= virtualsubjectEIVStimulate_01(xid_comp, myp(MCsim,:));
     
   
    xid_comp_plot(n,1:length(xid_comp))=xid_comp;
    yid_comp_plot(n,1:length(xid_comp))=yid_comp;
    
    % integarte them with baseline data
    xid_comp_cf=[xeq0 xid_comp];
    yid_comp_cf=[yid_xeq0(MCsim,:) yid_comp];
    
    % curve fitting
    [xData, yData] = prepareCurveData( xid_comp_cf, log10(yid_comp_cf) );

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
           
            % estimate of parameters
            theta_est_comp(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];

            %%%%% =====>fitting improvement 
            
            % --> avoid saturation
            
             if abs(theta_est_comp(n,1) -paramLB(1))<sac ||  abs(theta_est_comp(n,2)-paramLB(2))<sac || abs(theta_est_comp(n,3) -paramLB(3))<sac3 ||  abs(theta_est_comp(n,4)-paramLB(4))<sac ||  abs(theta_est_comp(n,1) -paramUB(1))<sac ||  abs(theta_est_comp(n,2)-paramUB(2))<sac || abs(theta_est_comp(n,3) -paramUB(3))<sac3 ||  abs(theta_est_comp(n,4)-paramUB(4))<sac
                    ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                    opts.StartPoint =ini_guess;           
                    [fitresult, gof] = fit( xData, yData, ft, opts );
                    theta_est_comp(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                    
                    if abs(theta_est_comp(n,1) -paramLB(1))<sac ||  abs(theta_est_comp(n,2)-paramLB(2))<sac || abs(theta_est_comp(n,3) -paramLB(3))<sac3 ||  abs(theta_est_comp(n,4)-paramLB(4))<sac ||  abs(theta_est_comp(n,1) -paramUB(1))<sac ||  abs(theta_est_comp(n,2)-paramUB(2))<sac || abs(theta_est_comp(n,3) -paramUB(3))<sac3 ||  abs(theta_est_comp(n,4)-paramUB(4))<sac
                        ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                        opts.StartPoint =ini_guess;           
                        [fitresult, gof] = fit( xData, yData, ft, opts );
                        theta_est_comp(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                    
                    end
             end
            % er_theta_comp(n,:)=(theta_est_comp(n,:)-theta_true')./theta_true';
            % <-- end avoid saturation
            
            
            
            
            if n>10%no_ini_samples_fim+3
                %theta_est_ave_comp(n,:)=1/3.*(theta_est_comp(n-1,:)+theta_est_comp(n-2,:)+theta_est_comp(n-3,:));
                theta_est_ave_comp(n,:)=theta_est_comp(n-1,:);
                er_a_abs_ave_comp(MCsim,n)=abs(abs(theta_est_comp(n,1))-abs(theta_est_ave_comp(n,1)));
                er_b_abs_ave_comp(MCsim,n)=abs(abs(theta_est_comp(n,2))-abs(theta_est_ave_comp(n,2)));
                er_c_abs_ave_comp(MCsim,n)=abs(abs(theta_est_comp(n,3))-abs(theta_est_ave_comp(n,3)));
                er_d_abs_ave_comp(MCsim,n)=abs(abs(theta_est_comp(n,4))-abs(theta_est_ave_comp(n,4)));
            
            
                if er_a_abs_ave_comp(MCsim,n) > fmr || er_b_abs_ave_comp(MCsim,n) > fmr || er_c_abs_ave_comp(MCsim,n) > fmr3 || er_d_abs_ave_comp(MCsim,n) > fmr
                    ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                    opts.StartPoint =ini_guess;           
                    [fitresult, gof] = fit( xData, yData, ft, opts );
                    theta_est_comp(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                    er_a_abs_ave2_comp(MCsim,n)=abs(abs(theta_est_comp(n,1))-abs(theta_est_ave_comp(n,1)));
                    er_b_abs_ave2_comp(MCsim,n)=abs(abs(theta_est_comp(n,2))-abs(theta_est_ave_comp(n,2)));
                    er_c_abs_ave2_comp(MCsim,n)=abs(abs(theta_est_comp(n,3))-abs(theta_est_ave_comp(n,3)));
                    er_d_abs_ave2_comp(MCsim,n)=abs(abs(theta_est_comp(n,4))-abs(theta_est_ave_comp(n,4)));
                    
                    if er_a_abs_ave2_comp(MCsim,n) > fmr || er_b_abs_ave2_comp(MCsim,n) > fmr || er_c_abs_ave2_comp(MCsim,n) > fmr3 || er_d_abs_ave2_comp(MCsim,n) > fmr
                        ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                        opts.StartPoint =ini_guess;           
                        [fitresult, gof] = fit( xData, yData, ft, opts );
                        theta_est_comp(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                        er_a_abs_ave3_comp(MCsim,n)=abs(abs(theta_est_comp(n,1))-abs(theta_est_ave_comp(n,1)));
                        er_b_abs_ave3_comp(MCsim,n)=abs(abs(theta_est_comp(n,2))-abs(theta_est_ave_comp(n,2)));
                        er_c_abs_ave3_comp(MCsim,n)=abs(abs(theta_est_comp(n,3))-abs(theta_est_ave_comp(n,3)));
                        er_d_abs_ave3_comp(MCsim,n)=abs(abs(theta_est_comp(n,4))-abs(theta_est_ave_comp(n,4)));
                        
                        if er_a_abs_ave3_comp(MCsim,n) > fmr || er_b_abs_ave3_comp(MCsim,n) > fmr || er_c_abs_ave3_comp(MCsim,n) > fmr3 || er_d_abs_ave3_comp(MCsim,n) > fmr
                            ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                            opts.StartPoint =ini_guess;           
                            [fitresult, gof] = fit( xData, yData, ft, opts );
                            theta_est_comp(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                            er_a_abs_ave4_comp(MCsim,n)=abs(abs(theta_est_comp(n,1))-abs(theta_est_ave_comp(n,1)));
                            er_b_abs_ave4_comp(MCsim,n)=abs(abs(theta_est_comp(n,2))-abs(theta_est_ave_comp(n,2)));
                            er_c_abs_ave4_comp(MCsim,n)=abs(abs(theta_est_comp(n,3))-abs(theta_est_ave_comp(n,3)));
                            er_d_abs_ave4_comp(MCsim,n)=abs(abs(theta_est_comp(n,4))-abs(theta_est_ave_comp(n,4)));
                            
                            if er_a_abs_ave4_comp(MCsim,n) > fmr || er_b_abs_ave4_comp(MCsim,n) > fmr || er_c_abs_ave4_comp(MCsim,n) > fmr3 || er_d_abs_ave4_comp(MCsim,n) > fmr
                                ini_guess=paramLB+ (paramUB-paramLB).*rand(1,4) ; 
                                opts.StartPoint =ini_guess;           
                                [fitresult, gof] = fit( xData, yData, ft, opts );
                                theta_est_comp(n,:)=[fitresult.a fitresult.b fitresult.c fitresult.d];
                            end
                            
                        end
            
                    end
                end
            end
            %%%% <===== end fitting improvement 
            
            

            % omputation of error
            er_theta_comp(n,:)=(theta_est_comp(n,:)-theta_true')./theta_true';
            
        
            % MEP from the estimated model
            yest_val_comp(n,1:size_val)=theta_est_comp(n,1) + ...
                (theta_est_comp(n,2)-theta_est_comp(n,1)) ./ (1 + 10.^((theta_est_comp(n,3)-xval)*theta_est_comp(n,4)));
          
            yprime_est_val_comp(n,1:size_val)=log(10)*(theta_est_comp(n,2)-theta_est_comp(n,1))*theta_est_comp(n,4)...
                    *10.^((theta_est_comp(n,3)-xval)*theta_est_comp(n,4))...
                    ./(1+10.^((theta_est_comp(n,3)-xval)*theta_est_comp(n,4))).^2;
            
            %%%%  Find the x_max which maximizes y'=dy/dx
            
            x_yprime_max_uni(MCsim,n)=theta_est_comp(n,3);
            yprime_max_uni(MCsim,n)=log(10)*(theta_est_comp(n,2)-theta_est_comp(n,1))*theta_est_comp(n,4)...
                    *10^((theta_est_comp(n,3)-x_yprime_max_uni(MCsim,n))*theta_est_comp(n,4))...
                    /(1+10.^((theta_est_comp(n,3)-x_yprime_max_uni(MCsim,n))*theta_est_comp(n,4)))^2;
            y_yprime_max_uni(MCsim,n)=theta_est_comp(n,1) + ...
                (theta_est_comp(n,2)-theta_est_comp(n,1)) ./ (1 + 10.^((theta_est_comp(n,3)-x_yprime_max_uni(MCsim,n))*theta_est_comp(n,4)));
            
            
            
comp_flag=1;


     %% plot
     if plot_animation == 1
           figure(2)
           hold on
           %subplot(3,4,[1,2,5,6]);
           %subplot(4,7,[1:4,8:11,15:18,22:25]);
          subplot(fig1_r,fig1_c,[1:1+fwdth,14:14+fwdth,27:27+fwdth,40:40+fwdth,53:53+fwdth,66:66+fwdth,79:79+fwdth]);
         %set(gca, 'YScale', 'log')
           delete(pnewpoint_comp)
           

           %pause(dtime);
           pnewpoint_comp=plot(xid_comp_cf,(yid_comp_cf),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','^',...
            'MarkerSize',8,...
            'MarkerEdgeColor','b',...
            'MarkerFaceColor','none');
            
       % pause(dtime);
        delete(pnewfit_comp);
          
      
            pnewfit_comp=plot(xval,10.^(yest_val_comp(n,1:end)),...
            'LineStyle','--',...
            'LineWidth',1,...
            'Color','b');
        
         AX=legend('data','true model','samples','fit','Location','southeast');%''southeast');

        % data table  
        test_d=[theta_true';%theta_est_comp(n-1,:);
           theta_est_comp(n,:)];
        % Create the column and row names in cell arrays 
        % cnames = {'Mean','Variance'};
        rnames = {'True Values','Recent estimate'};
        
        % Create the uitable
       table_t = uitable(f2,'Data',test_d,...
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
        
        
        
       
        %%%%%%%%save gif
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigUni'  num2str(MCsim) '.gif'];
        if n-no_ini_samples_fim == 1
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay1);
        elseif n-no_ini_samples_fim < 3 && n-no_ini_samples_fim >1
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay2);
        else
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',next_est_plot_delay3);
        end
        
     end
