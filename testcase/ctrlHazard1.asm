#lw；beq和lw;ins;beq的情况，转发到rs，且不发生分支

lw $t1,4($t0) #t1=1
beq $t1,$t0,L1 #不相等，不发生分支，且阻塞两个周期，t=80收到第一条指令从memwb级转发的结果，转发到rs，在t=80--t=100之间产生分支结果


lw $t2,8($t2) #$t2=2
add $t0,$t0,$t0 #无用指令
beq $t2,$t1,L1 #不相等，不发生分支，且阻塞一个周期，在t=160收到上上条指令从memwb级的转发结果，抓发到rs，在t=160到t-180之间产生分支结果

L1:
