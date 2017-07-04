//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/05 07:31:35
// Design Name: 
// Module Name: config
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

//机器字长
parameter MACHINE_WIDTH   = 32;

//内存大小
parameter MEMORY_DEPTH    = 1024;

//数码管及片选信号的地址，只使用低位字节
parameter LED_SEG_ADDRESS  = 32'HFFFF;
parameter LED_PIN_CONTROL  = 32'HFFFE;

//5个按键的地址，只使用低位字节的第一位
parameter BUTTON_L_ADDRESS = 32'HFFFD;
parameter BUTTON_R_ADDRESS = 32'HFFFC;
parameter BUTTON_U_ADDRESS = 32'HFFFB;
parameter BUTTON_D_ADDRESS = 32'HFFFA;
parameter BUTTON_C_ADDRESS = 32'HFFF9;
