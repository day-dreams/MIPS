/*
    BY: zhangnan,20170705
*/

//推测：带使能端口和重置功能的上升沿触发器，起暂存作用
module flopenr #(parameter WIDTH=32)(
    input                   clk,en,reset,
    input       [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q);
    
    always @(posedge clk)
      if (reset)     q <= 0;
      else if(en)    q <= d;
     
endmodule 