function [Wmax]= maxwork_function(e)




%% This function calculates the maximum work done by bishop hill stress states to achieve the specified shape change e
% This is an updated version which can calculate the maximum work for
% relaxed constraints condition also. It considers 2,3,4 and 5 constraints
% situations.





global BH;
global no_of_states;            %This is the size of the BH states file 
global constraints;
Wmax=0;
Wmax_i= zeros(25,1);

l=1;


    
    switch constraints
    
    case 5
        
           for m=1:1:no_of_states
               
                       W= -(BH(m,2)*e(1,1))+ BH(m,1)*e(2,2)+ BH(m,4)*(e(2,3)+e(3,2))+BH(m,5)*(e(1,3)+e(3,1))+BH(m,6)*(e(1,2)+e(2,1));
                       if (abs(W)> Wmax) 
                       Wmax=W;
                       end
           end
    case 4
                 
           for i=1:1:5
               
                    a = [1,1,1,1,1];
                    a(i)=0;
                            for m=1:1:no_of_states
                   
                                  W= -a(1)*(BH(m,2)*e(1,1))+ a(2)*BH(m,1)*e(2,2)+ a(3)*BH(m,4)*(e(2,3)+e(3,2))+a(4)*BH(m,5)*(e(1,3)+e(3,1))+a(5)*BH(m,6)*(e(1,2)+e(2,1));
                                       if (abs(W)> Wmax_i(i)) 
                                       Wmax_i(i)=W;
                                       end
                            end
           end
           Wmax=mean(Wmax_i);
           
    case 3                 % only three strain components
            
           k=1; 
           for i=1:1:5
               
                    a = [1,1,1,1,1];
                    a(i)=0;
                    
                        for j=1:1:5
                            if j~=i
                                a(j)=0;
                                
                                        for m=1:1:no_of_states

                                              W= -a(1)*(BH(m,2)*e(1,1))+ a(2)*BH(m,1)*e(2,2)+ a(3)*BH(m,4)*(e(2,3)+e(3,2))+a(4)*BH(m,5)*(e(1,3)+e(3,1))+a(5)*BH(m,6)*(e(1,2)+e(2,1));
                                                   if (abs(W)> Wmax_i(k)) 
                                                   Wmax_i(k)=W;
                                                   end
                                        end
                                k=k+1;
                                a(j)=1;
                            end
                               
                        end
           end
            
           Wmax=mean(Wmax_i); 
           
    case 2              % only two strain components 
               
             a = [0,0,0,0,0];
             
             for i=1:1:5
                    a(i)=1;
                    
                        for j=1:1:5
                            if j~=i
                                a(j)=1;
                                
                                        for m=1:1:no_of_states

                                              W= -a(1)*(BH(m,2)*e(1,1))+ a(2)*BH(m,1)*e(2,2)+ a(3)*BH(m,4)*(e(2,3)+e(3,2))+a(4)*BH(m,5)*(e(1,3)+e(3,1))+a(5)*BH(m,6)*(e(1,2)+e(2,1));
                                                   if (abs(W)> Wmax_i(l)) 
                                                   Wmax_i(l)=W;
                                                   end
                                        end
                                l=l+1;
                            end
                               
                        end
             end
           Wmax=mean(Wmax_i);           
                       
                       
                       
         
    end 
    end


