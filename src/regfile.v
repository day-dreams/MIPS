`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/05 06:28:02
// Design Name: 
// Module Name: regfile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revi sion:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module regfile #(parameter WIDTH=32,REGBITS=5) (
    input                   clk,
    input                   regwrite,
    input [REGBITS-1:0]     ra1,ra2,wa,
    input [WIDTH-1:0]       wd,
    input [WIDTH-1:0]       rd1,rd2
    );
    
    //默认为32片32位寄存器
    reg   [WIDTH-1:0]       RAM[(1<<REGBITS)-1:0];
    
    //写寄存器逻辑
    always @(posedge clk)begin
        if(regwrite) RAM[wa]<=wd;
    end
    
    //如果有读信号则返回对应寄存器内容，否则返回0
    assign rd1 = ra1 ? RAM[ra1] : 0;
    assign rd2 = ra2 ? RAM[ra2] : 0;    
     
endmodule
