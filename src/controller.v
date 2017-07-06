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

//������������ģ��֮һ
module controller(
    input  ckl,reset,
    input  [5:0] op,//ָ�������
    input   zero,//����0
    
    //TODO:unknown
    output iord,//TODO:unknown
    //for pc
    output pcen,//TODO:unknown
    output reg[1:0] pcsource,//TODO:unknown    
    //for data mem
    output  reg dmread,dmwrite,//�����ڴ��д�����ź�
    output  memtoreg,//���ڴ��ź�    
    //for inst mem
    output  reg imread,//ָ���ڴ�������ź�   
    //for alu
    output reg[1:0] aluop,//ALU��������
    output alusrca,//ALU������ѡ�񣬲�����aֻ�����ڼĴ�������PC
    output [1:0] alusrcb,//ALU������ѡ�񣬲�����bֻ�����ڼĴ���������1��ָ�����ʽ��ַ    
    //for reg file
    output regwrite,//�Ĵ�����д�����źţ�����LB��TTYPE
    output regdst,//�Ĵ�����ַ
    output reg[3:0] irwrite//�Ĵ���д��ַ
    );
    
    reg [3:0] state,nextstate;//״̬����־
    reg       pcwrite,pcwritecond;//TODO:unknown
    
    //״̬��״̬����
    always @(*) begin
        if(reset) state <= STATE_FX;//���ã�ȡָ��״̬
        else state <= nextstate;//���£���һ��״̬
    end
    
    //״̬��״̬Ǩ��
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
