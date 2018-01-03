function [ ori ] = txt2ori()

g_vectorfile = input('The euler angle file name with .txt extension \n');                      
g = fopen(g_vectorfile);                            
g_matrix = textscan(g, '%f %f %f');  
ori = rotation('Euler',[g_matrix{1,1},g_matrix{1,2},g_matrix{1,3}]*degree);
fclose(g);