
## c程序
```c
/*
    预定义变量:   int *integers,num
*/
max = integers[0];
min = integers[0];
for(int i = 0; i != num; ++i){
    if(integers[i] < min)
        min = integers[i];
    if(max < integers[i])
        max = integers[i];
}
```
## 类汇编
假设$s1存放max，$s2存放min，$s3存放i,$s4存放integers地址，$s5存放num,$s6存放比较结果flag, $s7存放临时来自存储器的数据data，$s8存放最大值在内存中的地址ad_max，$s9存放最小值在内存中的地址ad_min,且数据已经到位
```assembly
LOOP_BEGIN: addi   i,     i,        1          #循环变量自增
            slt    flag,  i,        num        #循环次数控制，小于则置1
            beq    flag,  zero,     LOOP_END   #循环次数控制，为0则循环结束
MIN_BRANCH: lw     data,  integers, i          #取integers[i]
            slt    flag,  data,     min        #最小值比较
            beq    flag,  zero,     MAX_BRANCH #不小于则继续下个分支
            addi   min,   data,     0          #置min
MAX_BRANCH: slt    flag,  max,      data       #最大值比较
            beq    flag,  zero,     LOOP_BEGIN #不小于则继续下次循环
            addi   max,   data,     0          #置max
  LOOP_END: sw     max,   0(ad_max)            #存字
            sw     min,   0(ad_min)            #存字
```

目前一共5条指令: addi,slt,beq,lw,sw