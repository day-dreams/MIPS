/*
    BY: zhangnan,20170705
*/

//推测：带势能端口的上升沿触发器，起暂存作用
module flopen #(parameter WIDTH=32)(
    input                   clk,en,
    input       [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q);
    
    always @(posedge clk)
      if(en)    q <= d;
      
endmodule 