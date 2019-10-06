; value takes from DATA segment in pointer


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
                      
        MOV SI, OFFSET BCD_INPUT    ; load address of BCD_INPUT
        MOV DI, OFFSET BIN_VALUE    ; load address of BIN_VALUE
		CALL BCD_BIN
		NOP
		NOP
	    

	BCD_BIN PROC NEAR
		PUSHF
		PUSH AX
		PUSH BX
		PUSH CX
                 
        MOV AL, [SI]        
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
        
        MOV [DI], AL    ; [DI] <- 11H
                        ;MOV BIN_VALUE, AL                ; BIN_VALUE <- AL
		POP CX
		POP BX
		POP AX
		POPF
		RET
	BCD_BIN ENDP   
         
CODE ENDS
	END START
