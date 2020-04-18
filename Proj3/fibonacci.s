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