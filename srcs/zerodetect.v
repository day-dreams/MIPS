
module zerodetect #(parameter WIDTH = 32)
                  (input [WIDTH-1:0] a, 
                   output    zero);
                   
  assign zero = (a==0);
endmodule    