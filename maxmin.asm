# �����Сֵ+������תʮ����+�����ɨ��

			addi $5,  	$0, 		0         	  # numΪѭ������ 20			
			addi $5,  	$0, 		20         	  # numΪѭ������ 20
            addi $4,  	$0, 	    0             # intָ��
			addi $1,  	$0, 		2             # ��һ������
			addi $2,  	$0, 		2		  	  # ��һ������ 
            addi $3,    $0,    		0             # ѭ�������ĳ�ֵ 0
            addi $6,    $0,         0
            addi $7,    $0,         0
            addi $8, 	$0,         0x1000
			addi $9,    $0,         0x1004
            addi $10,  	$0, 		1
            addi $11,   $0,         0
            addi $12,   $0,         0
            addi $13,   $0,         0
            addi $14,   $0,         0
            addi $15,   $0,         0
            addi $15,   $0,         0
            addi $16,   $0,         0
            addi $17,   $0,         0
            addi $18,   $0,         0
            addi $19,   $0,         0
            addi $20,   $0,         0
            addi $21,   $0,         0
            addi $22,   $0,         0
            addi $23,   $0,         0
            addi $24,   $0,         0
            addi $25,   $0,         0
            addi $26,   $0,         0
            addi $27,   $0,         0
            addi $28,   $0,         0

            
LOOP_BEGIN: addi $3,    $3,    		1             # ѭ����������
			sub  $12,   $3,         $5
			slti $6, 	$12,        0             # i < num, ����$6Ϊ1
			beq  $6, 	$0, 		LOOP_END      # ѭ���������ƣ�Ϊ0ʱѭ������
			addi  $4,	$4,			4
			add  $11, 	$4,  		$0		      # ���׵�ַ����i����

MIN_BRANCH: lw   $7, 	0($11)                    # ��ʼȡ20�����֣�ÿ�μ�1
			sub  $12,   $7,         $2
			slti $6,	$12, 		0             # data < min ����$6Ϊ1
			beq  $6, 	$0, 		MAX_BRANCH    # $6 ���� 0�� ˵�� data > min��������һ��֧
			addi $2,  	$7, 		0             # data < min, �� data ��ֵ���µ� $2 ��
			beq  $6  	$10,  		LOOP_BEGIN	

MAX_BRANCH: sub  $12,   $1,         $7
			slti $6, 	$12,  	    0             # $1 < data, ����$6Ϊ1
			beq  $6, 	$0, 		LOOP_BEGIN    # $6 == 0, �� $1 > data, �ص�ѭ����ʼ	
            addi $1,  	$7, 		0             # ����$1
			beq  $6  	$10, 	 	LOOP_BEGIN	
			
  LOOP_END: sw   $1,  	0($8)		  		      # �����ֵ�����ֵ�ĵ�ַ
			sw   $2,  	0($9) 		              # ����Сֵ����Сֵ�ĵ�ַ
	  
      
      
      
# �õ�0x80000000
    addi	$26, $0, 1			# $26 = $t1 + 0
    sll     $26,$26,31     
    addi    $27,$0,31             # FOR_BEQ
    addi    $28,$0,4
# �õ����ֵ�ľ���ֵ��ԭ��
    slti    $6,$1,0
    beq     $6,$0,POSITIVE_MAX
    sub     $13,$0,$1
    beq     $0,$0,POSITIVE_MAX_PLUS
POSITIVE_MAX:#���ֵ������
    addi	$13, $1, 0			# $13 = max + 0
POSITIVE_MAX_PLUS:
# ��ʼ�������ֵ��ʮ����λ
    addi	$15, $0, 0			# $15 = 0 + 0
    addi    $16,$0,0
    addi    $17,$0,0
    addi    $18,$0,0
    addi    $3,$0,0
LOOP_FOR_MAX_BEGIN:#���ֵbin2bcdѭ������ʼ
    sub     $12,$3,32
    slti    $6,$12,0
    beq     $6,$0,LOOP_FOR_MAX_END#ѭ�������ﵽ32�����ѭ��

    # for $18
    sll     $18,$18,29
    srl     $18,$18,28
    srl     $11,$17,3
    add     $18,$18,$11
    # for $17
    sll     $17,$17,29
    srl     $17,$17,28
    srl     $11,$16,3
    add     $17,$17,$11
    # for $16
    sll     $16,$16,29
    srl     $16,$16,28
    srl     $11,$15,3
    add     $16,$16,$11
    # for $15
    sll     $15,$15,29
    srl     $15,$15,28
    and     $11,$13,$26
    srl     $11,$11,31
    add     $15,$15,$11
    # for break:i==31
    beq     $3,$27,LOOP_FOR_MAX_END
    # for add 3
    # for $15
    sub     $11,$28,$15
    slti    $6,$11,0
    beq     $6,$0,MAX_ONES_END
    addi    $15,$15,3
