`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/05 07:04:22
// Design Name: 
// Module Name: irmemory
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

//ָ���ڴ�,Ĭ��Ϊ 1024*4 Byte���޶��ź�
module irmemory #(parameter WIDTH=32,DEPTH=1024)(
    input               clk,
    input [WIDTH-1:0]     address,
    input [WIDTH-1:0]     instruction
    );
    
    reg [WIDTH-1:0] mem [0:DEPTH-1]; 
    
    /*
        TODO:���ָ���ļ��Ķ�ȡ����
    */
    
    assign instruction = mem[address];
    
endmodule
