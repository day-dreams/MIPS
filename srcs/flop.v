/**
 * @author [张楠，金宏昱，李依涵]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:54:20
 * @modify date 2017-07-09 09:54:20
 * @desc [description]
*/


//推测：上升沿触发器，起暂存作用
module flop #(parameter WIDTH=32)(
    input                   clk,
    input       [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q);
    
    always @(posedge clk)
      q <= d;
      
endmodule 