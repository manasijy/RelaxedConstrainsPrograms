%% Poly_crystal Function
function [M_RD,M_TD,M_45RD] = poly_crystal_function(e_ext)



%% Reading the orientation data file 
prompt = 'The euler angle file name with .txt extension \n';
g_vectorfile = input(prompt);                       %% this stores the file name in a string array variable g_vectorfile. This file is an array of orientation vectors, each vector has three euler angles as components.
g = fopen(g_vectorfile);                            %% g stores the link to the file g_vectorfile

g_matrix_RD = textscan(g, '%f %f %f');              %% g_matrix stores the file (g_vectorfile) data in a matrix 
g_matrix_TD = g_matrix_RD;
g_matrix_TD{1,1}(:) = g_matrix_TD{1,1}(:)-90;       % rotation was applied to phi1 now earlier it was phi2
g_matrix_45RD = g_matrix_RD;
g_matrix_45RD{1,1}(:) = g_matrix_45RD{1,1}(:)-45;
fclose(g);


M_RD = calculate_M_function(g_matrix_RD,e_ext);
M_TD = calculate_M_function(g_matrix_TD,e_ext);
M_45RD = calculate_M_function(g_matrix_45RD,e_ext);

end







