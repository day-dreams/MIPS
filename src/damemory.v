`ifndef DAMEMORY
`define DAMEMORY

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/05 07:20:22
// Design Name: 
// Module Name: damemory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//数据内存,默认为 1024*4 Byte，带读写信号

module dmemory #(parameter WIDTH=32,DEPTH=1024)(
    input                     clk,
    input                     mem_write,
    input                     mem_read,
    input       [WIDTH-1:0]   read_address,write_address,
    input       [WIDTH-1:0]   write_data,
    output      [WIDTH-1:0]   mem_data
    );
    
    reg    [WIDTH-1:0]   mem[DEPTH-1:0];
    reg     [WIDTH-1:0] data;
    assign mem_data=data;
    /*
            TODO:添加数据读入、数码管、防抖动逻辑
    */

    always @(posedge clk) begin
        case ({mem_write,mem_read})
            2'b00:  ;//do nothing 
            2'b01:  data     <= mem[read_address];
            2'b10:  mem[write_address] <= write_data;
            2'b11:  ;//do nothing and abort !;
        endcase
    end
    
endmodule

`endif