/**
 * @author [��骣�����ţ�������]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:51:22
 * @modify date 2017-07-09 09:51:22
 * @desc [description]
*/

`ifndef CONFIG
`define CONFIG

//�����ֳ�
parameter MACHINE_WIDTH   = 32;

//�ڴ��С
parameter MEMORY_DEPTH    = 1024;

//�Ĵ����ѵĵ�ַ���
parameter REGISTER_ADDRESS_WIDTH=5;

//�Ĵ�������
parameter REGISTER_NUM=32;

//���ֵ��Сֵ��ŵ�ַ
parameter MAX_NUM_ADDRESS=32'H00F0;//0-3
parameter MIN_NUM_ADDRESS=32'H00F4;//4-7

//״̬�����
parameter STATE_FX          = 5'b00001;
parameter STATE_DECODE      = 5'b00010;
parameter STATE_MEMADR      = 5'b00110;
parameter STATE_LBRD        = 5'b00111;
parameter STATE_LBWR        = 5'b01000;
parameter STATE_SBWR        = 5'b01001;
parameter STATE_RTYPEEX     = 5'b01010;
parameter STATE_RTYPEWR     = 5'b01011;
parameter STATE_BEQCALPC    = 5'b01100;
parameter STATE_BEQEQUAL    = 5'b01101;
parameter STATE_BEQSETPC    = 5'b01110;
parameter STATE_PCADD       = 5'b01111;
parameter STATE_ADDEX       = 5'b10000;
parameter STATE_ADDWR       = 5'b10001;

//ָ�������
parameter OPCODE_LEN        = 6;
parameter OPCODE_LB         = 6'b100000;        //���ڴ�ȡ��
parameter OPCODE_SB         = 6'b101000;        //���ڴ����
parameter OPCODE_RTYPE      = 6'b0;             //��������ָ���ʵ����Ҫʹ��addi��slt
parameter OPCODE_BEQ        = 6'b000100;        //������֧
parameter OPCODE_J          = 6'b000010;        //��������ת 
//OPCODE_ADD: opcode+func��ͬ�ж�
parameter FUNC_ADD          = 6'b100000;

`endif