; value takes from stack and store result in same location in stack

DATA SEGMENT
    
	BCD_INPUT DB 17H
	BIN_VALUE DB ?
	
DATA ENDS 
       
       
             
STACK_SEG SEGMENT
    
	STACK DW 100 DUP(0)
	TOP_STACK LABEL WORD
	
STACK_SEG ENDS
       
       

CODE SEGMENT 
    
	ASSUME CS:CODE, DS:DATA, SS:STACK_SEG

	START:
		MOV AX, DATA
		MOV DS, AX
		MOV AX, STACK_SEG
		MOV SS, AX
		MOV SP, OFFSET TOP_STACK
	; initialization & registeration finish up

		MOV AL, BCD_INPUT
		
		PUSH AX
		CALL BCD_BIN
		POP AX
		
		MOV BIN_VALUE, AL   ; BIN_VALUE <- 11H
		NOP
		NOP

	BCD_BIN PROC NEAR
		PUSHF
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH BP
		
		MOV BP, SP      ; load top of stack in BP
		MOV AX, [BP+12]

	; conversion start from here
		MOV BL, AL
		
		AND BL, 0FH     ; (17) -> (07)
		AND AL, 0F0H    ; (17) -> (10)
	; bcd to binary conversion : bcd && hex = binary
	
		MOV CL, 04H
		ROR AL, CL      ; (10) -> (01)
		
		MOV BH, 0AH     ; takes a free section(BH) to store 10
		MUL BH          ; AL <- AL * BH <- (01 * 0A) = 0AH
		ADD AL, BL      ; AL <- AL + BL <- (0A + 07) = 11H
          
        MOV [BP+12], AL
        POP BP  
		POP CX
		POP BX      
		POP AX
		POPF
		RET
	BCD_BIN ENDP   
         
CODE ENDS
	END START
