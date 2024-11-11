main:
    li a0, 2
    li a1, 1
    bge a0, a1, equal
    li a0, 0
equal:
    unimp  # a0 should be 2
