//Ö¸Áî
module imemory #(parameter WIDTH = 32) (
      input clk,reset,
      input [WIDTH-1:0] adr,
      output reg [WIDTH-1:0] memdata
    );

  reg  [31:0] ROM [1023:0];        //´æ´¢Æ÷ÈÝÁ¿32bit 256M
  wire [31:0] word;

  initial
     begin
      //$readmemb("D:/my-instructions.bat",ROM);        //¶ÁÖ¸Áî
      $readmemb("C:/Users/moon/Desktop/my-mips-cpu/assembly/test.bat",ROM);        //¶ÁÖ¸Áî
            
     end

  assign word = ROM[adr>>2];
   
  always @(*)   begin
   memdata <= word[31:0];
   //$display("IMEM..... %b",ROM[0]);
   end 

endmodule