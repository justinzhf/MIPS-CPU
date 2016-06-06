L:
lw $t1,4($t0) #$t1=1
lw $t2,8($t0) #$t2=2
add $t0,$t0,$t4
j L #清除掉一条指令
add $t0,$t0,$t3