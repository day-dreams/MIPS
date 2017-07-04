/*
    BY: zhangnan,20170705
*/

//�Ʋ⣺��ʹ�ܶ˿ں����ù��ܵ������ش����������ݴ�����
module flopenr #(parameter WIDTH=32)(
    input                   clk,en,reset,
    input       [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q);
    
    always @(posedge clk)
      if (reset)     q <= 0;
      else if(en)    q <= d;
     
endmodule 