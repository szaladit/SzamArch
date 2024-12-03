Code Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, AX

    mov dl, 100     ;X koordináta 
    mov dh, 100     ;Y koordináta
    push dx

    mov ax, 13h
    int 10h

    mov ax, 0a000h  ;Videó Kezdőcím
    mov es, ax      ;Extra Segmens

    mov si, 34       ;global valtozo a pixel szin valtoztatashoz

Rajz:
    pop dx          ;dx-ben Y(dh), X(dl) koordináta
    xor ah, ah
    mov al, dh      ;ax-ben Y koordináta
    push dx         ;dx mentése, mul utasítás felülírja
    mov bx, 320
    mul bx          ;Y koordináta * 320

    ;16bites megoldas
    pop dx          ;dx-ben Y(dh), X(dl) koordináta
    push dx
    xor dh, dh    
    add ax, dx

Pixel:
    mov di, ax

;     ;8bites megoldas
;     pop dx
;     add al, dl 
;     jnc Pixel 
;     inc ah 
    
; Pixel: 
;     push dx
;     mov di, ax

    mov al, [si]    ;pixel színe
    inc si
    cmp si, 81
    jz  Szin_reset

Szin_reset_vege:

    mov es:[di], al ;videó 

Var:
    xor ah, ah      ;bevitel
    int 16h

    cmp al, 27      ;ESC?
    jz Program_Vege
    
    cmp ah, 75      ;balra?
    jz Balra
    
    cmp ah, 77      ;jobbra?
    jz Jobbra
    
    cmp ah, 72      ;felfelé?
    jz Felfele
    
    cmp ah, 80      ;lefelé?
    jz Lefele
    
    jmp Var

Szin_reset:
    mov bx, 34
    mov si, bx
    jmp Szin_reset_vege

;szamol és hatart ellenoriz
Balra:
    pop dx
    dec dl
    cmp dl, 1
    ; jnc Tarol1
    jnc Tarol
    inc dl
    jmp Tarol
;Tarol1:
; push dx
; jmp Rajz

Jobbra:
    pop dx
    inc dl
    cmp dl, 250
    ; jc Tarol2
    jc Tarol
    dec dl
    jmp Tarol
;Tarol2:
; push dx
; jmp Rajz

Felfele:
    pop dx
    dec dh
    cmp dh, 1
    ; jnc Tarol3
    jnc Tarol
    inc dh
    jmp Tarol
;Tarol3:
; push dx
; jmp Rajz

Lefele:
    pop dx
    inc dh
    cmp dh, 200
    ; jc Tarol4
    jc Tarol
    dec dh
    jmp Tarol
;Tarol4:
; push dx
; jmp Rajz

Tarol:
    push dx
    jmp Rajz
    
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

        