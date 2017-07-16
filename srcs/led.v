module led (    
    input clk,resest,
    input [31:0] data_to_show,
    input  [31:0] seg_to_choose,
    output wire [7:0] leds,
    output wire [3:0]  seg_bits);
    
  assign leds=data_to_show[7:0];
  assign seg_bits=seg_to_choose[3:0];
  
  endmodule