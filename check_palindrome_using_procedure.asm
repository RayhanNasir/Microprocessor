
org 100h

call check_palindrome
   
ret

check_palindrome PROC NEAR
    
    MOV CX, string_length
    LEA SI, input_string
    LEA DI, reverse_string
    ADD DI, string_length;
    DEC DI
    
    LOOP_START:
        MOV AL, [SI]
        MOV [DI], AL
        INC SI
        DEC DI
    LOOP LOOP_START
    
    LEA SI, input_string
    LEA DI, reverse_string
    CLD
    
    MOV CX, string_length
    
    REPE CMPSB
    JNE NOT_FOUND
    
    MOV found, 'Y'
    JMP LAST
    
    NOT_FOUND:
    MOV found, 'N'
    
    LAST:
    ret

check_palindrome ENDP     

ret

input_string db '!MAGAM!'
string_length dw ($-input_string)

reverse_string db string_length DUP(0)

found db ?


