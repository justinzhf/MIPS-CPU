lw $t1,4($t0) #$t1=1
add $t3,$t1,$t2 #$t3=1,lw hazard,在ex级阻塞一个周期，开始执行ex级时应该是t=60，在t=80时获得来自上一条指令的memwb级的转发，转发到rs
add $t4,$t1,$t2 #$t4=1,lw hazard,不阻塞，开始执行ex级时应该是t=80，在t=80时获得来自上一条指令的memwb级的转发，转发到rs
add $t8,$t1,$t2 #$t8=1,无冒险

lw $t2,8($t0) #$t2=2
add $t5,$t0,$t2  #$t5=2,lw hazard,在ex级阻塞两个周期，开始执行ex级时应该是t=160，在t=180时获得来自上一条指令的memwb级的转发，转发到rt
add $t6,$t0,$t2  #$t6=2,lw hazard,不阻塞，开始执行ex级时应该是t=180，在t=180时获得来自上一条指令的memwb级的转发，转发到rt
add $t7,$t1,$t2 #$t7=3,无冒险

