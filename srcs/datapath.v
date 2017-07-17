
module datapath #(parameter WIDTH = 32, REGBITS = 5)
                (input              clk, reset, 
                 input  [WIDTH-1:0] memdata, 
                 input              memtoreg, iord, pcen, regwrite, regdst,
                 input  [1:0]       pcsource, alusrcb, alusrca,
                 input              irwrite, 
                 input  [4:0]       alucont, 
                 output             zero, 
                 output             overflow,
                 output             sign,
                 input [31:0]       instr,
                 output [31:0]      imem_adr,
                 output [WIDTH-1:0] adr, writedata);

  // the size of the parameters must be changed to match the WIDTH parameter
  parameter CONST_ZERO = 8'b0;
  parameter CONST_ONE =  32'b1;

  wire [REGBITS-1:0] ra1, ra2, wa;
  wire [WIDTH-1:0]   pc, nextpc;
  wire [WIDTH-1:0]  md, rd1;
  wire [WIDTH-1:0]   rd2, wd;
  wire [WIDTH-1:0]   a, src1;
  wire [WIDTH-1:0]   src2, aluresult;
  wire [WIDTH-1:0]  aluout, constx4;
  wire [WIDTH-1:0] Const;
  wire [15:0]  Const1;
  wire [WIDTH-1:0]  Jump;
   
  assign imem_adr=pc;

  // shift left constant field by 2
  assign constx4 = {{14{instr[15]}},instr[15:0],2'b00};   //对线进行符号扩展并且*4
  assign Const={{16{Const1[15]}},Const1[15:0]};             //对线只进行符号扩展
  assign Jump ={pc[31:28],instr[25:0],2'b00};

  // register file address fields
  assign ra1 = instr[REGBITS+20:21];
  assign ra2 = instr[REGBITS+15:16];
  mux2       #(REGBITS) regmux(instr[REGBITS+15:16], instr[REGBITS+10:11], regdst, wa);
                                                              //指令寄存器右、靠上方的二路选择器

  parameter  CONST_4 = 32'b00000000000000000000000000000100;

  // datapath
  flopenr    #(WIDTH)  pcreg(clk, reset, pcen, nextpc, pc);   //程序计数器
  flop       #(WIDTH)  mdr(clk,   memdata, md);                 //存储器
  flop       #(WIDTH)  areg(clk, rd1, a);                        //A
  flop       #(WIDTH)  wrd(clk, rd2, writedata);              //B
  flop       #(WIDTH)  res(clk, aluresult, aluout);           //ALUout模块
  
  mux2       #(WIDTH)  adrmux(pc, aluout, 1'b1, adr);         //PC右边的二路选择器
    
  mux4       #(WIDTH)  src1mux(pc, a, writedata ,CONST_ONE, alusrca, src1);   //A右边的二路选择器
  mux4       #(WIDTH)  src2mux(writedata,CONST_4, Const, constx4, alusrcb, src2);       //B右边的四路选择器
  mux4       #(WIDTH)  pcmux(aluresult, aluout, Jump, a, pcsource, nextpc);
                                                             //ALUout右边的四路选择器   
  mux2       #(WIDTH)  wdmux(aluout, md, memtoreg, wd);       //指令寄存器右、靠下方的二路选择器 
  mux21       #(16)  kkmux(instr[15:0], instr[15:0], SorI, Const1);  //自己添加的寄存器组下面的二路选择器
  
  regfile    #(WIDTH,REGBITS) rf(clk, regwrite, ra1, ra2, wa, wd, rd1, rd2);
                                                              //寄存器组
  alu        #(WIDTH) alunit(src1, src2, alucont, aluresult,zero,sign,overflow); //ALU部件
 
endmodule
