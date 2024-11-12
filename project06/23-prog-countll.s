#struct node_st {
#    struct node_st *next_p;
#    int value;
#};

main:
    li sp, 1024
    addi sp, sp, -48    # alloc 3 structs (16 * 3)

    # n0
    li t0, 11
    sw t0, 8(sp)
    addi t0, sp, 16 # n1
    sd t0, 0(sp)

    # n1
    li t0, 22
    sw t0, 24(sp)
    addi t0, sp, 32 # n2
    sd t0, 16(sp)

    # n2
    li t0, 22
    sw t0, 40(sp)
    mv t0, zero # NULL
    sd t0, 32(sp)

    add a0, zero, sp    # set up arr arg
    jal countll_s
    unimp # a0 should be 3

# a0 - struct node_st *np
# t0 - int len

# struct node_st
# 0 : struct node_st *next_p
# 8 : value

countll_s:
    li t0, 0

countll_while:
    beq a0, zero, countll_done
    addi t0, t0, 1
    ld a0, (a0)                 # a0 = a0->next_p
    j countll_while    

countll_done:
    mv a0, t0
    ret
