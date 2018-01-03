function [N] = calc_Nbar_function(g_matrix,e_ext)

%% function calc_Nbar_function(g_matrix,e_ext)

l =  length(g_matrix{1,1});
%N = zeros(1,3);
a =2/3;
b =1/3; 
N_bar = zeros(1,l);

%         for i=1:1:3
%             
%             g_matrix{1,3}(:) = g_matrix{1,3}(:)+ 45*(i-1);   
                    for c=1:1:l

                            A = DC_matrix_function(g_matrix{1,1}(c),g_matrix{1,2}(c),g_matrix{1,3}(c));
                            [e]= transform_e_function(e_ext,A);
                            en= (e(1,1)^2+e(2,2)^2+e(3,3)^2);
                            N1 = sqrt(a*en + b*(2*e(2,3))^2);
                            N2 = sqrt(a*en + b*(2*e(1,3))^2);
                            N3 = sqrt(a*en + b*(2*e(1,2))^2);
                            N_bar(c) = (N1+N2+N3)/3;

                    end

                N = mean(N_bar);
        end
        

%end