`ifndef DAMEMORY
`define DAMEMORY

`include"config.v"
`include"segled.v"

//数据内存,默认为 1024*4 Byte，带读写信号
module dmemory #(parameter WIDTH=32,DEPTH=1024)(
    input                     clk,reset,
    input                     mem_write,
    input                     mem_read,
    input       [WIDTH-1:0]   read_address,write_address,
    input       [WIDTH-1:0]   write_data,
    output      [WIDTH-1:0]   mem_data,
    input  wire              seg_c1 ,
    input  wire              seg_c2 ,
    input  wire              seg_c3 ,
    input  wire              seg_c4 ,
    input  wire               seg_a ,
    input  wire               seg_b ,
    input  wire               seg_c ,
    input  wire               seg_e ,
    input  wire               seg_d ,
    input  wire               seg_f ,
    input  wire               seg_g ,
    input  wire               seg_h 
    );
    
    reg    [WIDTH-1:0]   mem[DEPTH-1:0];
    reg     [WIDTH-1:0] data;
    assign mem_data=data;
    /*
            TODO:添加数据读入、数码管、防抖动逻辑
    */

    always @(posedge clk) begin
        case ({mem_write,mem_read})
            2'b00:  ;//do nothing 
            2'b01:  data     <= mem[read_address];
            2'b10:  mem[write_address] <= write_data;
            2'b11:  ;//do nothing and abort !;
        endcase
    end
    
    //数码管逻辑
    initial begin//初始化
       mem[LED_SEG_ADDRESS]=32'H1234; 
    end
    
    segled_eynamDisp (clk,reset,
   mem[LED_SEG_ADDRESS] ,
   seg_c1,
   seg_c2,
   seg_c3,
   seg_c4,
   seg_a ,
   seg_b ,
   seg_c ,
   seg_e ,
   seg_d ,
   seg_f ,
   seg_g ,
   seg_h);
    
endmodule

`endif