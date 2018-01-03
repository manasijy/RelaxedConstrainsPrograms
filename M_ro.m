%% This program plots the taylor factor variation with ro (=-e_w/e_l)

clear;      
close;


%% Declaration of variables


global Co;
global BH;
ro =0;
e_ext= zeros(3,3);

Co = sqrt(6);




M_RD = zeros(1, 11);
M_TD = zeros(1, 11);
M_45RD = zeros(1, 11);
output = zeros(11,4);
ro_min = zeros(1,4);   % corresponding to 0, 90 and 45 to RD directions
    

%% Creating Bishop Hill stress state matrix from the text file named: BHfile.txt

B = fopen('BHfile.txt');
BH = textscan(B, ' %f %f %f %f %f %f');
fclose(B);



    %% Reading the orientation data file 
prompt = 'The euler angle file name with .txt extension \n';
g_vectorfile = input(prompt);                       %% this stores the file name in a string array variable g_vectorfile. This file is an array of orientation vectors, each vector has three euler angles as components.
g = fopen(g_vectorfile);                            %% g stores the link to the file g_vectorfile

g_matrix_RD = textscan(g, '%f %f %f');              %% g_matrix stores the file (g_vectorfile) data in a matrix 
g_matrix_TD = g_matrix_RD;
g_matrix_TD{1,3}(:) = g_matrix_TD{1,3}(:)+90;
g_matrix_45RD = g_matrix_RD;
g_matrix_45RD{1,3}(:) = g_matrix_45RD{1,3}(:)+45;
fclose(g);

for i=1:1:11
    
    ro= 0.1*(i-1);
    e_ext= [1,0,0;0,-ro,0;0,0,ro-1];
    
    M_RD(i) = calculate_M_function(g_matrix_RD,e_ext);
    M_TD(i) = calculate_M_function(g_matrix_TD,e_ext);
    M_45RD(i) = calculate_M_function(g_matrix_45RD,e_ext);
    output(i,:)= [ro,M_RD(i),M_TD(i),M_45RD(i)];
end

for j=2:1:4
    for k=1:11
        if output(k,j)== min(output(:,j))
            ro_min(j) = output(k,1);
        end
    end
end


r_value=[ro_min(2)/(1-ro_min(2)),ro_min(3)/(1-ro_min(3)),ro_min(4)/(1-ro_min(4))];
fprintf('Taylor factor and rvalue for the RD, TD and 45 to RD tests \n') %"%f" \n',min(M_RD))
fprintf('Direction \t M \t \t r \n')  %r value for RD test "%f"\n', r_value(1))
fprintf('RD \t\t "%f" \t "%f" \n',min(M_RD),r_value(1))   %Taylor factor for TD test "%f"\n',min(M_TD))
fprintf('TD \t\t "%f" \t "%f" \n',min(M_TD),r_value(2))   %r value for TD test "%f"\n', r_value(2))
fprintf('45RD \t\t "%f" \t "%f" \n',min(M_45RD),r_value(3))   %Taylor factor for 45deg to RD test "%f"\n',min(M_45RD))
% fprintf('r value for 45 to RD test "%f"\n', r_value(3)) 
fprintf('rbar = "%f"\n', ((r_value(1)+r_value(2)+2*r_value(3))/4))

plot(output(:,1),output(:,2),'-.or')
xlabel('ro');
ylabel('Taylor Factor');
hold on
plot(output(:,1),output(:,3),'--xg')
plot(output(:,1),output(:,4),':+b')


hold off
