main:
    li sp, 128
    addi sp, sp, -8
    li a0, 0
    li t0, 99
    sd t0, 0(sp)
    ld a0, 0(sp)
    unimp  # a0 should be 99

