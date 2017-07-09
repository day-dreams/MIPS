`ifndef MUX2
`define MUX2

/*
    BY: zhangnan,20170705
*/
 
//2路选择器
module mux2 #(parameter WIDTH=32)(
    input   [WIDTH-1:0]   d0,d1,
    input                 s,//选择信号
    output  [WIDTH-1:0]   y);
    
    assign y = s ? d1 : d0;
 
endmodule

`endif