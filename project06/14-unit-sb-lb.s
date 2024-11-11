main:
    li sp, 128
    addi sp, sp, -8
    li a0, 0
    li t0, 99
    sb t0, 3(sp)
    lb a0, 3(sp)
    unimp  # a0 should be 99
