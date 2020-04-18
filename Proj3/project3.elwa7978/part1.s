.text

.global sum_two
sum_two:
	subi	sp, sp, 8          # stack frame 8 bytes
    stw		ra, 4(sp)          # save return address
   
	add		r2, r4, r5         #adds two inputs, stores in output

    xor		r8, r2, r4         #checking if overflow occured
    xor 	r9, r2, r5
    and 	r8, r9, r9
    blt 	r8, r0, overflow
   
    ldw     ra, 4(sp)          # restore return address
    addi    sp, sp, 8          # remove frame
   
    ret
	
overflow:
	br overflow

.global op_three
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

.global fibonacci
fibonacci:
	subi	sp, sp, 8	# stack frame 8 bytes
	stw		ra, 4(sp)	# store return address
	stw		r4, 0(sp)	# store index value
	
	movi	r2, 1
	bgt		r4, r2, fib_recurse		# if n > 2, f_n = f_n-1+f_n+2
	mov		r2, r4					# else return 1
	br		fib_finish
	
fib_recurse:
	subi	r4, r4, 1				# call fibonacci for f_n-1
	call	fibonacci
	
	ldw		r4, 0(sp)				# load f_n value
	subi	r4, r4, 2				# call fibonacci for f_n-2
	stw		r2, 0(sp)				# store return value on stack
	call	fibonacci
	
	ldw		r4, 0(sp)				# store f_n value
	add		r2, r2, r4				# f_n = f_n-1 + f_n-2
	
fib_finish:
	ldw		ra, 4(sp)	# restore return address
	addi	sp, sp, 8   # remove frame


	ret

.end