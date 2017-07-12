module mux21 #(parameter WIDTH = 32)
            (input  [15:0] d0, d1, 
             input              s, 
             output [15:0] y);

  assign y = s ? d1 : d0; 
endmodule