MAX_ONES_END:
    # for $16
    sub     $11,$28,$16
    slti    $6,$11,0
    beq     $6,$0,MAX_TENS_END
    addi    $16,$16,3
MAX_TENS_END:
    # for $17
    sub     $11,$28,$17
    slti    $6,$11,0
    beq     $6,$0,MAX_HUNDS_END
    addi    $17,$17,3
MAX_HUNDS_END:
    sub     $11,$28,$18
    slti    $6,$11,0
    beq     $6,$0,MAX_THOUDS_END
    addi    $18,$18,3
MAX_THOUDS_END:
    
    # for debug
    # addi    $31,$0,1234

    sll     $13,$13,1
    addi    $3,$3,1
    beq     $0,$0,LOOP_FOR_MAX_BEGIN


LOOP_FOR_MAX_END:#���ֵbin2bcdѭ��������
    
  




# �õ�0x80000000
    addi	$26, $0, 1			# $26 = $t1 + 0
    sll     $26,$26,31     
    addi    $27,$0,31             # FOR_BEQ
    addi    $28,$0,4
# �õ����ֵ�ľ���ֵ��ԭ��
    slti    $6,$2,0
    beq     $6,$0,POSITIVE_MIN
    sub     $13,$0,$2
    beq     $0,$0,POSITIVE_MIN_PLUS
POSITIVE_MIN:#���ֵ������
    addi	$13, $2, 0			# $13 = max + 0
POSITIVE_MIN_PLUS:
# ��ʼ�������ֵ��ʮ����λ
    addi	$19, $0, 0			# $15 = 0 + 0
    addi    $20,$0,0
    addi    $21,$0,0
    addi    $22,$0,0
    addi    $3,$0,0
LOOP_FOR_MIN_BEGIN:#���ֵbin2bcdѭ������ʼ
    sub     $12,$3,32
    slti    $6,$12,0
    beq     $6,$0,LOOP_FOR_MIN_END#ѭ�������ﵽ32�����ѭ��

    # for $18
    sll     $22,$22,29
    srl     $22,$22,28
    srl     $11,$21,3
    add     $22,$22,$11
    # for $17
    sll     $21,$21,29
    srl     $21,$21,28
    srl     $11,$20,3
    add     $21,$21,$11
    # for $16
    sll     $20,$20,29
    srl     $20,$20,28
    srl     $11,$19,3
    add     $20,$20,$11
    # for $15
    sll     $19,$19,29
    srl     $19,$19,28
    and     $11,$13,$26
    srl     $11,$11,31
    add     $19,$19,$11
    # for break:i==31
    beq     $3,$27,LOOP_FOR_MIN_END
    # for add 3
    # for $15
    sub     $11,$28,$19
    slti    $6,$11,0
    beq     $6,$0,MIN_ONES_END
    addi    $19,$19,3
MIN_ONES_END:
    # for $16
    sub     $11,$28,$20
    slti    $6,$11,0
    beq     $6,$0,MIN_TENS_END
    addi    $20,$20,3
MIN_TENS_END:
    # for $17
    sub     $11,$28,$21
    slti    $6,$11,0
    beq     $6,$0,MIN_HUNDS_END
    addi    $21,$21,3
MIN_HUNDS_END:
    sub     $11,$28,$22
    slti    $6,$11,0
    beq     $6,$0,MIN_THOUDS_END
    addi    $22,$22,3
MIN_THOUDS_END:
    
    # for debug
    # addi    $31,$0,1234

    sll     $13,$13,1
    addi    $3,$3,1
    beq     $0,$0,LOOP_FOR_MIN_BEGIN


LOOP_FOR_MIN_END:#���ֵbin2bcdѭ��������
    
  








# addi $1,    $0,0
# addi $1,    $0,0

# for debug
# addi $1,    $0,-1
# addi $2,    $0,-1
# addi $15,    $0, 1      
# addi $16,    $0, 2      
# addi $17,    $0, 3      
# addi $18,    $0, 4      
# addi $19,    $0, 5      
# addi $20,    $0, 6      
# addi $21,    $0, 7      
# addi $22,    $0, 8     

# parameter MAX_ONES=0x00fd;
# parameter MAX_TENS=0x00fc;
# parameter MAX_HUNDS=0x00fb;
# parameter MAX_THOUDS=0x00fa;
# parameter MIN_ONES=0x00f9;
# parameter MIN_TENS=0x00f8;
# parameter MIN_HUNDS=0x00f7;
# parameter MIN_THOUDS=0x00f6;
# sw   $15,  	0x00fd($0) 
# sw   $16,  	0x00fc($0) 
# sw   $17,  	0x00fb($0) 
# sw   $18,  	0x00fa($0) 
# sw   $19,  	0x00f9($0) 
# sw   $20,  	0x00f8($0) 
# sw   $21,  	0x00f7($0) 
# sw   $22,  	0x00f6($0) 








