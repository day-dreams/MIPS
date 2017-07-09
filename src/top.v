
`include"cpu.v"
`include"damemory.v"
`include"irmemory.v"

module top(
input clk,
input reset,
input button_up,
input button_down,
output wire              seg_c1 ,
output wire              seg_c2 ,
output wire              seg_c3 ,
output wire              seg_c4 ,                       
output wire               seg_a ,
output wire               seg_b ,
output wire               seg_c ,
output wire               seg_e ,
output wire               seg_d ,
output wire               seg_f ,
output wire               seg_g ,
output wire               seg_h );
    
    wire mem_write,mem_read;
    wire [31:0] read_address,write_address,write_data,mem_data;
   
    dmemory #(32,1024) DM(clk,reset,mem_write,mem_read,read_address,write_address,write_data,mem_data,
                            seg_c1,seg_c2,seg_c3,seg_c4,
                            seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g,seg_h,
                            button_up,button_down);
    
    wire read;
    wire [31:0] address;
    wire [31:0] instruction;
    imemory #(32,1024) IM(clk,read,address,instruction);
       
    cpu CPU(clk,reset,mem_data,instruction,write_data,
            write_address,read_address,address,mem_write,mem_read);
           
       
endmodule