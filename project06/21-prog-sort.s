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
    li a1, 4            # set up len
    jal sort_s

    lw a0, 0(s1)        # pack the first two words into a0
    sll a0, a0, 32
    lw t0, 4(s1)
    or a0, a0, t0

    lw a1, 8(s1)        # pack the second two words into a1
    sll a1, a1, 32
    lw t0, 12(s1)
    or a1, a1, t0

    lw a2, 16(s1)       # pack the third two words into a2
    sll a2, a2, 32
    lw t0, 20(s1)
    or a2, a2, t0

    unimp

/* sort_s sorts an array of 32-bit integers in-place,
   in asceding order

   a0 - int arr[]
   a1 - int len

   t0 - int i;
   t1 - int j;

*/

sort_s:                     # prologue
    addi sp, sp, -40        # allocate stack space
    sd ra, (sp)             # save return addr
    li t0, 1

floop:
    bge t0, a1, fdone       # reached arr len?
    mv t1, t0               # j = i

wloop:
    ble t1, zero, wdone     # t1 (j) <= 0 ?
    li t3, 4                # t3 = 4;
    mul t4, t1, t3          # t4 = i * 4
    add t5, a0, t4          # t5 = a0 + t4
    addi t6, t5, -4         # t6 = arr[j-1]
    lw t5, (t5)             # t5 = arr[j]
    lw t6, (t6)             # t6 = arr[j-1]
    ble t6, t5, wdone       # arr[j-1] <= arr[j] ?

    sd a0, 8(sp)            # Preserve caller saved regs
    sd a1, 16(sp)
    sd t0, 24(sp)
    sd t1, 32(sp)

    mv a1, t1               # a1 = t1 (j)
    addi a2, t1, -1         # a2 = t1 (j) - 1
    jal swap_s

    ld a0, 8(sp)            # Restore caller saved regs
    ld a1, 16(sp)
    ld t0, 24(sp)
    ld t1, 32(sp)

    addi t1, t1, -1         # t1 (j) = t1 (j) - 1
    j wloop

wdone:
    addi t0, t0, 1
    j floop

fdone:                      # epilogue
    ld ra, (sp)             # restore return addr
    add sp, sp, 40          # deallocate
    ret

/* swap two elements of an integer array
    a0 - int arr[]
    a1 - int i
    a2 - int j
*/

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
