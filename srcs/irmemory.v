/**
 * @author [��骣�����ţ�������]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:54:38
 * @modify date 2017-07-09 09:54:38
 * @desc [description]
*/


`ifndef IRMEMORY
`define IRMEMORY

//ָ���ڴ�,Ĭ��Ϊ 1024*4 Byte�����ź�
module imemory #(parameter WIDTH=32,DEPTH=1024)(
    input                  clk,read,
    input  [WIDTH-1:0]     address,
    output [WIDTH-1:0]     instruction
    );
    
    reg [WIDTH-1:0] mem [DEPTH-1:0]; 
    
    /*
        TODO:���ָ���ļ��Ķ�ȡ����
    */
    
    assign instruction = mem[address];
    
endmodule

`endif