	.equ	HEX_DISPS, 0xFF200020
	.equ	HEX_DISPS_2, 0xFF200030
#.global _start
#_start:
	#have to blank the extra hex displays, only used in part 2
	movia	r22, HEX_DISPS_2
	stwio	r0, 0(r22)	

	movia	r16, HEX_DISPS
	movia	r17, SCRL_MSG
	movi 	r18, 0x0
	movia	r19, PTRN
	movi 	r10, 18
	movi	r11, 30
	stwio	r0, 0(r16)

DEL_P1:	          
	ori 	r8, r0, 0x4B4C
	slli	r8, r8, 9
	orhi	r8, r8, 0x004C
	br  	DEL_P2

DEL_P2:
	subi	r8, r8, 1
	bgt 	r8, r0, DEL_P2
	br 		COMPTROLLER
	
COMPTROLLER:
	blt 	r18, r10, SCRL
	blt 	r18, r11, DISP_PTRN
	br  	RESET

DISP_PTRN:
	ldw 	r9, 0(r19)
	stwio 	r9, 0(r16)
	addi	r19, r19, 4
	addi	r18, r18, 1
	br  	DEL_P1

SCRL:
	slli	r6, r6, 8
	ldw 	r7, 0(r17)
	or  	r6, r6, r7
	stwio	r6, 0(r16)
	addi	r17, r17, 4
	addi	r18, r18, 1
	br  	DEL_P1

RESET:
	movi	r18, 0x0
	movia	r17, SCRL_MSG
	movia	r19, PTRN
	br  	DEL_P1

.data
PTRN:
	# A, B, A, B, A, B, C, blank, C, blank, C, blank
	.word	0x49494949, 0x36363636, 0x49494949, 0x36363636, 0x49494949, 0x36363636, 0x7F7F7F7F, 0x00000000, 0x7F7F7F7F, 0x00000000, 0x7F7F7F7F, 0x00000000 
SCRL_MSG:
	# "Hello Buffs---____" 
	.word	0x76, 0x79, 0x38, 0x38, 0x3F, 0x00, 0x7C, 0x3E, 0x71, 0x71, 0x6D, 0x40, 0x40, 0x40, 0x00, 0x00, 0x00, 0x00
