module signdetect #(parameter WIDTH = 32)      //增添了负号标志模块
                  (input [WIDTH-1:0] a,      
                   output   sign);     
                                            
                                             
  assign sign = a[WIDTH-1];                    
endmodule