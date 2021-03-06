function vout = ctransform(c1,c2,vec)

% vout = CTRANSFORM(c1,c2,vec) will transform a vector from c1 to c2 (T2/1)
%
% ARGUMENTS
%   c1  ... initial coordinate system 3 by 3 matrix rows = i,j,k columns =X,Y,Z
%   c2  ... final coordinate system 3 by 3 matrix rows = i,j,k columns =X,Y,Z
%   vec ... n by 3 matrix in c1 rows = samples; columns X Y Z


% Revision History
%
% Created by JJ Loh ??
%
% Notes
% - Please see Kwon3d for details http://www.kwon3d.com/theory/transform/transform.html



% unit vectors for coordinate system 1
ic1 = c1(1,:);
jc1 = c1(2,:);
kc1 = c1(3,:);

% unit vectors for coordinate system 2
ic2 = c2(1,:);
jc2 = c2(2,:);
kc2 = c2(3,:);

% Transformation matrix
t = [dot(ic1,ic2),dot(ic1,jc2),dot(ic1,kc2);...
     dot(jc1,ic2),dot(jc1,jc2),dot(jc1,kc2);...
     dot(kc1,ic2),dot(kc1,jc2),dot(kc1,kc2)];

if nargin == 3
     vout = vec*t; % orgininal JJ
else
    vout = t;
end


