Code Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, ax

    ;kepernyo torles
    mov ax, 03h
    int 10h

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 10
	mov dl, 0
	int 10h

    ;kiirom az utasitast
    mov dx, offset Uzenet
    mov ah, 09
    int 21h

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 0
	int 10h

Bekeres:
    ;bekerem a szamot, varunk egy billentyu lenyomast
    xor ax, ax
    int 16h

    ;ha esc akkor kilep
    cmp al, 27
    jz Program_Vege

    ;ellenorizzuk hogy a karakter 2-9? ha igen taroljuk
    mov cx, 8
    mov ah, '2'
Vizsg:
    cmp al, ah
    jz Init
    inc ah
    loop Vizsg

    jmp Bekeres

Init:
    ;tarolom a leutott billentyut si-ben
    xor ah, ah
    sub al, '0' ;convert to int
    mov si, ax

    ;inicializalas
    xor di, di

    xor dx, dx
    push dx 

Torles: 
    mov ax, 03h
    int 10h

    ;kurzor pozicionalas
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


    mov ax, [si]
    
; eltelt ido nagyobb mint az idovaltozas?
Beallit:
    xor ah, ah
    cmp dx, ax

    pop ax

    jc Kesleltet

;elozo ido aktualizalasa
    pop cx
    push ax

;uj pozicio kiszamitasa
Mozgas:
    add di, 1
    jmp Torles
    
Program_Vege:

    mov ax, 03h
    int 10h

    pop cx
    mov ax, 4c00h
    int 21h

Uzenet:
    db "Kerek egy szamot 2 es 9 kozott!$"

Labda:
    db "9$"
    
Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

    End Start 