/*
    BY: zhangnan,20170705
*/

//运算单元,采用verilog自动集成的运算功能
module alu #(parameter WIDTH=32)(
    input       [WIDTH-1:0]     a,b,
    input       [2:0]           alucont,//4种运算
    output  reg [WIDTH-1:0]     result);
    
    always @(*) begin
        case(alucont[1:0])
            2'b00:  result <= a & b;
            2'b01:  result <= a | b;
            2'b10:  result <= a + b;
            2'b11:  result <= (a<b ? 1:0);
        endcase
    end
endmodule