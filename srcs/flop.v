/**
 * @author [��骣�����ţ�������]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:54:20
 * @modify date 2017-07-09 09:54:20
 * @desc [description]
*/


//�Ʋ⣺�����ش����������ݴ�����
module flop #(parameter WIDTH=32)(
    input                   clk,
    input       [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q);
    
    always @(posedge clk)
      q <= d;
      
endmodule 