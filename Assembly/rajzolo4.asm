Code Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, AX

    mov dx, 100     ;X koordináta 
    mov bx, 100     ;Y koordináta
    push dx

    mov ax, 13h
    int 10h

    mov ax, 0a000h  ;Videó Kezdőcím
    mov es, ax      ;Extra Segmens

    mov al, 34      ;global valtozo a pixel szin valtoztatashoz

    mov cx, 480
Rajz:
    
    mov es:[di], al ;videó

    add di, 1

    loop Rajz

    xor ah, ah      ;bevitel
    int 16h
    
Program_Vege:
    mov ax, 03h
    int 10h         ;üzemmód
    pop dx
    mov ax, 4c00h
    int 21h
    
Code    Ends
Data    Segment
Data    Ends
Stack   Segment
Stack   Ends
        End Start

        