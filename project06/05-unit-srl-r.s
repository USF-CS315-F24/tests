main:
    li a1, 8
    li a2, 1
    srl a0, a1, a2
    unimp  # a0 should be 4
