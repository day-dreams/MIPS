
module overflowdetect #(parameter WIDTH = 32)
                      (input [WIDTH-1:0] result,
                       input [WIDTH-1:0] a,
                       input [WIDTH-1:0] b,
                       input [4:0] alucont,
                       output reg   y);
                       wire A1,B1;
                       assign  A1=(a[WIDTH-1]==b[WIDTH-1])&&(a[WIDTH-1]==(~result[WIDTH-1]));
                       assign  B1=(a[WIDTH-1]==(~b[WIDTH-1]))&&(a[WIDTH-1]==(~result[WIDTH-1]));
        always @(*)
           case(alucont[4:0])
             5'b00010: y<=A1;
             5'b00110: y<=B1;
             default:  y<=0;
           endcase
endmodule