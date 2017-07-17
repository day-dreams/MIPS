
module alu #(parameter WIDTH = 32)
           (input      [WIDTH-1:0] a, b, 
            input      [4:0]       alucont, 
            output reg [WIDTH-1:0] result,
            output reg  zero,sign,
            output    overflow
            );

  wire     [WIDTH-1:0] sub , sum, slt, sll , srl , sra , Or , And , Xor , Nor , lui;
  wire[5:0]    b1;
  wire   zero1,sign1;
  always@(*)
   zero=zero1;
   always@(*)
   sign=sign1;
  assign b1=b[10:6];
  
  assign sub = a - b; 
  assign sum = a + b;
  // slt should be 1 if most significant bit of sum is 1
  assign slt = sub[WIDTH-1];
  
  assign sll =  a<<b1;
  assign srl =  a>>b1;
  assign sra =  {a[WIDTH-1],a[WIDTH-1:1]>>b1};
  assign Or = a|b;
  assign And = a&b;
  assign Xor = a^b;
  assign Nor = ~(a|b);
  assign lui =(b<<16)&(32'b11111111111111110000000000000000);
  
   zerodetect #(WIDTH) zd(result, zero1);                //零标志位信号部件
   signdetect #(WIDTH) sd(result, sign1);
   overflowdetect #(WIDTH) od(result, a,b,alucont ,overflow); 
   
 

  always@(*)begin
            case(alucont[4:0])   
        5'b00010: result = sum;
        5'b00110: result = sub;
        5'b00000: result = And;
        5'b00001: result = Or;
        5'b00110: result = slt;
        5'b01001: result = sll;
        5'b01010: result = srl;
        5'b01011: result = sra;
        
        5'b00111: result = slt;//这条是addu的加法        
        
        5'b01101: result = sub;//这条是subu的减法
        5'b01110: result = Xor;
        5'b01111: result = Nor;
        5'b10000: result = lui;
      
     endcase
      //$display("opa:%b,opb=%b,result=%b,alucont=%b",a,b,result,alucont);       
     end
endmodule