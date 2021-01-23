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

function c = colorgrad(varargin)

n2 = 4;
t = 'blue_down';

switch length(varargin)
    case 1
        n2 = varargin{1};
    case 2
        n2 = varargin{1};
        t = varargin{2};
end

switch lower(t)
    case 'blue_up'
        c = cat(2,linspace(0,0.6,n2)',linspace(0.2,0.8,n2)',linspace(0.6,1,n2)');
    case 'blue_down'
        c = cat(2,linspace(0.6,0,n2)',linspace(0.8,0.2,n2)',linspace(1,0.6,n2)');
    case 'orange_up'
        c = cat(2,linspace(1,248/255,n2)',linspace(0.6,224/255,n2)',linspace(0,124/255,n2)');
    case 'orange_down'
        c = cat(2,linspace(248/255,1,n2)',linspace(224/255,0.6,n2)',linspace(124/255,0,n2)');
    case 'green_up'
        c = cat(2,linspace(0.2,0.6,n2)',linspace(0.6,1,n2)',linspace(0.2,0.6,n2)');
    case 'green_down'
        c = cat(2,linspace(0.6,0.2,n2)',linspace(1,0.6,n2)',linspace(0.6,0.2,n2)');
    case 'red_up'
        c = cat(2,linspace(.8,1,n2)',linspace(.2,.6,n2)',linspace(.2,.6,n2)');
    case 'red_down'
        c = cat(2,linspace(1,.8,n2)',linspace(.6,.2,n2)',linspace(.6,.2,n2)');
    otherwise
        error('No such color gradient.');
end

end