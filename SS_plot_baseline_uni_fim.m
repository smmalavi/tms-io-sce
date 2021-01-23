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
     
           unipnts=plot(xeq0,(yid_xeq0(MCsim,:)),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','^',...
            'MarkerSize',8,...
            'MarkerEdgeColor','b',...
            'MarkerFaceColor','none');
           
        %pause(dtime);
           FIMpnts=plot(xeq0,(yid_xeq0(MCsim,:)),...
            'LineStyle','none',...
            'LineWidth',1,...
            'Marker','o',...
            'MarkerSize',8,...
            'MarkerEdgeColor','r',...
            'MarkerFaceColor','none');
            
        %%%%%%%%save gif
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        gif_path=['gfx' num2str(folder_index) '/gif/FigUniFIM'  num2str(MCsim) '.gif'];
        
            imwrite(imind,cm,gif_path,'gif','WriteMode','append', 'DelayTime',ini_est_plot_delay);
       

