
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here

;Farenheit to Celcius
;C = (F - 32) * 5 / 9

MOV AX, 0025H    ;Farenheit = 37 in decimal
                 ;Celcius = (37-32) * 5 / 9 = 2
                 ;Celcius = 2 in hexadecimal

PUSH AX

CALL CHANGE_TO_CELCIUS

POP AX

ret



CHANGE_TO_CELCIUS PROC NEAR
    
   
    PUSH BX
    PUSH BP
    MOV BP, SP
    MOV BX, [BP+6]
    
    MOV AX, BX
    SUB AX, 0020H
    

    MOV BX, 0005H
    
    MUL BX
    
    MOV BX, 0009H
    DIV BX
    
    MOV [BP+6], AX    

    POP BX
    POP BP 
    
    ret
    
CHANGE_TO_CELCIUS ENDP


 ends

