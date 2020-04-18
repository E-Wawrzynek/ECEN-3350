.global _start
_start:
	movia	sp, 0x04000000
	movi	r4, 6
	movi	r5, 3
	movi	r6, 1
	call op_three

done:
	br done
	
sum_two:
	subi	sp, sp, 8          # stack frame 8 bytes
    stw		ra, 4(sp)          # save return address
   
	add		r2, r4, r5

    xor		r8, r2, r4
    xor 	r9, r2, r5
    and 	r8, r9, r9
    blt 	r8, r0, overflow
   
    ldw		ra, 4(sp)          # restore return address
    addi	sp, sp, 8          # remove frame
   
    ret
	
overflow:
	br overflow
	
op_two:
	# Function will be provided, borrowing sum_two functionality
	add		r2, r4, r5

    xor		r8, r2, r4
    xor 	r9, r2, r5
    and 	r8, r9, r9
    blt 	r8, r0, overflow
	
	ret

op_three:
	subi	sp, sp, 8          # stack frame 8 bytes
    stw		ra, 4(sp)          # save return address
	
	call	op_two			   # call op_two, which should take r4, r5
	mov		r4, r2			   # move output of op_two into r4
	mov		r5, r6			   # move r6 into r5
	call	op_two			   # inputs are r4, and r5, which hold values from r2 and r6
   
    ldw		ra, 4(sp)          # restore return address
    addi	sp, sp, 8          # remove frame
   
    ret