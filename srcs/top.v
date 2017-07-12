`timescale 1ns / 1ps

module top #(parameter WIDTH = 32, REGBITS = 5)();

reg                 clk;     // ±÷”–≈∫≈
reg     reset,up,down;
wire      [3:0]AN;
wire  [7:0]CX;

maxmin #( WIDTH , REGBITS) mm(clk, reset,up,down,AN,CX);

always
  begin
     clk <= 1; # 5; clk <= 0; # 5;
  end
  initial
         begin
            up=1;reset=0;
            reset <= 1; # 22; reset <= 0;
        
         end

endmodule