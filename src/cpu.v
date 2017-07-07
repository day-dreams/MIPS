`ifndef _CPU
`define _CPU

`timescale 1ns / 1ps
`include"config.v"
`include"regfile.v"
`include"mux2.v"
`include"alu.v"
`include"alucontroller.v"
`include"controller.v"

module cpu(
        input clk,reset,
        input [31:0] data_from_dm,data_from_im,
        output[31:0] data_to_dm,
        output [31:0] write_address_to_dm,read_address_to_dm,address_to_im,
        output   dm_write,dm_read 
    );
    
    //指令及其分割
    wire[31:0] instruction;
    wire [5:0] opcode,func;
    wire [4:0] rs,rt,rd;
    wire [15:0] imme;    
    assign instruction=data_from_im;
    assign opcode=instruction[31:26];
    assign rs=instruction[25:21];
    assign rt=instruction[21:16];
    assign imme=instruction[15:0];
    assign func=instruction[5:0];
    assign rd=instruction[15:11];
    
    
    wire [31:0] alu_out;//避免前向声明
    //寄存器堆
    wire regwrite;
    wire [4:0] ra1,ra2,wa;
    wire [31:0] wd,rd1,rd2,A,B;
    wire ra1src,wdsrc;
    wire [1:0] wasrc;
    assign ra2=rt;
    flop for_A(clk,rd1,A);
    flop for_B(clk,rd2,B);
    mux2 #(5) for_ra1(rs,rt,ra1src,ra1);
    mux2 #(5) for_wd(data_from_dm,alu_out,wdsrc,wd);
    mux4 #(5) for_wa(rs,rt,rd,rd,wasrc,wa);
    regfile #(32,5) refister_file (clk,regwrite,ra1,ra2,wa,wd,rd1,rd2);
    
    wire [31:0] pc,pc_add;//避免前向声明
    //ALU,ALU_CON
    wire [31:0] opa,opb,alu_result,equal;
    wire [2:0] alucont;
    wire [1:0] aluop;
    wire opasrc,opbsrc;
    wire [31:0] full_imme;
    //assign full_imme=imme
    assign equal=alu_result;
    assign write_address_to_dm=alu_out;
    assign read_address_to_dm=alu_out;
    assign data_to_dm=A;
    flop for_aluout(clk,alu_result,alu_out);
    mux2 #(32) for_opa(pc,A,opasrc,opa);
    mux2 #(32) for_opb(B,imme,opbsrc,opb);
    alu #(32)(opa,opb,alucont,alu_result);
    alucontroller alu_controller(aluop,func,alucont);
        
    //PC,PC+1
    wire pcsrc;
    assign address_to_im=pc;
    assign pc_add=pc+4;
    mux2 #(32) for_pc(pc_add,alu_out,pcsrc,pc);     
    
    //控制器
    controller(clk,reset,equal,opcode,
                ra1src,wdsrc,opasrc,opbsrc,pcsrc,
                wasrc,aluop,regwrite,dm_read,dm_write                       
        );


endmodule

`endif