# $0   - 0000 $0 ��ų���0
# $max    - 0001 $1 ���max��
# $min    - 0010 $2 ���min��
# $i      - 0011 $3 ���i,
# $int    - 0100 $4 ���integers�׵�ַ��                              
# $num    - 0101 $5 ���num,
# $flag   - 0110 $6 ��űȽϽ��flag, 
# $data   - 0111 $7 �����ʱ���Դ洢��������data��
# $ad_max - 1000 $8 ������ֵ���ڴ��еĵ�ַad_max��0x1000
# $ad_min - 1001 $9 �����Сֵ���ڴ��еĵ�ַad_min, 0x1004
# $one    - 1010 $10 ���1
# $temp   - 1011 $11 �ݴ浱ǰ������dm�еĵ�ַ
# $diff   - 1100 $12 ��űȽϵ�ֵ֮��

# //���벿��
# true_max            $13         //���ֵ�ľ���ֵ��ԭ��
# true_min            $14         //���ֵ�ľ���ֵ��ԭ��
# max_ones            $15         //���ֵ�ĸ�λ
# max_tens            $16         //���ֵ��ʮλ
# max_hunds           $17         //���ֵ�İ�λ
# max_thouds          $18         //���ֵ��ǧλ
# min_ones            $19         //��Сֵ�ĸ�λ
# min_tens            $20         //��Сֵ��ʮλ
# min_hunds           $21         //��Сֵ�İ�λ
# min_thouds          $22         //��Сֵ��ǧλ
# disp_data           $23         //����ܵ�ǰɨ��Ҫ��ʾ������
# SCAN_TIMES          $24         //����ܵ�ǰɨ��Ĵ���������50000000����0�������λ����Ƭѡ
# TEMP                $25         //��ʱ�Ĵ�������SCAN_TIMES�������λ(��Чλ)
# FOR_AND             $26         //for:true_max&0x80000000
# FOR_BREAK           $27         //for:if i==31 then break
# FOR_FOUR            $28         //for:����4

# �������֮�����ϼĴ���ȫ������
# $max    - 0001 $1 ���max��
# $min    - 0010 $2 ���min��
# FOR_MAX             $10
# FOR_MIN             $11
# FOR_BUTTON_UP       $29
# FOR_BUTTON_DOWN     $30
# max_ones            $15         //���ֵ�ĸ�λ
# max_tens            $16         //���ֵ��ʮλ
# max_hunds           $17         //���ֵ�İ�λ
# max_thouds          $18         //���ֵ��ǧλ
# min_ones            $19         //��Сֵ�ĸ�λ
# min_tens            $20         //��Сֵ��ʮλ
# min_hunds           $21         //��Сֵ�İ�λ
# min_thouds          $22         //��Сֵ��ǧλ

# min_ones            $19         //��Сֵ�ĸ�λ
# min_tens            $20         //��Сֵ��ʮλ
# min_hunds           $21         //��Сֵ�İ�λ
# min_thouds          $22         //��Сֵ��ǧλ
# max_ones            $23        //���ֵ�ĸ�λ
# max_tens            $24         //���ֵ��ʮλ
# max_hunds           $25         //���ֵ�İ�λ
# max_thouds          $26         //���ֵ��ǧλ
# FOR_BUTTON_UP       $27
# FOR_BUTTON_DOWN     $28
# TEMP                $29
# FLAG                $30
# CONST_ONE           $31
# CONST_SCAN_LIMIT    $6

addi $23,$15,0
addi $24,$16,0
addi $25,$17,0
addi $26,$18,0
# addi $6,$0,600

addi    $31,$0,1
# TO_UPDATE_BUTTON:
# # ÿ��ɨ�趼Ҫ�����������
lw		$27, 0x1008($0)		# 
lw		$28, 0x1010($0)		# 

beq     $27,$31,_TO_SHOW_MAX
beq     $28,$31,_TO_SHOW_MIN
beq     $0,$0,_TO_SHOW
_TO_SHOW_MAX:
addi    $t1,$23,0
addi    $t2,$24,0
addi    $t3,$25,0
addi    $t4,$26,0
slti    $29,$1,0#������
beq     $29,$31,_CHANGE_SIGN_FOR_MAX
beq     $0,$0,_TO_SHOW
_CHANGE_SIGN_FOR_MAX:
addi    $t1,$0,10
beq     $0,$0,_TO_SHOW#10���ᱻshow0-show9��������ǿ�Ƶ���show_neg

