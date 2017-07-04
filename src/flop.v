/*
    BY: zhangnan,20170705
*/

//推测：上升沿触发器，起暂存作用
module flop #(parameter WIDTH=32)(
    input                   clk,
    input       [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q);
    
    always @(posedge clk)
      q <= d;
      
endmodule 