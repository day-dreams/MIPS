/**
 * @author [张楠，金宏昱，李依涵]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:55:13
 * @modify date 2017-07-09 09:55:13
 * @desc [description]
*/

`ifndef REGFILE
`define REGFILE

`timescale 1ns / 1ps

//寄存器堆，没有读信号，立即出数
module regfile #(parameter WIDTH=32,DEPTH=32) (
    input  wire                   clk,
    input  wire                   regwrite,
    input  wire [WIDTH-1:0]     ra1,ra2,wa,
    input  wire [WIDTH-1:0]       wd,
    output wire [WIDTH-1:0]       rd1,rd2
    );
    
    //默认为32片32位寄存器
    reg   [WIDTH-1:0]       RAM[DEPTH-1:0];
    
    always begin
        RAM[0]=0;
    end

    //写寄存器逻辑
    always @(posedge clk)begin
        if(regwrite) RAM[wa] <= wd;
    end
    
    //如果有读信号则返回对应寄存器内容，否则返回0
    assign rd1 = ra1 ? RAM[ra1] : 0;
    assign rd2 = ra2 ? RAM[ra2] : 0;    
     
endmodule

`endif