_TO_SHOW_MIN:
addi    $t1,$19,0
addi    $t2,$20,0
addi    $t3,$21,0
addi    $t4,$22,0
slti    $29,$2,0#������
beq     $29,$31,_CHANGE_SIGN_FOR_MIN
beq     $0,$0,_TO_SHOW
_CHANGE_SIGN_FOR_MIN:
addi    $t1,$0,10#10���ᱻshow0-show9��������ǿ�Ƶ���show_neg

_TO_SHOW:

# �����õ��ļĴ����У�
# $s0  ��ʱ��;       $16     
# $s1��Ҫ��ʾ�����ݣ� $17
# $s2��Ƭѡ�ź�,     $18
# $t1   ��λ
# $t2   ʮλ
# $t3   ��λ
# $t4   ǧλ
A1:		addi $s2,$0,14		
     	add $s1,$t1,$0   
		beq $0,$0 B
A2:		addi $s2,$0,13
		add $s1,$t2,$0
		beq $0,$0 B
A3:		addi $s2,$0,11
		add $s1,$t3,$0
		beq $0,$0 B
A4:		addi $s2,$0,7
		add $s1,$t4,$0

B:      
        add $t0,$0,$0
		beq $s1,$t0,show0
		addi $t0,$t0,1
		beq $s1,$t0,show1
		addi $t0,$t0,1
		beq $s1,$t0,show2
		addi $t0,$t0,1
		beq $s1,$t0,show3
		addi $t0,$t0,1
		beq $s1,$t0,show4
		addi $t0,$t0,1
		beq $s1,$t0,show5
		addi $t0,$t0,1
		beq $s1,$t0,show6
		addi $t0,$t0,1
		beq $s1,$t0,show7
		addi $t0,$t0,1
		beq $s1,$t0,show8
		addi $t0,$t0,1
		beq $s1,$t0,show9 
        beq $0,$0,show_neg#ǿ����ʾ����
show_neg:
    	addi $s1,$0,0xfd#����   
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show0:	addi $s1,$0,0x3   
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show1:	addi $s1,$0, 0x9f   
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show2:	addi $s1,$0, 0x25
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show3:	addi $s1,$0, 0xd 
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show4:	addi $s1,$0, 0x99  
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show5:	addi $s1,$0, 0x49  
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show6:	addi $s1,$0, 0x41  
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show7:	addi $s1,$0, 0x1f  
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show8:	addi $s1,$0, 0x1  
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
		beq $0,$0 C
show9:	addi $s1,$0, 0x9   
		sw $s2,0x00000c00($0)
		sw $s1,0x00000400($0)
C:		
        beq $0,$0,TO_UPDATE_BUTTON
# CONST_SCAN_LIMIT: $6
# SCAN_TIME       : $5
# TEMP            : $29
# FLAG            : $30
TO_START_C:
#         addi $5,$0,0
# SCAN_SLEEP_BEGIN:
#         sub  $29,$5,$6
#         slt  $30,$29,$0
#         beq  $30,$0,SCAN_SLEEP_END
#         addi $5,$5,1
#         beq  $0,$0,SCAN_SLEEP_BEGIN
# SCAN_SLEEP_END:

        addi $s0,$0,7
		beq $s2,$s0,A1
		addi $s0,$0,11
		beq $s2,$s0,A4
		addi $s0,$0,13
		beq $s2,$s0,A3
		addi $s0,$0,14
		beq $s2,$s0,A2



# ÿ��ɨ�趼Ҫ�����������,����ת��ȥC
TO_UPDATE_BUTTON:
lw		$27, 0x1008($0)		# 
lw		$28, 0x1010($0)		# 

beq     $27,$31,TO_SHOW_MAX
beq     $28,$31,TO_SHOW_MIN
beq     $0,$0,TO_SHOW
TO_SHOW_MAX:
addi    $t1,$23,0
addi    $t2,$24,0
addi    $t3,$25,0
addi    $t4,$26,0
slti    $29,$1,0#������
beq     $29,$31,CHANGE_SIGN_FOR_MAX
beq     $0,$0,TO_SHOW
CHANGE_SIGN_FOR_MAX:
addi    $t4,$0,10
beq     $0,$0,TO_SHOW#10���ᱻshow0-show9��������ǿ�Ƶ���show_neg

TO_SHOW_MIN:
addi    $t1,$19,0
addi    $t2,$20,0
addi    $t3,$21,0
addi    $t4,$22,0
slti    $29,$2,0#������
beq     $29,$31,CHANGE_SIGN_FOR_MIN
beq     $0,$0,TO_SHOW
CHANGE_SIGN_FOR_MIN:
addi    $t4,$0,10#10���ᱻshow0-show9��������ǿ�Ƶ���show_neg
TO_SHOW:
beq     $0,$0,TO_START_C