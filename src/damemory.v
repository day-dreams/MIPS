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

//�����ڴ�,Ĭ��Ϊ 1024*4 Byte������д�ź�

module dmemory#(parameter WIDTH=32,DEPTH=1024)(
    input                     clk,
    input                     mem_write,
    input                     mem_read,
    input       [WIDTH-1:0]   address,
    input       [WIDTH-1:0]   write_data,
    output reg  [WIDTH-1:0]   mem_data
    );
    
    reg    [WIDTH-1:0]   mem[DEPTH-1:0];

    /*
            TODO:�������ݶ��롢����ܡ��������߼�
    */

    always @(posedge clk) begin
        case ({mem_write,mem_read})
            2'b00:  ;//do nothing 
            2'b01:  mem_data     <= mem[address];
            2'b10:  mem[address] <= write_data;
            2'b11:  ;//do nothing and abort !;
        endcase
    end
    
endmodule