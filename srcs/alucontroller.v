
module alucontrol(input      [5:0] aluop, 
                 input      [5:0] funct, 
                 output reg [4:0] alucont);

  always @(*)begin
     case(aluop)
        6'b000000: alucont <= 5'b00010;  // add for lw/sw/addi
        6'b000001: alucont <= 5'b00110;  // sub (for beq)
        6'b001000: alucont <= 5'b00010;  // addi
        6'b001001: alucont <= 5'b01100;  // addiu
        6'b001010: alucont <= 5'b00111;  // slti
        6'b001100: alucont <= 5'b00000;  // andi
        6'b001101: alucont <= 5'b00001;  // ori
        6'b001110: alucont <= 5'b01110;  // xori
        6'b001111: alucont <= 5'b10000;  // lui
        6'b000100: alucont <= 5'b00110;  // beq
        6'b100011: alucont <= 5'b00010;  // lw
        6'b101011: alucont <= 5'b00010;  // sw
        
        default: case(funct)       // R-Type instructions
                    6'b100000: alucont <= 5'b00010; // add (for add)
                    6'b100010: alucont <= 5'b00110; // subtract (for sub)
                    6'b100100: alucont <= 5'b00000; // logical and (for and)
                    6'b100101: alucont <= 5'b00001; // logical or (for or)
                    6'b101010: alucont <= 5'b00111; // set on less (for slt)
                    
                    6'b000000: alucont <= 5'b01001;  //sll
                    6'b000010: alucont <= 5'b01010;  //srl
                    6'b000011: alucont <= 5'b01011;  //sra
                    6'b100001: alucont <= 5'b00111;  //addu
                    6'b100011: alucont <= 5'b01101;  //subu
                    6'b100110: alucont <= 5'b01110;  //xor
                    6'b100111: alucont <= 5'b01111;  //nor
                 endcase
     endcase
          // $display("funct=%b,aluop=%b,alucont=%b",funct,aluop,alucont);
    end
endmodule
