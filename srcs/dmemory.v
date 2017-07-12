//数据内存
module dmemory #(parameter WIDTH = 32) (
      input clk,reset,
      input up,down,
      input memwrite,
      input [WIDTH-1:0] adr, writedata,
      output reg [WIDTH-1:0] memdata,
      output wire [3:0] AN,
      output wire [7:0] CX);


  reg  [31:0] RAM [1023:0];        //存储器容量32bit 256M
  wire [31:0] word;
  reg [31:0] max=32'h1234;
  reg[31:0] min=32'h4321;
  initial
     begin
      $readmemb("C:/Users/moon/Desktop/my-mips-cpu/assembly/my-data.bat",RAM);        //读指令
     end
     
     led moled(clk, reset,max,min,up,down,AN,CX);
      always @(posedge clk)
      if(memwrite) begin
          case (adr)
              32'h00001000: begin 
              max = writedata;
              $display("MAX :%h,WRITE_DATA:%h",max,writedata);
              //$stop();
              end
              32'h00001004 : begin 
              min = writedata;
               $display("MIN :%h,WWRITE_DATA:%h",min,writedata);
               //$stop();
              end
              default: 
                  begin 
                      $display("CURRENT_WRITE_DMADR:%b",adr);
                      RAM[adr>>2][31:0]= writedata;   //32位可一次读入
                  end
          endcase
      end
        
  assign word = RAM[adr>>2];
   
  always @(*)   begin
   memdata <= word[31:0];
   //$display("DMEM..... %b",RAM[0]);
   end 

endmodule