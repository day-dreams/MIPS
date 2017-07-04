# 一些参数设置

* 机器字长  
    默认为32位

* 寄存器个数  
    默认为32位 

* 指令、数据、地址字长  
    默认为32位

* 内存结构  
    采用数据和指令分离的哈弗结构，各4KB
    
* 外设地址
```verilog
//数码管及片选信号的地址，只使用低位字节
parameter LED_SEG_ADDRESS  = 32'HFFFF;
parameter LED_PIN_CONTROL  = 32'HFFFE;

//5个按键的地址，只使用低位字节的第一位
parameter BUTTON_L_ADDRESS = 32'HFFFD;
parameter BUTTON_R_ADDRESS = 32'HFFFC;
parameter BUTTON_U_ADDRESS = 32'HFFFB;
parameter BUTTON_D_ADDRESS = 32'HFFFA;
parameter BUTTON_C_ADDRESS = 32'HFFF9;
```
