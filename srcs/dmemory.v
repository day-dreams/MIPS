//`include"config.v"

//数据内存
module dmemory #(parameter WIDTH = 32) (
      input clk,reset,
      input up,down,
      input memwrite,
      input [WIDTH-1:0] adr, writedata,
      output reg [WIDTH-1:0] memdata,
      output wire [3:0] AN,
      output wire [7:0] CX);
      
      
      parameter MAX_ONES=32'h00fd;
      parameter MAX_TENS=32'h00fc;
      parameter MAX_HUNDS=32'h00fb;
      parameter MAX_THOUDS=32'h00fa;
      parameter MIN_ONES=32'h00f9;
      parameter MIN_TENS=32'h00f8;
      parameter MIN_HUNDS=32'h00f7;
      parameter MIN_THOUDS=32'h00f6;
      
      reg [31:0]data_to_led,bits_to_choose;
      
      led seg_leds(clk,reset,data_to_led,bits_to_choose,CX,AN);
      
  reg  [31:0] RAM [1023:0];        //存储器容量32bit 256M
  wire [31:0] word;
  reg [31:0] max=32'h1234;
  reg[31:0] min=32'h4321;
  initial
     begin
      $readmemb("C:/Users/moon/Desktop/my-mips-cpu/assembly/my-data.bat",RAM);        //读指令
     end
    
      always @(posedge clk)
      if(memwrite) begin

              case (adr)
              32'h00000400: begin 
                data_to_led=writedata;
                $display("DATA :%h,ADDR:%h",data_to_led,adr);
              end
              32'h00000c00 : begin 
                bits_to_choose=writedata;
                $display("DATA :%h,ADDR:%h",bits_to_choose,adr);
              end
              default: 
                  begin 
                      RAM[adr][31:0]= writedata;   //32位可一次读入
                     // $display("DATA :%h,ADDR:%h",RAM[adr],adr);
                  end
          endcase
      end
        
  assign word = RAM[adr>>2];
   
  always @(*)   begin
    if(adr==32'h00001008)begin
        memdata<={31'b0,up};
        $display("READMEM:%h,%d",adr,up);
     end
    else if(adr==32'h00001010)begin
        memdata<={31'b0,down};
        $display("READMEM:%h,%d",adr,up);
      end
     else
      memdata <= word[31:0];
//   $display("DMEM..... %b",RAM[0]);
   end 

endmodule