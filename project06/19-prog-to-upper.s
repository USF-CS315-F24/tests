.global main

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
    add a0, zero, sp    # set up a0 src string
    addi sp, sp, -8
    add a1, zero, sp    # set up a1 dest string
    add s1, zero, sp    # save dest in s1
    jal to_upper_s

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
/*
    Convert character string to upper case
    a0 points to the original string
    a1 points to the destination
*/

to_upper_s:
    li t1, 'a'                  # li is pseudo for addi rd, zero, imm
    li t2, '{'

loop:
    lb t0, (a0)                 # t0 = *a0
    beq t0, zero, done          # t0 == '\0', stop loop
    blt t0, t1, next            # < 'a', don't change
    bge t0, t2, next            # > 'z', don't change

    addi t0, t0, -0x20          # t0 -= 32 (uppercase)

next:
    sb t0, (a1)                 # *dest = t0
    addi a0, a0, 1              # orig++
    addi a1, a1, 1              # dest++
    j loop                      # go again

done:
    sb zero, (a1)               # *dest = '\0'
    ret
