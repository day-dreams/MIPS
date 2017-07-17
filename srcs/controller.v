
module controller(input clk, reset, 
                 input      [5:0] op, 
                 input            zero,
                 input            sign,
                 input      [5:0] funct ,  
                 output reg       memread, memwrite, memtoreg, iord, 
                 output           pcen, 
                 output reg       regwrite, regdst, SorI,
                 output reg [1:0] pcsource, alusrcb,  alusrca, select,
                 output reg [5:0] aluop,
                 output reg  irwrite);
                 
  wire flag;
  wire [3:0] funct_sign;
  assign funct_sign = funct[5:2];
  wire temp = ~sign;
  mux4       #(1)  ttmux(zero, sign, temp ,1'b0 , select, flag);
  parameter   FETCH1  =  6'b000001;
  parameter   DECODE  =  6'b000101;
  parameter   MEMADR  =  6'b000110;
  parameter   LWRD    =  6'b000111;
  parameter   LWWR    =  6'b001000;
  parameter   SWWR    =  6'b001001;
  parameter   RTYPEEX =  6'b001010;
  parameter   RTYPEEY =  6'b001111;         //添加了R-type的类型数值
  parameter   RTYPEWR =  6'b001011;
  parameter   BEQEX   =  6'b001100;
  parameter   JEX     =  6'b001101;
  parameter   JR      =  6'b001110;
  parameter   IEX     =  6'b000010;
  parameter   IEXX    =  6'b000011;
//////////////////////////////////////////////////////////////////////////
  parameter   LW      =  6'b100011;
  parameter   SW      =  6'b101011;
  parameter   RTYPE   =  6'b000000;
  
  parameter   BEQ     =  6'b000100;
  parameter   AddI    =  6'b001000;
  parameter   AddIU   =  6'b001001;
  parameter   SLTI    =  6'b001010;  /////////////////////////////////////////////
  parameter   ANDI    =  6'b001100;
  parameter   ORI     =  6'b001101;
  parameter   XORI    =  6'b001110;
  parameter   LUI     =  6'b001111; 
  
  parameter   J       =  6'b000010;

  reg [5:0] state, nextstate;
  reg       pcwrite, pcwritecond;

  // state register
  always @(posedge clk)
     if(reset) state <= FETCH1;
     else state <= nextstate;

  // next state logic

  always @(*)
     begin
        case(state)
           FETCH1:  nextstate <= DECODE;
           DECODE:  case(op)
                       LW:      nextstate <= MEMADR;
                       SW:      nextstate <= MEMADR;
                       RTYPE:  
                          case  (funct_sign)
                              4'b0000: nextstate <= RTYPEEY;   //R-TYPE 中的SAM输入型
                              4'b0010: nextstate <= JR;
                              default: nextstate <= RTYPEEX;   //R-TYPE 中的双寄存器型
                          endcase
                       
                       BEQ:     nextstate <= BEQEX;
                       J:       nextstate <= JEX; 
                       AddI:    nextstate <= IEX;
                       AddIU:   nextstate <= IEX;
                       SLTI:    nextstate <= IEX;
                       ANDI:     nextstate <= IEX;
                       ORI:     nextstate <= IEX;
                       XORI:    nextstate <= IEX;
                       LUI:     nextstate <= IEX;            
                       default: nextstate <= FETCH1; // should never happen
                    endcase
           MEMADR:  case(op)
                       LW:      nextstate <= LWRD;
                       SW:      nextstate <= SWWR;
                       default: nextstate <= FETCH1; // should never happen
                    endcase
           LWRD:    nextstate <= LWWR;
           LWWR:    nextstate <= FETCH1;         //将存取字节指令的名称全部改为存取字(将LBRD/LBWR/SWWR改为LWRD/LEER/SWWR)
           SWWR:    nextstate <= FETCH1;
           RTYPEEX: nextstate <= RTYPEWR;
           RTYPEEY: nextstate <= RTYPEWR;         //增加R-TYPE型的sam输入类型
           RTYPEWR: nextstate <= FETCH1;
           BEQEX:   nextstate <= FETCH1;
           JEX:     nextstate <= FETCH1;
           JR:      nextstate <= FETCH1;
           IEX:     nextstate <= IEXX;
           IEXX:    nextstate <= FETCH1;
           default: nextstate <= FETCH1; // should never happen
        endcase
      
     end
       
           
  always @(*)
     begin
           // set all outputs to zero, then conditionally assert just the appropriate ones
           irwrite <= 0;                  //irwrite
           pcwrite <= 0; pcwritecond <= 0;
           regwrite <= 0; regdst <= 0;
           memread <= 0; memwrite <= 0;
           alusrca <= 0; alusrcb <= 2'b00; aluop <= 2'b00;
           pcsource <= 2'b00;
           iord <= 0; memtoreg <= 0;
           case(state)
              FETCH1: //TODO:需要修改成哈弗结构的控制信号
                 begin
                    // memread <= 1; 
                     irwrite <= 1;
                    alusrcb <= 2'b01; 
                    pcwrite <= 1;
                 end
              
              DECODE: alusrcb <= 2'b11;
              MEMADR:
                 begin
                    alusrca <= 2'b01;
                    alusrcb <= 2'b10;
                 end
              LWRD:
                 begin
                    memread <= 1;
                    iord    <= 1;
                 end
              LWWR:
                 begin
                    regwrite <= 1;
                    memtoreg <= 1;
                 end
               SWWR:
                 begin
                     memwrite<=1;
                     iord<=1;
                 end
             RTYPEEX:
                 begin
                 alusrca <=2'b01;
                 alusrcb <=2'b00;
                 aluop <= 2'b10;
                 end
                     
              RTYPEEY:
                  begin
                    alusrca <= 2'b10;
                    alusrcb <= 2'b10;
                    aluop   <= 2'b10;
                    SorI    <=1;
                  end
              RTYPEWR:
                 begin
                    regdst   <= 1;
                    regwrite <= 1;
                 end
              BEQEX:
                 begin
                    alusrca     <= 2'b01;
                    aluop       <= 2'b01;
                    pcwritecond <= 1;
                    alusrcb     <= 2'b00;
                    pcsource    <= 2'b01;
                      case(op)
                       6'b000100: select<=2'b00;  // beq
                      endcase
                 end
              JEX:
                 begin
                    pcwrite  <= 1;
                    pcsource <= 2'b10;
                 end
              JR:
                  begin
                    pcwrite  <= 1;
                    pcsource <= 2'b11;
                 end
              AddI:begin

                end
              IEX:
                 begin
                    alusrca  <= 2'b01;
                    SorI     <= 0;
                    alusrcb  <= 2'b10;
                    aluop    <= op;
                 end
              IEXX:
                 begin
                   regdst<=0;
                   regwrite<=1;
                   memtoreg<=0;
                 end    
        endcase
     end
         
  assign pcen = pcwrite | (pcwritecond & (flag)); // program counter enable
endmodule