main:
    li a0, 1
    j skip
    li a0, 0
skip:
    unimp  # a0 should be 1
