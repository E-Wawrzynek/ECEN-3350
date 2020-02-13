	.text
	.equ LEDs, 0xFF200000
	.equ SWITCHES, 0xFF200040
	.global _start
_start: 
	movia   r2, LEDs #Address of LEDs
	movia   r3, SWITCHES    #Address of switches
LOOP:
	ldwio   r4, (r3) #Read the state of switches#
	srli	r5, r4, 5 #Shift the switches 5 bits right
	andi	r6, r4, 31 #And the right five bits with 1s and left with 0s
	add 	r7, r5, r6 #Add the two numbers
	stwio   r7, (r2)# Display the state on LEDs
	br LOOP
	.end
