/* .global fib_rec_s */

/*
int fib_rec_c(int n) {
    if (n <= 1) {
        return n;
    }
    return fib_rec_c(n - 1) + fib_rec_c(n - 2);
}
*/

main:
    li sp, 1024
    li a0, 10
    jal fib_rec_s
    unimp

fib_rec_s:
    li t0, 1
    blt t0, a0, rec_case
    ret

rec_case:
    addi sp, sp, -24    # prologue
    sd ra, (sp)

    sd a0, 8(sp)        # preserve n
    addi a0, a0, -1     # set up n-1 arg
    jal fib_rec_s
    sd a0, 16(sp)       # preserve retval
    ld a0, 8(sp)        # restore n
    addi a0, a0, -2     # set up n-2 arg
    jal fib_rec_s
    ld t1, 16(sp)       # restore retval of first recursion
    add a0, a0, t1      # add the retvals of each recursion
    
    ld ra, (sp)         # epilogue
    addi sp, sp, 24
    ret
