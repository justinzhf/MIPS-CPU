#对内存中前0--9共10个元素进行选择排序，使其非升序排列
.data
array:.word 0,1,2,3,4,5,6,7,8,9,40
.text
main:
lw $s0,0($t0) #将$s0赋值为0
add $s1,$s0,$s0 #将$s1赋值为0，始终指向大元素
lw $s2,4($t0) #将$s2赋值为1
lw $s3,40($t0) #将$s3赋值为40，为待排序元素的数量
lw $s4,16($t0) #将$s4赋值为4
add $s5,$s0,$s0 #$s5=0，始终指向数组首

L3:add $s1,$zero,$s5
add $s0,$zero,$s5
L1:lw $t1,0($s1)
lw $t2,0($s0)  
slt $t0,$t1,$t2
beq $t0,$s2,L2 #若跳转，则说明$t1<$t2
add $s0,$s0,$s4 #$s0自增4，为指针
j L4
L2:add $s1,$zero,$s0 #$t1<$t2，即$s1所指的为小元素，则更新$s1,使其指向大元素
add $s0,$s0,$s4 #$s0自增4，为指针

L4:slt $t0,$s0,$s3
beq $t0,$s2,L1 #$s0<$s3，继续循环

#将大元素交换数组首
lw $t6,0($s5)
lw $t7,0($s1)
sw $t7,0($s5)
sw $t6,0($s1)

add $s5,$s5,$s4 #数组首移动一位

slt $t0,$s5,$s3
beq $t0,$s2,L3

lw $t0,0($zero)
lw $t1,4($zero)
lw $t2,8($zero)
lw $t3,12($zero)
lw $t4,16($zero)
lw $t5,20($zero)
lw $t6,24($zero)
lw $t7,28($zero)
lw $t8,32($zero)
lw $t9,36($zero)







