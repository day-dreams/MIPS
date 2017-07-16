module maxmin #(parameter WIDTH = 32, REGBITS = 5)(
   input clk,
   input reset,
   input up,
   input down,
   output [3:0] AN,
   output [7:0] CX
   );

   wire                memread, memwrite; //´æ´¢Æ÷¶Á ´æ´¢Æ÷Ð´ÐÅºÅ
   wire    [WIDTH-1:0] adr, writedata;    //´æ´¢Æ÷Ð´µØÖ· Ð´Êý¾Ý
   wire    [WIDTH-1:0] memdata;
   wire    [WIDTH-1:0] imem_adr;//Ö¸Áî¼Ä´æÆ÷¶ÁµØÖ·
   wire    [WIDTH-1:0] imemdata;
   always@(AN,CX)begin
      //$display("%d,%d,%d,%d,%d,%d,%d,%d",RAM[MAX_ONES],RAM[MAX_TENS],RAM[MAX_HUNDS],RAM[MAX_THOUDS],RAM[MIN_ONES],RAM[MIN_TENS],RAM[MIN_HUNDS],RAM[MIN_THOUDS]);
      $display("[MAXMIN]:AN=%b,CX=%b",AN,CX);
   end

   // instantiate devices to be tested
   mips #(WIDTH, REGBITS) dut(clk, reset, memdata,imemdata, 
                            memread, memwrite, adr, writedata,imem_adr);
   
   // external memory for code and data
   dmemory #(WIDTH) dmem(clk,reset,up,down, memwrite, adr, writedata, memdata,AN,CX);

   imemory #(WIDTH) imem(clk,reset,imem_adr,imemdata);
endmodule







