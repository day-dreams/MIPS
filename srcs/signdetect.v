module signdetect #(parameter WIDTH = 32)      //�����˸��ű�־ģ��
                  (input [WIDTH-1:0] a,      
                   output   sign);     
                                            
                                             
  assign sign = a[WIDTH-1];                    
endmodule