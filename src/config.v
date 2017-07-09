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


//����ܼ�Ƭѡ�źŵĵ�ַ��ֻʹ�õ�λ�ֽ�
parameter LED_SEG_ADDRESS  = 32'HFFFF;
parameter LED_PIN_CONTROL  = 32'HFFFE;

//5�������ĵ�ַ��ֻʹ�õ�λ�ֽڵĵ�һλ
parameter BUTTON_L_ADDRESS = 32'HFFFD;
parameter BUTTON_R_ADDRESS = 32'HFFFC;
parameter BUTTON_U_ADDRESS = 32'HFFFB;
parameter BUTTON_D_ADDRESS = 32'HFFFA;
parameter BUTTON_C_ADDRESS = 32'HFFF9;

//���ֵ��Сֵ��ŵ�ַ
parameter MAX_NUM_ADDRESS=32'H00F0;//0-3
parameter MIN_NUM_ADDRESS=32'H00F4;//4-7



//״̬�����
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


//ָ�������
parameter OPCODE_LEN        = 6;
parameter OPCODE_LB         = 6'b100000;        //���ڴ�ȡ��
parameter OPCODE_SB         = 6'b101000;        //���ڴ����
parameter OPCODE_RTYPE      = 6'b0;             //��������ָ���ʵ����Ҫʹ��addi��slt
parameter OPCODE_BEQ        = 6'b000100;        //������֧
parameter OPCODE_J          = 6'b000010;        //��������ת 


`endif