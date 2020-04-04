	.equ HEX_DISPS, 0xFF200020
	.equ HEX_DISPS_2, 0xFF200030
	.equ PUSHBUTTONS, 0xFF200050
.global _start
_start:
	movia   r16, HEX_DISPS 		# Address of HEX3...HEX0 Displays
	movia	r22, HEX_DISPS_2
	movia   r17, PUSHBUTTONS # Address of pushbuttons
	movia	r18, RIGHT_PTRN
	movia	r19, LEFT_PTRN
	movia	r2, STATE
	movia	r1, Cf1
	movia	r5, Cf2
	ldw		r2, 0(r2)
	ldw		r1, 0(r1)
	ldw		r5, 0(r5)
	movi 	r20, 8
	movi	r21, 8
	stwio	r0, 0(r16)
	
CHK:
	ldwio	r12, 0(r17)	#input from pushbuttons
	bne     r12, r0, STATE_MACHINE
	beq		r2, r1, NO_BUTTON
	beq		r2, r5, BUTTON
	br		CHK
	
STATE_MACHINE:
	roli	r2, r2, 16
	beq		r2, r1, NO_BUTTON
	beq		r2, r5, BUTTON
	br		STATE_MACHINE
	
NO_BUTTON:
	blt		r4, r20, NO_BUTTON_SCRL
	br		RESET
	
NO_BUTTON_SCRL:
		mov		r10, r23
		slli	r10, r10, 8
		mov		r23, r9
		srli	r23, r23, 24
		or		r23, r23, r10
		stwio	r23, 0(r22)
	
	slli	r9, r9, 8
	ldw 	r7, 0(r18)
	or  	r9, r9, r7
	stwio	r9, 0(r16)
	addi	r18, r18, 4
	addi	r4, r4, 1
	br		DEL_P1
	
BUTTON:
	blt		r4, r21, BUTTON_SCRL
	br		RESET
	
BUTTON_SCRL:
		mov		r11, r3
		srli	r11, r11, 8
		mov		r3, r13
		slli	r3, r3, 24
		or		r3, r3, r11
		stwio	r3, 0(r16)
		
	srli	r13, r13, 8
	ldw 	r14, 0(r19)
	or  	r13, r13, r14
	stwio	r13, 0(r22)
	addi	r19,r19, 4
	addi	r4, r4, 1
	br		DEL_P1
	
RESET:
	movi	r4, 0x0
	movia	r18, RIGHT_PTRN
	movia	r19, LEFT_PTRN
	br  	DEL_P1

DEL_P1:	          
	ori 	r8, r0, 0x4B4C
	srli	r8, r8, 12
	orhi	r8, r8, 0x004C
	br  	DEL_P2
	
DEL_P2:
	subi	r8, r8, 1
	bgt 	r8, r0, DEL_P2
	br 		CHK
.data
	RIGHT_PTRN:
		.word 0x79, 0x49, 0x49, 0x49, 0x00, 0x00, 0x00, 0x00
	LEFT_PTRN:
		.word 0x4F000000, 0x49000000, 0x49000000, 0x49000000, 0x00, 0x00, 0x00, 0x00
	STATE:
		.word 0xFFFF0000
	Cf1:
		.word 0xFFFF0000
	Cf2:
		.word 0x0000FFFF
	.end
