
module led (
   input clk,
   input reset,
   input [31:0] max,//表示最大数
   input [31:0] min, //表示最小数
   input up,
   input down,
    output wire [3:0] LedW,  //数码管片选信号
   output wire [7:0] tub//每个数码管的亮灯情况

   ); 
    reg [7:0] Led1=8'b00000010;
   reg [7:0] Led2=8'b00000010;
   reg [7:0] Led3=8'b00000010;
   reg [7:0] Led4=8'b00000010;
   
   reg [3:0] num1=4'b0000;   
   reg [3:0] num2=4'b0000; 
   reg [3:0] num3=4'b0000; 
   reg [3:0] num4=4'b0000; 
   
   reg [3:0] Ledw=4'b1110;
   reg [7:0] Led=8'b11111101;
   assign tub=Led;
   assign LedW=Ledw;
   reg [0:25] y=26'b0;
   reg cclk=1'b0;
   
 always @(posedge cclk)
          begin
              case(Ledw)
              4'b1110:
              begin
                  Led=~Led2;
                  Ledw=4'b1101;
              end
              4'b1101:
              begin
                  Led=~Led3;
                  Ledw=4'b1011;
              end
              4'b1011:
              begin
                  Led=~Led4;
                  Ledw=4'b0111;
              end
              4'b0111:
              begin
                  Led=~Led1;  
                  Ledw=4'b1110;
              end
              endcase
          end
    
      always @(posedge clk)
          begin
            //$display("%b.......%b",min,max);
           
                  if(up==1'b1)
                  begin
                      num1=max[3:0];
                      num2=max[7:4];
                      num3=max[11:8];
                      num4=max[15:12];
                  end
                  else if(down==1'b1)
                  begin
                      num1=min[3:0];
                      num2=min[7:4];
                     num3=min[11:8];
                     num4=min[15:12];
                  end
                  if(up==1'b1||down==1'b1)
                  begin
                  case(num1)
                      4'b0000:
                          Led1=8'b11111100;
                      4'b0001:
                          Led1=8'b01100000;
                      4'b0010:
                          Led1=8'b11011010;
                      4'b0011:
                          Led1=8'b11110010;
                      4'b0100:
                          Led1=8'b01100110;
                      4'b0101:
                          Led1=8'b10110110;
                      4'b0110:
                          Led1=8'b10111110;
                      4'b0111:
                          Led1=8'b11100000;
                      4'b1000:
                          Led1=8'b11111110;
                      4'b1001:
                          Led1=8'b11110110;
                       4'b1010:
                           Led1=8'b11101110;
                       4'b1011:
                          Led1=8'b00111110;
                       4'b1100:
                          Led1=8'b10011100;
                       4'b1101:
                          Led1=8'b01111010;
                       4'b1110:
                          Led1=8'b10011110;
                       4'b1111:
                         Led1=8'b10001110;
                      default:;    
                  endcase
                  
                  case(num2)
                      4'b0000:
                          Led2=8'b11111100;
                      4'b0001:
                          Led2=8'b01100000;
                      4'b0010:
                          Led2=8'b11011010;
                      4'b0011:
                          Led2=8'b11110010;
                      4'b0100:
                          Led2=8'b01100110;
                      4'b0101:
                          Led2=8'b10110110;
                      4'b0110:
                          Led2=8'b10111110;
                      4'b0111:
                          Led2=8'b11100000;
                      4'b1000:
                          Led2=8'b11111110;
                      4'b1001:
                          Led2=8'b11110110;
                      4'b1010:
                         Led2=8'b11101110;
                     4'b1011:
                         Led2=8'b00111110;
                     4'b1100:
                         Led2=8'b10011100;
                     4'b1101:
                         Led2=8'b01111010;
                     4'b1110:
                         Led2=8'b10011110;
                     4'b1111:
                         Led2=8'b10001110;
                      default:;    
                  endcase
  
                  case(num3)
                      4'b0000:
                          Led3=8'b11111100;
                      4'b0001:
                          Led3=8'b01100000;
                      4'b0010:
                          Led3=8'b11011010;
                      4'b0011:
                          Led3=8'b11110010;
                      4'b0100:
                          Led3=8'b01100110;
                      4'b0101:
                          Led3=8'b10110110;
                      4'b0110:
                          Led3=8'b10111110;
                      4'b0111:
                          Led3=8'b11100000;
                      4'b1000:
                          Led3=8'b11111110;
                      4'b1001:
                          Led3=8'b11110110;
                     4'b1010:
                          Led3=8'b11101110;
                     4'b1011:
                         Led3=8'b00111110;
                     4'b1100:
                         Led3=8'b10011100;
                     4'b1101:
                         Led3=8'b01111010;
                     4'b1110:
                         Led3=8'b10011110;
                     4'b1111:
                         Led3=8'b10001110;
                      default:;    
                  endcase
  
                  case(num4)
                      4'b0000:
                          Led4=8'b11111100;
                      4'b0001:
                          Led4=8'b01100000;
                      4'b0010:
                          Led4=8'b11011010;
                      4'b0011:
                          Led4=8'b11110010;
                      4'b0100:
                          Led4=8'b01100110;
                      4'b0101:
                          Led4=8'b10110110;
                      4'b0110:
                          Led4=8'b10111110;
                      4'b0111:
                          Led4=8'b11100000;
                      4'b1000:
                          Led4=8'b11111110;
                      4'b1001:
                          Led4=8'b11110110;
                      4'b1010:
                         Led4=8'b11101110;
                     4'b1011:
                         Led4=8'b00111110;
                     4'b1100:
                         Led4=8'b10011100;
                     4'b1101:
                         Led4=8'b01111010;
                     4'b1110:
                         Led4=8'b10011110;
                     4'b1111:
                         Led4=8'b10001110;
                      default:;    
                  endcase
                  end
              
             
              if(y==26'd0)
              begin
                  y=26'd10000;
                  cclk<=~cclk;
              end
              y=y-26'd1;
          end
          
endmodule // led
