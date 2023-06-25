;Student Number : 2020555070
;Student Name and Surname :Hüseyin Can YILMAZ
;Github Username :hcy7575 (https://github.com/hcy7575?tab=repositories)


Student_number db '2020555070'   ;I declared a byte array and initialized with ASCII for my school student number

MOV DI, offset Student_number    ;This sets the starting point for accessing the array. 


MOV AX,0
MOV CX, 10  
CALL To_Memory
  
 
  
MOV CX, 10
MOV AX, 200h
MOV ES, AX        ;Set the segment of the destination memory
MOV DI, 2000h     ;the offset of the destination memory
CALL Copy_Memory

MOV AL, byte ptr [2006h]
CMP AL, '5'        ;loads the byte from memory location 2000h in to the AL register
JNE evening        ;if is not equal jumps to the evening label
JMP mornings       ;if is equal jumps to the morning label

mornings:
MOV AH, 0eh        ;INT 10h/0Eh (INT 10h / AH = 0Eh - teletype output.)
MOV AL,' '
INT 10h
MOV AL, 'M' 	     ;character to write
INT 10h		         ;BIOS interrupt
MOV AL, 'o'
INT 10h
MOV AL, 'r'
INT 10h
MOV AL, 'n'
INT 10h
MOV AL, 'i'
INT 10h
MOV AL, 'n'
INT 10h
MOV AL, 'g'
INT 10h
JMP exit
     
evening:
MOV AH, 0eh        ;INT 10h/0Eh (INT 10h / AH = 0Eh - teletype output.)
MOV AL,' '
INT 10h
MOV AL, 'E' 	     ;character to write
INT 10h       	   ;BIOS interrupt
MOV AL, 'v'
INT 10h
MOV AL, 'e'
INT 10h
MOV AL, 'n'
INT 10h
MOV AL, 'i'
INT 10h
MOV AL, 'n'
INT 10h
MOV AL, 'g'
INT 10h 
JMP exit

exit:
RET

To_Memory proc 
    
    MOV AL, [DI]           ;loads the byte from memory 
    MOV [2000h+BX],AL      ;copies the value from Student_number to the memory location
    
    MOV AH, 0eh            ;BIOS function number for displaying a character
    INT 10h                ;display the character in AL
    INC DI                 ;increment the register to point to the next by Student_number array
    INC BX                 ;increment the register to point to the next memory location 
    LOOP To_Memory         ;CX_value-1 jumps back to To_Memory if CX is not zero. Cont. until CX is zero
    RET
To_Memory ENDP

Copy_Memory PROC
    REP MOVSB               ;to copy a block of memory
    RET
Copy_Memory ENDP

end
