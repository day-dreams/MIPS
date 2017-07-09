`ifndef ALU
`define ALU


/*
    BY: zhangnan,20170705
*/

//运算单元,采用verilog自动集成的运算功能
module alu #(parameter WIDTH=32)(
    input       [WIDTH-1:0]     a,b,
    input       [2:0]           alucont,//运算
    output  reg [WIDTH-1:0]     result);
    
    always @(*) begin
        case(alucont[2:0])
            3'b000:  result <= a & b;
            3'b001:  result <= a | b;
            3'b010:  result <= a + b;
            3'b100:  result <= (a==b);//for beq
            3'b111:  result <= (a<b ? 1:0);//set on less
        endcase
    end
endmodule

`endif