CODE SEGMENT
    
	ASSUME CS:CODE

    START:	
        MOV BL, '5'
    	MOV AL, '9'
    	AND BL, 0FH
    	AND AL, 0FH
    	MOV CL, 04H
    	ROL BL, CL
    	OR  AL, BL
	
CODE ENDS
    
    END START
