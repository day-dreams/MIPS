
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
  assign constx4 = {{14{instr[15]}},instr[15:0],2'b00};   //���߽��з�����չ����*4
  assign Const={{16{Const1[15]}},Const1[15:0]};             //����ֻ���з�����չ
  assign Jump ={pc[31:28],instr[25:0],2'b00};

  // register file address fields
  assign ra1 = instr[REGBITS+20:21];
  assign ra2 = instr[REGBITS+15:16];
  mux2       #(REGBITS) regmux(instr[REGBITS+15:16], instr[REGBITS+10:11], regdst, wa);
                                                              //ָ��Ĵ����ҡ����Ϸ��Ķ�·ѡ����

  parameter  CONST_4 = 32'b00000000000000000000000000000100;

  // datapath
  flopenr    #(WIDTH)  pcreg(clk, reset, pcen, nextpc, pc);   //���������
  flop       #(WIDTH)  mdr(clk,   memdata, md);                 //�洢��
  flop       #(WIDTH)  areg(clk, rd1, a);                        //A
  flop       #(WIDTH)  wrd(clk, rd2, writedata);              //B
  flop       #(WIDTH)  res(clk, aluresult, aluout);           //ALUoutģ��
  
  mux2       #(WIDTH)  adrmux(pc, aluout, 1'b1, adr);         //PC�ұߵĶ�·ѡ����
    
  mux4       #(WIDTH)  src1mux(pc, a, writedata ,CONST_ONE, alusrca, src1);   //A�ұߵĶ�·ѡ����
  mux4       #(WIDTH)  src2mux(writedata,CONST_4, Const, constx4, alusrcb, src2);       //B�ұߵ���·ѡ����
  mux4       #(WIDTH)  pcmux(aluresult, aluout, Jump, a, pcsource, nextpc);
                                                             //ALUout�ұߵ���·ѡ����   
  mux2       #(WIDTH)  wdmux(aluout, md, memtoreg, wd);       //ָ��Ĵ����ҡ����·��Ķ�·ѡ���� 
  mux21       #(16)  kkmux(instr[15:0], instr[15:0], SorI, Const1);  //�Լ���ӵļĴ���������Ķ�·ѡ����
  
  regfile    #(WIDTH,REGBITS) rf(clk, regwrite, ra1, ra2, wa, wd, rd1, rd2);
                                                              //�Ĵ�����
  alu        #(WIDTH) alunit(src1, src2, alucont, aluresult,zero,sign,overflow); //ALU����
 
endmodule
