
module regfile #(parameter WIDTH = 32, REGBITS = 5)
               (input                clk, 
                input                regwrite, 
                input  [REGBITS-1:0] ra1, ra2, wa, 
                input  [WIDTH-1:0]   wd, 
                output [WIDTH-1:0]   rd1, rd2);

  reg  [WIDTH-1:0] RAM [(1<<REGBITS)-1:0];

  initial
     begin
     RAM[0]<=32'b0;
//        $monitor("--Time=%0d--\n %h %h %h %h\n %h %h %h %h\n %h %h %h %h\n %h",$time,RAM[0],RAM[1],RAM[2],RAM[3],
//                                                        RAM[4],RAM[5],RAM[6],RAM[7],
//                                                        RAM[8],RAM[9],RAM[10],RAM[11],RAM[12]);
     end
     
 
    integer file;
    initial begin
        file = $fopen("D:/workplace/CPU/MIPS/debug.txt","w");    
    end
    
  always @(posedge clk)begin
     if (regwrite) begin 
         $fdisplay(file,"WD:%h WA:%d",wd,wa);
         $display("WD:%h WA:%d",wd,wa);
       RAM[wa] = wd;
     end    
   end
  assign rd1 = ra1 ? RAM[ra1] : 0;
  assign rd2 = ra2 ? RAM[ra2] : 0;
endmodule