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

//�Ĵ����ѣ�û�ж��źţ���������
module regfile #(parameter WIDTH=32,REG_NUM=5) (
    input  wire                   clk,
    input  wire                   regwrite,
    input  wire [REG_NUM-1:0]     ra1,ra2,wa,
    input  wire [WIDTH-1:0]       wd,
    output wire [WIDTH-1:0]       rd1,rd2
    );
    
    //Ĭ��Ϊ32Ƭ32λ�Ĵ���
    reg   [WIDTH-1:0]       RAM[REG_NUM-1:0];
    
    //д�Ĵ����߼�
    always @(posedge clk)begin
        if(regwrite) RAM[wa]<=wd;
    end
    
    //����ж��ź��򷵻ض�Ӧ�Ĵ������ݣ����򷵻�0
    assign rd1 = ra1 ? RAM[ra1] : 0;
    assign rd2 = ra2 ? RAM[ra2] : 0;    
     
endmodule