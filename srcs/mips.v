
// simplified MIPS processor
module mips #(parameter WIDTH = 32, REGBITS = 5)
            (input              clk, reset, 
             input  [WIDTH-1:0] memdata,imemdata, 
             output             memread, memwrite, 
             output [WIDTH-1:0] adr, writedata,//数据内存
             output [WIDTH-1:0] imem_adr//指令内存的地址
             );
  
  wire        zero,  memtoreg;
  wire        iord, pcen, regwrite; 
  wire        regdst ,sign;     
  wire [1:0]  pcsource;
  wire [1:0]  alusrcb;
  wire [1:0]  alusrca;
  wire [5:0]  aluop;
  wire        overflow;
  wire        irwrite;                  
  wire [4:0]  alucont;        
  wire        SorI ; 
  wire [1:0]  select; 
 


  controller  cont(clk, reset, imemdata[31:26], zero,sign, imemdata[5:0], memread, memwrite, 
                    memtoreg, iord, pcen, regwrite, regdst,SorI,
                   pcsource, alusrcb, alusrca,select , aluop , irwrite);
  alucontrol  ac(aluop, imemdata[5:0], alucont);
 
 
  datapath    #(WIDTH, REGBITS) 
              dp(clk, reset, memdata, memtoreg, iord, pcen,
                 regwrite, regdst, pcsource, alusrcb,alusrca, irwrite, alucont,
                 zero,overflow,sign,imemdata,imem_adr,adr,writedata);
                    
                 
endmodule
