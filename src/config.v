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

//�����ֳ�
parameter MACHINE_WIDTH   = 32;

//�ڴ��С
parameter MEMORY_DEPTH    = 1024;

//����ܼ�Ƭѡ�źŵĵ�ַ��ֻʹ�õ�λ�ֽ�
parameter LED_SEG_ADDRESS  = 32'HFFFF;
parameter LED_PIN_CONTROL  = 32'HFFFE;

//5�������ĵ�ַ��ֻʹ�õ�λ�ֽڵĵ�һλ
parameter BUTTON_L_ADDRESS = 32'HFFFD;
parameter BUTTON_R_ADDRESS = 32'HFFFC;
parameter BUTTON_U_ADDRESS = 32'HFFFB;
parameter BUTTON_D_ADDRESS = 32'HFFFA;
parameter BUTTON_C_ADDRESS = 32'HFFF9;
