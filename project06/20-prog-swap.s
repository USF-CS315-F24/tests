main:
    li sp, 1024
    addi sp, sp, -32    # alloc 8 32-bit words
    li t0, 2
    sw t0, 0(sp)
    li t0, 8
    sw t0, 4(sp)
    li t0, 6
    sw t0, 8(sp)
    li t0, 4
    sw t0, 12(sp)
    li t0, 10
    sw t0, 16(sp)
    li t0, 12
    sw t0, 20(sp)
    add a0, zero, sp    # set up arr arg
    add s1, zero, sp    # save array addr
    li a1, 1            # set up start index arg
    li a2, 5            # set up end index arg
    jal swap_s
    lw a0, 4(sp)
    unimp # a0 should be 12

/* swap two elements of an integer array
    a0 - int arr[]
    a1 - int i
    a2 - int j
*/

.align 4
swap_s:
    li t0, 4
    mul t1, a1, t0
    add t1, a0, t1
    mul t2, a2, t0
    add t2, a0, t2
    lw t3, (t1)   
    lw t4, (t2)
    sw t4, (t1)
    sw t3, (t2)
    ret
