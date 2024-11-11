#! riscv

#.global quadratic_s

/* quadratic_s calculates the quadratic equation where
    a0 = x
    a1 = a
    a2 = b
    a3 = c
*/

main:
    li a0, 2
    li a1, 3
    li a2, 4
    li a3, 5
    jal quadratic_s
    unimp

quadratic_s:
    mul t0, a0, a0  # t0 = x*2
    mul t0, t0, a1  # t0 = a * x^2
    mul t1, a0, a2  # t1 = b * x
    add a0, t0, t1  # a0 = (a * x^2) + (b * x)
    add a0, a0, a3  # a0 += c
    ret
