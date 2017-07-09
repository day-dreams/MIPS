/**
 * @author [张楠，金宏昱，李依涵]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:52:21
 * @modify date 2017-07-09 09:52:21
 * @desc [description]
*/


`ifndef CONTROLLER
`define CONTROLLER

`include"config.v"

module controller(
        input clk,reset,
        input [31:0] equal,//用于beq
        input [5:0] opcode,func,
        output reg ra1src,wdsrc,opasrc,opbsrc,pcsrc,
        output reg [1:0] wasrc,
        output reg [1:0] aluop,
        output reg regwrite,dm_read,dm_write                          
    );
    
    reg [4:0] state,next_state;
    
    //初始状态是取指令
    initial begin
        state=STATE_FX;
    end

    always@(posedge clk)begin
        if(reset)
            state<=STATE_FX;
        else
            state<=next_state;
    end

    always@(posedge clk)begin
        case(state)
            STATE_FX:   next_state<=STATE_DECODE;
            STATE_DECODE:
                case(opcode)
                    OPCODE_LB:  next_state<=STATE_MEMADR;
                    OPCODE_SB:  next_state<=STATE_MEMADR;
                    OPCODE_RTYPE: 
                        if(func==FUNC_ADD)//寄存器间的加法指令
                            next_state<=STATE_ADDEX;
                        else//普通的立即数指令
                            next_state<=STATE_RTYPEEX;
                    OPCODE_BEQ: next_state<=STATE_BEQCALPC;
                    default: next_state<=STATE_FX;                 
                endcase
            STATE_ADDEX:
                next_state<=STATE_ADDWR;
             STATE_ADDWR:
                next_state<=STATE_PCADD;
            STATE_MEMADR:
                case(opcode)
                    OPCODE_LB:  next_state<=STATE_LBRD;
                    OPCODE_SB:  next_state<=STATE_PCADD;
                    default:    next_state<=STATE_FX;
                endcase
            STATE_LBRD:next_state<=STATE_LBWR;
            STATE_LBWR:next_state<=STATE_PCADD;
            STATE_SBWR:next_state<=STATE_PCADD;
            STATE_RTYPEEX:next_state<=STATE_RTYPEWR;
            STATE_RTYPEWR:next_state<=STATE_PCADD;
            STATE_BEQCALPC:next_state<=STATE_BEQEQUAL;
            STATE_BEQEQUAL:next_state<=STATE_BEQSETPC;
            STATE_BEQSETPC:next_state<=STATE_FX;
            STATE_PCADD:next_state<=STATE_FX;
        endcase
    end
    
    always@(posedge clk)begin
        //重置所有控制信号
        ra1src<=1'b0;wdsrc<=1'b0;opasrc<=1'b0;opbsrc<=1'b0;pcsrc<=1'b0;
        wasrc<=2'b00;
        aluop<=2'b00;
        regwrite<=1'b0;dm_read<=1'b0;dm_write<=1'b0;
        case(state)
            STATE_FX:begin
            end
            STATE_DECODE:begin
            end
            STATE_MEMADR:begin
                opasrc<=1;
                opbsrc<=0;
                aluop<=2'b00;
            end
            STATE_LBRD:begin
                dm_read<=1;
            end
            STATE_LBWR:begin
                wdsrc<=1'b0;
                wasrc<=2'b01;
                regwrite<=1'b1;               
            end
            STATE_SBWR:begin
                ra1src<=1'b1;
                dm_write<=1'b1;
            end
            STATE_RTYPEEX:begin
                ra1src=1'b1;
                opasrc<=1'b1;
                opbsrc<=1'b1;
                aluop<=2'b11;
            end
            STATE_RTYPEWR:begin
                wdsrc<=1;
                if (opcode==6'b000000)//for slt
                    wasrc<=2'b10;
                else
                    wasrc<=2'b01; 
            end
            STATE_BEQCALPC:begin
                opasrc<=0;
                opbsrc<=1;
                aluop<=2'b00;
            end 
            STATE_BEQEQUAL:begin
                opasrc<=1;
                opbsrc<=0;
                aluop<=2'b01;
            end
            STATE_BEQSETPC:begin
                if(equal)
                    pcsrc<=1;
                else
                    pcsrc<=0;
            end
            STATE_PCADD:begin
                pcsrc<=0;
            end
            STATE_ADDEX:begin
                ra1src<=0;
                opasrc<=1;
                opasrc<=0;
            end
            STATE_ADDWR:begin
                wdsrc=1;
                wasrc=2'b11;
                regwrite<=1;
            end
        endcase      
    end
    
endmodule

`endif