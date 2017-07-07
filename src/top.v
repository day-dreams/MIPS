
`include"cpu.v"
`include"damemory.v"
`include"irmemory.v"

module top(input clk,reset);
    
    wire mem_write,mem_read;
    wire [31:0] read_address,write_address,write_data,mem_data;
   
    dmemory #(32,1024) IM(clk,mem_write,mem_read,read_address,write_address,write_data,mem_data);
    
    wire read;
    wire [31:0] address;
    wire [31:0] instruction;
    imemory #(32,1024)(clk,read,address,instruction);
       
    cpu CPU(clk,reset,mem_data,instruction,write_data,write_address,read_address,address,mem_write,mem_read);
           
       
endmodule