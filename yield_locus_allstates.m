%% This program calculates yield locus for ideal texture component as well as for the textured polycrystal 
% Here the stress condition is plane strain with sigma_z=0 and
% tau23=tau13=tau12=0. More general cases will be considered in later
% versions



clear;      
close;

%% Creating Bishop Hill stress state matrix from the text file named: BHfile.txt

B = fopen('BHfile_half.txt');
BH = textscan(B, ' %f %f %f %f %f %f');
fclose(B);



%% Reading the orientation file
prompt = 'The orientation file name with .txt extension \n';
g_vectorfile = input(prompt);                        
g = fopen(g_vectorfile);                            
g_matrix = textscan(g, '%f %f %f');               
l_g =  length(g_matrix{1,1});
s_g_x = zeros(l_g,1);
s_g_y = zeros(l_g,1);

%% Reading the strain file

S = fopen('strains.txt');
strain = textscan(S, ' %f %f %f ');
l_s =  length(strain{1,1});
fclose(S);
s_x_mean= zeros(l_s,1);
s_y_mean= zeros(l_s,1);

    for u=1:1:l_s
        e_ext=[strain{1,1}(u),0,0;0,strain{1,2}(u),0;0,0,strain{1,3}(u)];
        
        for c=1:1:l_g
        
            A = DC_matrix_function(g_matrix{1,1}(c),g_matrix{1,2}(c),g_matrix{1,3}(c));
            [e]= transform_e_function(e_ext,A);
            Wmax=0;
            W=0;
            BH_state = zeros(6,1);
            
                    for m=1:1:28

                        W= -(BH{1,2}(m)*e(1,1))+ BH{1,1}(m)*e(2,2)+ BH{1,4}(m)*(e(2,3)+e(3,2))+BH{1,5}(m)*(e(1,3)+e(3,1))+BH{1,6}(m)*(e(1,2)+e(2,1));
                        BH_state = [BH{1,1}(m),BH{1,2}(m),BH{1,3}(m),BH{1,4}(m),BH{1,5}(m),BH{1,6}(m)]; % [A,B,C,F,G,H]
                            s23=BH_state(4);
                            s31=BH_state(5);
                            s12=BH_state(6);

                            s11= -(2*(BH_state(6)*A(3,1)*A(3,2)+BH_state(5)*A(3,1)*A(3,3)+BH_state(5)*A(3,1)*A(3,3)) + A(3,2)^2 + BH_state(2)*(A(3,2)^2 + A(3,3)^2))/(A(3,1)^2 + A(3,2)^2 + A(3,2)^2);
                            s22= s11 + BH_state(1)+BH_state(2);
                            s33= s11 + BH_state(2);
                            s13=s31;
                            s32=s23;
                            s21=s12;

                            s_xtal= [s11, s12, s13; s21, s22, s23; s31, s32, s33];
                            % Now convert the stresses from xtal coordinates to external reference frame

                            s = [0,0,0;0,0,0;0,0,0];

                            % Now calculating transformed stress tensor in external ref frame

                            for i=1:1:3
                                for j=1:1:3
                                    for k=1:1:3
                                        for l=1:1:3

                                            s(i,j)= s(i,j)+ A(k,i)*A(l,j)*s_xtal(k,l);

                                        end
                                    end
                                end
                            end

            
                            s_g_x(m) = s(1,1); 
                            s_g_y(m)= s(2,2);
                        plot(s_g_x,s_g_y,'r.')
                        hold on
                    end

        end 
    end
    hold off


 
       



