`ifndef MUX2
`define MUX2

/*
    BY: zhangnan,20170705
*/
 
//2·ѡ����
module mux2 #(parameter WIDTH=32)(
    input   [WIDTH-1:0]   d0,d1,
    input                 s,//ѡ���ź�
    output  [WIDTH-1:0]   y);
    
    assign y = s ? d1 : d0;
 
endmodule

`endif