/**
 * @author [张楠，金宏昱，李依涵]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:50:03
 * @modify date 2017-07-09 09:50:03
 * @desc [description]
*/


`ifndef ALUCON
`define ALUCON

//ALU的控制单元
module alucontroller(
        input       [1:0]   aluop,
        input       [5:0]   funct,
        output  reg [2:0]   alucont//提供给ALU使用
    );
    
    always @(*) begin
        case(aluop) 
            2'b00:  alucont <= 3'b010;// 加法，用于LB，SB，ADDI
            2'b01:  alucont <= 3'b100;// 判断相等，用于BEQ
            default:
                case(funct)//Rtype，立即数类型
                    6'b100000: alucont <= 3'b010;//add
                    6'b100010: alucont <= 3'b110;//sub
                    6'b100100: alucont <= 3'b000;//logic and
                    6'b100101: alucont <= 3'b001;//logic or
                    6'b101010: alucont <= 3'b111;//set on less
                    default  : alucont <= 3'b101;//abort!                                                        
                endcase 
        endcase
    end
endmodule

`endif