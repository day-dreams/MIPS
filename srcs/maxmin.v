module maxmin #(parameter WIDTH = 32, REGBITS = 5)(
   input clk,
   input reset,
   input up,
   input down,
   output [3:0] AN,
   output [7:0] CX
   );

   wire                memread, memwrite; //�洢���� �洢��д�ź�
   wire    [WIDTH-1:0] adr, writedata;    //�洢��д��ַ д����
   wire    [WIDTH-1:0] memdata;
   wire    [WIDTH-1:0] imem_adr;//ָ��Ĵ�������ַ
   wire    [WIDTH-1:0] imemdata;
   

   // instantiate devices to be tested
   mips #(WIDTH, REGBITS) dut(clk, reset, memdata,imemdata, 
                            memread, memwrite, adr, writedata,imem_adr);
   
   // external memory for code and data
   dmemory #(WIDTH) dmem(clk,reset,up,down, memwrite, adr, writedata, memdata,AN,CX);

   imemory #(WIDTH) imem(clk,reset,imem_adr,imemdata);
endmodule







