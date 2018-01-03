%Single Crystal Function


function [M_RD, M_TD, M_45RD] = single_crystal_function(e_ext)


global Co;
%%  Reading the crystal orientation {hkl} uvw and Creating the orientation of RD, TD and 45RD directions


fprintf('PLEASE ENTER h k l u v w of the crystal\n')
O= input('');         % crystal_orientation array
XO = sscanf(O,'%d');


h=XO(1);
k=XO(2);
l=XO(3);
u=XO(4);
v=XO(5);
w=XO(6);
t1=k*w-l*v;
t2=l*u-h*w;
t3=h*v-k*u;
RD = [h,k,l,u,v,w,t1,t2,t3];
A = singleX_DC_function(RD)  ;  
[e_xtal]= transform_e_function(e_ext,A);
[Wmax]  = maxwork_function(e_xtal);
M_RD=Co*Wmax;

% for TD

u=t1;
v=t2;
w=t3;
t1=k*w-l*v;
t2=l*u-h*w;
t3=h*v-k*u;
TD = [h,k,l,u,v,w,t1,t2,t3];
A = singleX_DC_function(TD);    
[e_xtal]= transform_e_function(e_ext,A);
[Wmax]  = maxwork_function(e_xtal);
M_TD = Co*Wmax;

%for 45RD

b=sqrt(RD(4)^2+RD(5)^2+RD(6)^2);    % modulus of uvw vector
t=sqrt(RD(7)^2+RD(8)^2+RD(9)^2); % modulus of transverse vector


u=RD(4)/b+RD(7)/t;
v=RD(5)/b+RD(8)/t;
w=RD(6)/b+RD(9)/t;
t1=k*w-l*v;
t2=l*u-h*w;
t3=h*v-k*u;
RD45 = [h,k,l,u,v,w,t1,t2,t3];
A = singleX_DC_function(RD45);    
[e_xtal]= transform_e_function(e_ext,A);
[Wmax]  = maxwork_function(e_xtal);
M_45RD=Co*Wmax;
    


end
