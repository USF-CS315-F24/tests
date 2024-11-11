main:
    li a0, 1
    li a1, 2
    blt a0, a1, equal
    li a0, 0
equal:
    unimp  # a0 should be 1
