`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/05 08:54:21
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include"config.v"
`include"regfile.v"
`include"alucontroller.v"
`include"alu.v"

//cpuģ�飬���𷢳��ڴ��д�źţ������ڴ�����
module cpu #(parameter WIDTH=32,DEPTH=1024) (
    input                         clk,
    input                         reset,
    input       [WIDTH-1:0]       data_from_dm,
    input       [WIDTH-1:0]       data_from_im,
    output      [WIDTH-1:0]       data_to_dm,
    output      [WIDTH-1:0]       address_to_dm,address_to_im, 
    output                        dm_write,dm_read,
    output                        im_read  
    );
    
    //{{{0�߼�
    
    wire         [WIDTH-1:0]         zero;
    assign zero=0;      
    
    //}}}
    
    
    //{{{�Ĵ�����
    reg                             reg_write;
    reg        [REGISTER_NUM-1:0]   read_address_1,read_address_2,write_address;
    reg        [WIDTH-1:0]          data_to_register;
    reg        [WIDTH-1:0]          data_from_rf_1,data_from_rf_2;
    
    initial begin
        $monitor("[CPU:44] reg_write=%x,ra1=%x,ra2=%x,wa=%x,data_to_register=%x,dr1=%x,dr2%x",
                    reg_write,
                    read_address_1,
                    read_address_2,
                    write_address,
                    data_from_rf_1,
                    data_from_rf_2);
    end
    
    regfile  #(WIDTH,REGISTER_NUM)  registers(clk,reg_write,read_address_1,read_address_2,write_address,data_from_rf_1,data_from_rf_2);
                                            
    //}}}
    
    
    //{{{״̬���߼�
    
    reg        [WIDTH-1:0]          pc;//ָ�������
    
    
    //}}}
    
endmodule
