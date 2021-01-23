%==========================================================================
% In this file: computation of Fisher Information Matrix (FIM)  
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


function [y,FIM] = SSfim_cost_modified(n0,n,x,xid,theta,sigma_y,z)

    % partial derivatives
    Si2nm1=1./(1+10.^((theta(3)-xid)*theta(4)));
    Si3nm1=-(theta(2)-theta(1))*theta(4)*10.^((theta(3)-xid)*theta(4)).*Si2nm1.^2*log(10);
    Si4nm1=-(theta(2)-theta(1))*(theta(3)-xid).*10.^((theta(3)-xid)*theta(4)).*Si2nm1.^2*log(10);
        
    % F_n(x_{1:n})
    FIMnm1=[
              dot(Si2nm1,Si2nm1) dot(Si2nm1,Si3nm1) dot(Si2nm1,Si4nm1);
              dot(Si3nm1,Si2nm1) dot(Si3nm1,Si3nm1) dot(Si3nm1,Si4nm1);
              dot(Si4nm1,Si2nm1) dot(Si4nm1,Si3nm1) dot(Si4nm1,Si4nm1)];
    
       
    if z==0
        FIM=FIMnm1;
        y=-det(FIM);
    else
    Sn2=1./(1+10^((theta(3)-x)*theta(4)));
    Sn3=-(theta(2)-theta(1))*theta(4)*10^((theta(3)-x)*theta(4))*Sn2^2*log(10);
    Sn4=-(theta(2)-theta(1))*(theta(3)-x)*10^((theta(3)-x)*theta(4))*Sn2^2*log(10);
    
    % deltaF_{n+1}(x_{n+1})
        FIMn=[
              dot(Sn2,Sn2) dot(Sn2,Sn3) dot(Sn2,Sn4);
              dot(Sn3,Sn2) dot(Sn3,Sn3) dot(Sn3,Sn4);
              dot(Sn4,Sn2) dot(Sn4,Sn3) dot(Sn4,Sn4)];  
    
    % sum them up     
        FIM=(FIMnm1+FIMn);
       
        if n>n0+1
            y=-det(FIM);
        else
            y=-det(FIM);
        end
    
        
    end

