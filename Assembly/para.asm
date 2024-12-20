Code Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov di, 82h
    mov cx, 10
    
Keres: mov dl, [di]
    cmp dl, "/"
    jz ParamKezdet
    inc di
    loop Keres
    jmp Default
    
ParamKezdet:
    inc di
    mov bl, [di]
    sub bl, 48
    inc di

    mov bh, [di]
    sub bh, 48

    mov ax, 10
    mul bl

    add al, bh
    mov cx, ax

    jmp Init

Default:
    mov cx, 10
    
Init:
    mov ax, Code
    mov ds, ax

    xor di, di
    xor si, si

    xor dx, dx
    push dx
    
Torles:
    mov ax, 03h
    int 10h
    
Rajz:
    mov bx, di
    mov dh, bl
    mov bx, si
    mov dl, bl
    xor bh, bh
    mov ah, 02h
    int 10h

    mov dx, offset Labda
    mov ah, 09h
    int 21h

    pop ax
    push ax

    mov bl, al
    mul bl
    shr ax, 1
    mov di, ax

    pop ax
    inc ax
    push ax
    dec ax

    mov bl, cl
    mul bl
    mov si, ax

    cmp si, 80
    jnc Var

    cmp di, 25
    jnc Var
    
    jmp Rajz

Var:
    xor ax, ax
    int 16h
    
Program_Vege:
    pop cx
    mov ax, 4c00h
    int 21h

Labda:
    db "O$"
    
Code    Ends
Data    Segment
Data    Ends
Stack   Segment
Stack   Ends

    End Start

