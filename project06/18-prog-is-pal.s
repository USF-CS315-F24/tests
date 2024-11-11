main:
    li sp, 1024
    addi sp, sp, -8
    li t0, 'r'
    sb t0, 0(sp)
    li t0, 'a'
    sb t0, 1(sp)
    li t0, 'c'
    sb t0, 2(sp)
    li t0, 'e'
    sb t0, 3(sp)
    li t0, 'c'
    sb t0, 4(sp)
    li t0, 'a'
    sb t0, 5(sp)
    li t0, 'r'
    sb t0, 6(sp)
    sb zero, 7(sp)
    add a0, zero, sp
    li a1, 0
    li a2, 6
    jal pal_rec_s
    unimp  # a0 should be 1

/* pal_rec_s recursively calculates whether a string is a palindrome
    a0 is the string
    a1 is the start index to test
    a2 is the end index to test
*/

pal_rec_s:
    blt a1, a2, check_eq    # done if end >= start
    li a0, 1                # is pal if we hit the base case
    j done

check_eq:
    add t0, a0, a1          # t0 = &arr[start]
    lb t0, (t0)             # t0 = arr[start]
    add t1, a0, a2          # t1 = &arr[end]
    lb t1, (t1)             # t1 = arr[end]
    beq t0, t1, rec_case    # if eq, is pal so far, recurse
    li a0, 0                # if not eq, not a pal
    j done

rec_case:
    addi sp, sp, -8         # alloc stack space
    sd ra, (sp)             # preserve return addr
    addi a1, a1, 1          # walk start idx forward
    addi a2, a2, -1         # walk end idx backward
    jal pal_rec_s
    ld ra, (sp)             # restore return addr
    addi sp, sp, 8          # dealloc stack space
done:
    ret
