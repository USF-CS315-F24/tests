main:
    li a0, 1    
    li a1, 2    
    jal first_s    
    unimp # a0 should be 3
first_s:
    add a0, a0, a1    
    ret
