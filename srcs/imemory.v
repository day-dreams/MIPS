//Ö¸Áî
module imemory #(parameter WIDTH = 32) (
      input clk,reset,
      input [WIDTH-1:0] adr,
      output reg [WIDTH-1:0] memdata
    );

  reg  [31:0] ROM [1023:0];        
  wire [31:0] word;

  initial
     begin
      $readmemb("C:/Users/moon/Desktop/my-mips-cpu/assembly/test.bat",ROM);        //¶ÁÖ¸Áî
     end

  assign word = ROM[adr>>2];
   
  always @(*)   begin
   memdata <= word[31:0];
   end 

endmodule