% 
% Copyright (C) 2011-2012 Alex Bikfalvi
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or (at
% your option) any later version.

% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
%
%---------------------
% Changed by SMM Alavi
% 2018
%---------------------

function [q1 q2 q2_medians q3 fu fl ou ol] = quartile(x)

% rank the data
y = sort(x);


% compute 50th percentile (second quartile)
%q2 = ceil(nanmean(y));% When plotting n_f
q2 = (nanmean(y));% When plotting errors
q2_medians = (nanmedian(y));% When plotting errors

% compute 25th percentile (first quartile)
%q1 = ceil(nanmean(y(y<=q2)));% When plotting n_f
q1 = (nanmean(y(y<=q2)));% When plotting errors

% compute 75th percentile (third quartile)
%q3 = ceil(nanmean(y(y>=q2)));% When plotting n_f
q3 = (nanmean(y(y>=q2)));% When plotting errors


% compute Interquartile Range (IQR)
IQR = q3-q1;

 
fl = min(y);%(y>=q1-1.5*IQR));
fu = max(y);%(y<=q3+1.5*IQR));

% ol = y(y<fl);
% ou = y(y>fl);
% 

% fl = min(y(y>=q1-1.5*IQR))
% fu = max(y(y<=q3+1.5*IQR))
% 
% ol = y(y<q1-1.5*IQR);
% ou = y(y>q3+1.5*IQR);

fl = prctile(x,5);
fu = prctile(x,95);

ol = y(y<fl);
ou = y(y>fl);


end