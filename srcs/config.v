/**
 * @author [张楠，金宏昱，李依涵]
 * @email [749832428@qq.com]
 * @create date 2017-07-09 09:51:22
 * @modify date 2017-07-09 09:51:22
 * @desc [description]
*/

`ifndef CONFIG
`define CONFIG

//机器字长
parameter MACHINE_WIDTH   = 32;

//内存大小
parameter MEMORY_DEPTH    = 1024;

//寄存器堆的地址宽度
parameter REGISTER_ADDRESS_WIDTH=5;

//寄存器个数
parameter REGISTER_NUM=32;

//最大值最小值存放地址
parameter MAX_NUM_ADDRESS=32'H00F0;//0-3
parameter MIN_NUM_ADDRESS=32'H00F4;//4-7

//状态机标记
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

//指令操作码
parameter OPCODE_LEN        = 6;
parameter OPCODE_LB         = 6'b100000;        //从内存取数
parameter OPCODE_SB         = 6'b101000;        //向内存读数
parameter OPCODE_RTYPE      = 6'b0;             //立即数型指令，本实现主要使用addi，slt
parameter OPCODE_BEQ        = 6'b000100;        //相等则分支
parameter OPCODE_J          = 6'b000010;        //无条件跳转 
//OPCODE_ADD: opcode+func共同判断
parameter FUNC_ADD          = 6'b100000;

`endif