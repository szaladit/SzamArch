Code Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, ax

    ;inicializalas
    xor di, di
    mov si, 1

    xor dx, dx
    push dx

Torles: 
    mov ax, 03h
    int 10h

    ;kurzor pozicionalas (oszlop poziciot csokkenteni kell majd a háziban)
    mov dx, di
    mov dh, dl

    mov dl, 40
    xor bh, bh
    mov ah, 02h
    int 10h

    mov dx, offset Labda
    mov ah, 09h
    int 21h

Kesleltet:
    mov ah, 01h
    int 16h
    ;jnz Program_Vege
    
    jz nincsbill
    mov ah, 00h
    int 16h
    cmp al, 27
    jz Program_Vege
nincsbill:
    xor ah, ah
    int 1ah

    pop cx
    push cx
    mov ax, dx
    sub dx, cx
    push ax

    cmp di, 5
    jnc Ido1
    mov al, 10
    jmp Beallit

;poz < 10?
Ido1:
    cmp di, 10
    jnc Ido2
    mov al, 8
    jmp Beallit

;poz < 15?
Ido2:
    cmp di, 15
    jnc Ido3
    mov al, 4
    jmp Beallit

;poz < 20?
Ido3:
    cmp di, 20
    jnc Ido4
    mov al, 2
    jmp Beallit
    
;delta ido egyenlo 1?
Ido4:
    mov al, 2
    
; eltelt ido nagyobb mint az idovaltozas?
Beallit:
    xor ah, ah
    cmp dx, ax

    pop ax

    jc Kesleltet

;elozo ido aktualizalasa
    pop cx
    push ax

;poz 0?
    cmp di, 0
    jz Lefele

;poz 24?
    cmp di, 24
    jz Felfele
    
;egyik feldatnal ide kell irni majd valami pozicio torlest

;uj pozicio kiszamitasa
Mozgas:
    add di, si
    jmp Torles
    
;irany beallitasa le
Lefele:
    mov si, 1
    jmp Mozgas

;irany beallitasa fel
Felfele:
    mov si, -1
    jmp Mozgas
    
Program_Vege:
    pop cx
    mov ax, 4c00h
    int 21h
    
Labda:
    db "O$"
    
Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

    End Start 