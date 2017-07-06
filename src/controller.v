`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/06 09:14:58
// Design Name: 
// Module Name: controller
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

`include"config.v"

//控制器，核心模块之一
module controller(
    input  ckl,reset,
    input  [5:0] op,//指令操作码
    input   zero,//常数0
    
    //TODO:unknown
    output iord,//TODO:unknown
    //for pc
    output pcen,//TODO:unknown
    output reg[1:0] pcsource,//TODO:unknown    
    //for data mem
    output  reg dmread,dmwrite,//数据内存读写控制信号
    output  memtoreg,//读内存信号    
    //for inst mem
    output  reg imread,//指令内存读控制信号   
    //for alu
    output reg[1:0] aluop,//ALU操作类型
    output alusrca,//ALU的输入选择，操作数a只来自于寄存器或者PC
    output [1:0] alusrcb,//ALU的输入选择，操作数b只来自于寄存器，常数1，指令的形式地址    
    //for reg file
    output regwrite,//寄存器堆写控制信号，用于LB，TTYPE
    output regdst,//寄存器地址
    output reg[3:0] irwrite//寄存器写地址
    );
    
    reg [3:0] state,nextstate;//状态机标志
    reg       pcwrite,pcwritecond;//TODO:unknown
    
    //状态机状态控制
    always @(*) begin
        if(reset) state <= STATE_FX;//重置，取指令状态
        else state <= nextstate;//更新，下一个状态
    end
    
    //状态机状态迁移
    always @(*)begin
        case (state)
            STATE_FX: nextstate<=STATE_DECODE;
            STATE_DECODE:case(op)
                            OPCODE_LB:      nextstate <= STATE_MEMADR;
                            OPCODE_SB:      nextstate <= STATE_MEMADR;
                            OPCODE_RTYPE:   nextstate <= STATE_RTYPEEX;
                            OPCODE_BEQ:     nextstate <= STATE_BEQEX;
                            OPCODE_J:       nextstate <= STATE_JEX;
                            default:        nextstate <= STATE_FX;
                         endcase
            STATE_MEMADR: case(op)
                            OPCODE_LB:     nextstate <= STATE_LBRD;
                            OPCODE_SB:     nextstate <= STATE_SBWR;
                            default:       nextstate <= STATE_FX;
                          endcase
            STATE_LBRD:                     nextstate<=STATE_LBWR;
            STATE_LBWR:                     nextstate<=STATE_FX;  
            STATE_RTYPEEX:                  nextstate<=STATE_RTYPEWR;
            STATE_RTYPEWR:                  nextstate<=STATE_FX;
            STATE_BEQEX:                    nextstate<=STATE_FX;
            STATE_JEX:                      nextstate<=STATE_FX;
            default:                        nextstate<=STATE_FX;
        endcase       
    end
    
endmodule
