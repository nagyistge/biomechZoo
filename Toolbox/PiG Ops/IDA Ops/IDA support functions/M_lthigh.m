function M_prox =M_lthigh(Fd, Fp, Md, jd,jp,COM,I,omega,alpha,G_S)


%   M_ANKLE determines the moment at the ankle
%
%   ARGUMENTS
%
%   Fd    ... Distal force 
%   Fp    ... Proximal force 
%   Md    ... Moment at distal joint
%   jd     ...joint center of distal joint
%   jp     ...joint center of proximal joint
%   I     ... Moment of interia  
%   Euler     ... euler angles
%   segment   ... local coordinate system
%   G_S   ... Grood and suntay angles (i,k,l)




%--------MOMENT ARMS-------

rd = jd-COM;     
rp = jp-COM;


M_fdis = cross(rd,Fd,2);      %moment due to Fdis
M_fprox =cross(rp,Fp,2);      %moment due to fprox                       
                              


%-------RESIDUAL MOMENTS-----



M_res = -Md - M_fdis + M_fprox;  


%--------RATE OF CHANGE OF ANGULAR MOMENTUM----
% 
% omega = ang_velocity(Euler);
% alpha = ang_acc(Euler);

Ldot = rate_of_change_momentum (I, omega, alpha);

%-------MOMENTS AT ANKLE in XYZ------

% i =segment.i;           %coming from LKIN
% j =segment.j;
% k =segment.k;
% 
% 
% 
% M_segment_X = Ldot(:,1) - dot(i,M_res,2);
% M_segment_Y = Ldot(:,2) - dot(j,M_res,2);
% M_segment_Z = Ldot(:,3) - dot(k,M_res,2);
% 
% M_segment_XYZ = [M_segment_X M_segment_Y M_segment_Z];



M_hip_XYZ = Ldot-M_res;


%-----------MOMENTS IN ANATOMICAL USING GROOD%SUNTAY--------

i_dis = G_S.i;
k_prox = G_S.k;
l_joint = G_S.l;

M_hip_int_ext = dot(-1*M_hip_XYZ,i_dis,2);
M_hip_flx_ext = dot(-1*M_hip_XYZ,k_prox,2);
M_hip_abd_add = dot(M_hip_XYZ,l_joint,2);


M_hip_Anatomical = [ M_hip_flx_ext M_hip_abd_add M_hip_int_ext];

%--------CREATE MATRIX of XYZ and G&S---------

M_prox = [M_hip_XYZ M_hip_Anatomical];