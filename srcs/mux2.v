/**
 * @author [张楠，金宏昱，李依涵]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:54:47
 * @modify date 2017-07-09 09:54:47
 * @desc [description]
*/

`ifndef MUX2
`define MUX2
 
//2路选择器
module mux2 #(parameter WIDTH=32)(
    input   [WIDTH-1:0]   d0,d1,
    input                 s,//选择信号
    output  [WIDTH-1:0]   y);
    
    assign y = s ? d1 : d0;
 
endmodule

`endif