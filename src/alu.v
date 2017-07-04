/*
    BY: zhangnan,20170705
*/

//���㵥Ԫ,����verilog�Զ����ɵ����㹦��
module alu #(parameter WIDTH=32)(
    input       [WIDTH-1:0]     a,b,
    input       [2:0]           alucont,//4������
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