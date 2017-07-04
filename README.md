# 基于MIPS的cpu实现
<!-- TOC -->

- [基于MIPS的cpu实现](#基于mips的cpu实现)
    - [实现流程](#实现流程)
        - [分析程序需要哪些指令](#分析程序需要哪些指令)
        - [设计cpu架构和指令系统](#设计cpu架构和指令系统)
        - [cpu实现和程序翻译](#cpu实现和程序翻译)
        - [测试](#测试)
    - [需要考虑的细节](#需要考虑的细节)
        - [按键防抖动](#按键防抖动)
        - [数码管的扫描](#数码管的扫描)
    - [今天要做的事情](#今天要做的事情)
    - [参考链接](#参考链接)

<!-- /TOC -->

## 实现流程

这里先说说整个的实现流程，暂定目标是实现基本的题目要求(类MIPS的精简cpu和最大最小值程序)。

### 分析程序需要哪些指令
先从程序入手，如果是c语言，不考虑任何的优化问题，咱们的程序大致如下：
```c
/*
    预定义变量:   int *integers,num
*/
max=integers[0];
min=integers[0];
for(int i=0;i!=num;++i){
    if(integers[i]<min)
        min=integers[i];
    if(integers[i]>max)
        max=integers[i];
}
```
可以先想想这个程序需要那些指令，按照Weihai-MIPS写出汇编指令。汇编语言翻译成二进制代码暂不考虑。

### 设计cpu架构和指令系统
这一步要先约定好指令格式，是最重要的环节。

### cpu实现和程序翻译
这是两件可以并行的事情。实现的时候应该避免重复造轮子，比如加法器，完全可以参考他人的代码。

### 测试
先仿真测试，再写入开发板测试。

## 需要考虑的细节
目前能想到的。
### 按键防抖动
EDA中有过经验，相对容易。

### 数码管的扫描    
EDA中有过经验，相对容易。

## 今天要做的事情

|tasks|status|details|create date|finish date|负责人|
|-|-|-|-|-|-|
|初步测试前人代码|完成|基本可用，但结构粗糙，需要重构|2017-07-04|2017-07-05|JHY + LYH|
|思考需要的指令集|完成|5条指令，均在WEIHAI-MIPS中，可能需要加入NOP空悬指令|2017-07-04|2017-07-05|JHY + LYH + ZN|
|查阅MIPS指令流水的资料|完成|已经看懂了实现原理，但需要重点解决冲突问题|2017-07-04|2017-07-05|ZN|
|重构MIPS|未完成|参考指导书的代码，需要加入哈佛结构|2017-07-04||JHY + LYH + ZN|
|重构MIPS|未完成|向数据内存中加入译码+数码管逻辑|2017-07-04||JHY + LYH + ZN|


## 参考链接

[计算机体系结构--流水线技术](http://www.cnblogs.com/CorePower/p/CorePower.html)

[verilog实现16位五级流水线的CPU带Hazard冲突处理](http://www.cnblogs.com/wsine/p/4661147.html)

[MIPS的五级流水线](http://imgtec.eefocus.com/article/10-07/1968501278904262.html)

[mips-cpu - A MIPS CPU written in Verilog](https://github.com/jmahler/mips-cpu)