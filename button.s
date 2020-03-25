.text
	.equ HEX, 0xFF200020
	.equ PUSHBUTTONS, 0xFF200050
	.global _start
_start: 
	movia   r16, HEX 		# Address of HEX Displays
	movia   r17, PUSHBUTTONS # Address of pushbuttons
	movia	r18, HEX_bits_1
	movia	r19, HEX_bits_2
	ldwio	r4, 0(r18)		#load pattern for HEX Displays

CHECK:
	ldwio	r5, 0(r17)	#input from pushbuttons
	beq     r5, r0, NO_BUTTON

BUTTON_SETUP:
	ldwio	r5, 0(r17)
	ldwio	r4, 0(r19)

BUTTON:
	beq		r4, r0, RESET2
	stwio	r4, 0(r16)
	srli	r4, r4, 8
	movia	r7, 500000

DELAY2:
	subi	r7, r7, 1
	bne		r7, r0, DELAY
	br		CHECK

NO_BUTTON:
	beq		r4, r0, RESET1
	stwio	r4, 0(r16)	#store HEX3...HEX0
	slli	r4, r4, 8
	movia	r7, 500000	#delay counter

DELAY:
	subi	r7, r7, 1
	bne	    r7, r0, DELAY
	br		CHECK
	
RESET1:
	ldwio	r4, 0(r18)
	br		NO_BUTTON

RESET2:
	ldwio	r4, 0(r19)
	br		BUTTON
.data
	HEX_bits_1:
		.word 0x0000000F
	HEX_bits_2:
		.word 0x0000000D

	.end