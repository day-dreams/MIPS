`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/05 08:06:32
// Design Name: 
// Module Name: top
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
`include"irmemmory.v"
`include"damemmory.v"
`include"cpu.v"
//����ģ�飬��������im��dm��cpu
module top();

    reg clk;                                        //ʱ���ź�
    reg reset;                                      //�����ź�
    
    wire [MACHINE_WIDTH-1:0] dm_data;               //���������ڴ������
    wire [MACHINE_WIDTH-1:0] im_data;               //����ָ���ڴ��ָ��
    
    wire [MACHINE_WIDTH-1:0] dm_address;            //���������ڴ�ĵ�ַ
    wire [MACHINE_WIDTH-1:0] im_address;            //����ָ���ڴ�ĵ�ַ
    
    wire                      data_mem_read;        //�����ڴ���ź�
    wire                      data_mem_write;       //�����ڴ�д�ź�
    
    wire                      inst_mem_read;        //ָ���ڴ���ź�
    
    wire [MACHINE_WIDTH-1:0]  data_to_dm;           //д�������ڴ������
    
    dmemory #(MACHINE_WIDTH,MEMORY_DEPTH)   dm(clk,data_mem_write,data_mem_read,
                                               dm_address,data_to_dm,dm_data); 
    
    imemory #(MACHINE_WIDTH,MEMORY_DEPTH)   im(clk,inst_mem_read,
                                               im_address,im_data);
    
    cpu #(MACHINE_WIDTH,MEMORY_DEPTH)       cpu(clk,reset,dm_data,im_data,data_to_dm,
                                                dm_address,im_address,data_mem_write,
                                                data_mem_read,inst_mem_read);
    initial begin
    	$monitor("[TOP] dm_data=%x, im_data=%x, dm_address=%x, im_address=%x,data_mem_read=%x, data_mem_write=%x, inst_mem_read=%x,data_to_dm=%x",
                    dm_data,
                    im_data,
                    dm_address,
                    im_address,
                    data_mem_read,
                    data_mem_write,
                    inst_mem_read,
                    data_to_dm
                );
    end
    
    
endmodule
