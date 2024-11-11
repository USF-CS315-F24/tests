main:
    li sp, 1024
    addi sp, sp, -8
    li t0, 'F'
    sb t0, 0(sp)
    li t0, 'o'
    sb t0, 1(sp)
    li t0, 'o'
    sb t0, 2(sp)
    li t0, 'B'
    sb t0, 3(sp)
    li t0, 'a'
    sb t0, 4(sp)
    li t0, 'r'
    sb t0, 5(sp)
    sb zero, 6(sp)
    sb zero, 7(sp)


    add a1, zero, sp    # set up a0 src string
    addi sp, sp, -8
    add a0, zero, sp    # set up a1 dest string
    add s1, zero, sp    # save dest in s1

    jal rstr_s

    li s2, 0            # packed value
    li t0, 0            # loop index
    li t1, 8            # n iterations
    li t2, 56           # shift amount
pack:
    beq t0, t1, done_pack
    lb t3, 0(s1)        # load uppered byte
    sll t3, t3, t2      # shift byte into position
    or s2, s2, t3       # update packed value
    addi s1, s1, 1      # next char
    addi t0, t0, 1      # next loop index
    addi t2, t2, -8     # next shift amount
    j pack
done_pack:
    add a0, zero, s2    # set up return value
    unimp

strlen:
    li t0, 0
strlen_loop:
    lb t1, (a0)
    beq t1, zero, strlen_loop_end
    addi t0, t0, 1
    addi a0, a0, 1
    j strlen_loop
strlen_loop_end:
    mv a0, t0
    ret

# Reverse a string iteratively
#
# a0 - char *dst
# a1 - char *src

# t0 - int src_len
# t1 - int i
# t2 - int j

rstr_s:
    addi sp, sp, -32
    sd ra, (sp)
    sd a0, 8(sp)            # save a0 (*dst)
    sd a1, 16(sp)           # save a1 (*src)

    mv a0, a1               # a0 = (*src)
    jal strlen

    mv t0, a0               # t0 (src_len) = a0
    ld a0, 8(sp)            # restore a0 (*dst)
    ld a1, 16(sp)           # restore a1 (*src)

    li t1, 0                # t1 (i) = 0
    mv t2, t0               # t2 (j) = t0 (src_len)
    addi t2, t2, -1         # t2 (j) = t2 (j) - 1

rstr_loop:
    bge t1, t0, rstr_done   # i < src_len
    add t4, a1, t2          # t4 = a0 (*src) + t2 (j)
    lb t5, (t4)             # t5 = *t4
    add t4, a0, t1          # t4 = a0 (*dst) + t1 (i)
    sb t5, (t4)             # t5 = *t4
    
    addi t1, t1, 1          # t1 (i) = t1 (i) + 1
    addi t2, t2, -1         # t2 (j) = t2 (j) - 1
    j rstr_loop

rstr_done:
    li t5, 0
    add t4, a0, t0
    sb t5, (t4)

    ld ra, (sp)
    addi sp, sp, 32
    ret
