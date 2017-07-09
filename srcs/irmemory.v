/**
 * @author [张楠，金宏昱，李依涵]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:54:38
 * @modify date 2017-07-09 09:54:38
 * @desc [description]
*/


`ifndef IRMEMORY
`define IRMEMORY

//指令内存,默认为 1024*4 Byte，读信号
module imemory #(parameter WIDTH=32,DEPTH=1024)(
    input                  clk,read,
    input  [WIDTH-1:0]     address,
    output [WIDTH-1:0]     instruction
    );
    
    reg [WIDTH-1:0] mem [DEPTH-1:0]; 
    
    /*
        TODO:添加指令文件的读取过程
    */
    
    assign instruction = mem[address];
    
endmodule

`endif