%%  This program calculates precipitate strengthening factor for a crystal for the tensile axis orientation along [001],[010] and bisector 

fprintf('Please enter strain condition \n For plane strain input 1 \n For axisymmetric strain inpur 2 \n For any other strain condition enter 3 \n')
 

y = input('');
         
 switch y
     case 1 
             e_ext= [1,0,0;0,0,0;0,0,-1];
     case 2 
             e_ext= [1,0,0;0,-0.5,0;0,0,-0.5]; 
     case 3
             prompt = 'Please enter the external strain matrix : e11 e12 e13 e21 e22 e23 e31 e32 e33\n';
             e_ext = input(prompt);
     otherwise
             warning('Unexpected choice entered. Taylor factor can not be calculated.');
             break;
 end
 
 

fprintf('PLEASE ENTER h k l u v w of the crystal\n')
O= input('');         % crystal_orientation array
XO = sscanf(O,'%f');


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
N_RD = Nxtal_calc(RD,e_ext);
U=t1;
V=t2;
W=t3;
T1=k*W-l*V;
T2=l*U-h*W;
T3=h*V-k*U;

TD = [h,k,l,U,V,W,T1,T2,T3];
N_TD = Nxtal_calc(TD,e_ext);
B=sqrt(U^2+V^2+W^2);    % modulus of uvw vector
 n=sqrt(h^2+k^2+l^2);    % modulus of hkl vector


%% 
 b=sqrt(u^2+v^2+w^2);    % modulus of uvw vector
 n=sqrt(h^2+k^2+l^2);    % modulus of hkl vector
% t=sqrt(t1^2+t2^2+t3^2); % modulus of transverse vector




u= u/b + U/B;
v= v/b + V/B;
w= w/b+ W/B;
t1= k*w-l*v;
t2= l*u-h*w;
t3= h*v-k*u;

RD_45 = [h,k,l,u,v,w,t1,t2,t3];


N_45RD = Nxtal_calc(RD_45,e_ext);
                       
fprintf('N average for RD test = "%f" \n', N_RD)
fprintf('N average for TD test = "%f" \n', N_TD)
fprintf('N average for 45RD test = "%f" \n',N_45RD)
  
