# c语言，汇编以及MIPS机器码



## 二进制转十进制显示部分
最大最小值的部分已经用到了13个寄存器，再使用其他的要从$13开始编号。**ADDR_SEEG_C**和**ADDR_SEG**见config.v。
```c
//for max
if(max<0)   
    true_max=~(max-1);//补码转原码
else
    true_max=max;
max_ones=0;
max_tens=0;
max_hunds=0;
max_thouds=0;
for(int i=0;i!=32;++i){
    max_thouds=max_thouds<<1+hunds>>3;
    max_huns=max_huns<<1+max_tens>>3;
    max_tens=max_tens<<1+max_tens>>3;
    max_ones=max_ones<<1+true_max>>(31-i);
    if(i==31)
        break;
    if(max_ones>4)
        max_ones+=3;
    if(max_tens>4)
        max_tens+=3;
    if(max_hunds>4)
        max_tens+=3;
    if(max_thouds>4)
        max_thouds+=3;
}

//for min;
if(min<0)
    true_min=~(min-1);
else
    true_min=min;
min_hunds=0;
min_thouds=0;
for(int i=0;i!=32;++i){
    min_thouds=min_thouds<<1+hunds>>3;
    min_huns=min_huns<<1+min_tens>>3;
    min_tens=min_tens<<1+min_tens>>3;
    min_ones=min_ones<<1+true_min>>(31-i);
    if(i==31)
        break;
    if(min_ones>4)
        min_ones+=3;
    if(min_tens>4)
        min_tens+=3;
    if(min_hunds>4)
        min_tens+=3;
    if(min_thouds>4)
        min_thouds+=3;
}

SCAN_TIMES=0;
SEG_SCAN:
    SCAN_TIMES+=0;
    if(SCAN_TIMES==32'd50000000 )//50000000大概是28位
        SCAN_TIMES=0;  
    temp=SCAN_TIMES>>26;//取当前扫描次数的最高两位
    dmem[ADDR_SEG_C]=temp;
    if(UP==1){
        if(temp==0)
            to_disp=max_ones;
        if(temp==1)
            to_disp=max_tens;
        if(temp==2)
            to_disp=max_hunds;
        if(temp==3)
            if(max<0)
                to_disp=0xffff;//触发负号                
            else
                to_disp=max_thouds;
    }
    if(UP==1){
        if(temp==0)
            to_disp=min_ones;
        if(temp==1)
            to_disp=min_tens;
        if(temp==2)
            to_disp=min_hunds;
        if(temp==3)
            if(min<0)
                to_disp=0xffff;//触发负号                
            else
                to_disp=min_thouds;
    }
    for(int k=0;k!=SCAN_TIMES;++k){
        if(to_disp==0)
            dmem[ADDR_SEG]=0x0003;
        if(to_disp==1)
            dmem[ADDR_SEG]=0x009f;
        if(to_disp==2)
            dmem[ADDR_SEG]=0x002d;
        if(to_disp==3)
            dmem[ADDR_SEG]=0x000d;
        if(to_disp==4)
            dmem[ADDR_SEG]=0x0099;
        if(to_disp==5)
            dmem[ADDR_SEG]=0x0045;
        if(to_disp==6)
            dmem[ADDR_SEG]=0x0041;
        if(to_disp==7)
            dmem[ADDR_SEG]=0x001f;
        if(to_disp==8)
            dmem[ADDR_SEG]=0x0001;
        if(to_disp==9)
            dmem[ADDR_SEG]=0x0015;
        else//负号
            dmem[ADDR_SEG]=0x00fd;            
    }
goto:SEG_SCAN


```