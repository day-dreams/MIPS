/**
 * @author [��骣�����ţ�������]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:55:13
 * @modify date 2017-07-09 09:55:13
 * @desc [description]
*/

`ifndef REGFILE
`define REGFILE

`timescale 1ns / 1ps

//�Ĵ����ѣ�û�ж��źţ���������
module regfile #(parameter WIDTH=32,DEPTH=32) (
    input  wire                   clk,
    input  wire                   regwrite,
    input  wire [WIDTH-1:0]     ra1,ra2,wa,
    input  wire [WIDTH-1:0]       wd,
    output wire [WIDTH-1:0]       rd1,rd2
    );
    
    //Ĭ��Ϊ32Ƭ32λ�Ĵ���
    reg   [WIDTH-1:0]       RAM[DEPTH-1:0];
    
    always begin
        RAM[0]=0;
    end

    //д�Ĵ����߼�
    always @(posedge clk)begin
        if(regwrite) RAM[wa] <= wd;
    end
    
    //����ж��ź��򷵻ض�Ӧ�Ĵ������ݣ����򷵻�0
    assign rd1 = ra1 ? RAM[ra1] : 0;
    assign rd2 = ra2 ? RAM[ra2] : 0;    
     
endmodule

`endif