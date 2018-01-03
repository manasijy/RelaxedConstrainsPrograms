function [N]= Nxtal_calc_function(D,e_ext)



A = singleX_DC_function(D);  

[e]= transform_e_function(e_ext,A);
 en= (e(1,1)^2+e(2,2)^2+e(3,3)^2);
 N1 = sqrt(0.666*en + 0.333*(2*e(2,3))^2);
 N2 = sqrt(0.666*en + 0.333*(2*e(1,3))^2);
 N3 = sqrt(0.666*en + 0.333*(2*e(1,2))^2);
 N = (N1+N2+N3)/3;

end