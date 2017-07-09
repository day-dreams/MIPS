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


//数码管及片选信号的地址，只使用低位字节
parameter LED_SEG_ADDRESS  = 32'HFFFF;
parameter LED_PIN_CONTROL  = 32'HFFFE;

//5个按键的地址，只使用低位字节的第一位
parameter BUTTON_L_ADDRESS = 32'HFFFD;
parameter BUTTON_R_ADDRESS = 32'HFFFC;
parameter BUTTON_U_ADDRESS = 32'HFFFB;
parameter BUTTON_D_ADDRESS = 32'HFFFA;
parameter BUTTON_C_ADDRESS = 32'HFFF9;

//最大值最小值存放地址
parameter MAX_NUM_ADDRESS=32'H00F0;//0-3
parameter MIN_NUM_ADDRESS=32'H00F4;//4-7



//状态机标记
parameter STATE_FX          = 4'b0001;
parameter STATE_DECODE      = 4'b0010;
parameter STATE_MEMADR      = 4'b0110;
parameter STATE_LBRD        = 4'b0111;
parameter STATE_LBWR        = 4'b1000;
parameter STATE_SBWR        = 4'b1001;
parameter STATE_RTYPEEX     = 4'b1010;
parameter STATE_RTYPEWR     = 4'b1011;
parameter STATE_BEQCALPC    = 4'b1100;
parameter STATE_BEQEQUAL    = 4'b1101;
parameter STATE_BEQSETPC    = 4'b1110;
parameter STATE_PCADD       = 4'b1111;


//指令操作码
parameter OPCODE_LEN        = 6;
parameter OPCODE_LB         = 6'b100000;        //从内存取数
parameter OPCODE_SB         = 6'b101000;        //向内存读数
parameter OPCODE_RTYPE      = 6'b0;             //立即数型指令，本实现主要使用addi，slt
parameter OPCODE_BEQ        = 6'b000100;        //相等则分支
parameter OPCODE_J          = 6'b000010;        //无条件跳转 


`endif