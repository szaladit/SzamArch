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

    ;tarolom a leutott billentyut si-ben
    xor ah, ah
    push ax
    sub al, '0' ;convert to int
    mov si, ax
    pop ax

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
    ;inicializalas
    xor dx, dx
    push dx 

Torles:
    ;kepernyo torles
    mov ax, 03h
    int 10h

    ;ha 0 után vagyunk akkor kilepunk a programbol
    mov ah, '/'
    cmp [di], ah
    jz Program_Vege

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

    ;kiirjuk a szamlalot
    mov dx, offset Szamlalo
    mov ah, 09h
    int 21h

    ;kivonunk egyet a szamlalobol
    mov di, dx
    mov ah, 1
    sub [di], ah

Kesleltet:
    mov ah, 01h
    int 16h
    ;jnz Program_Vege
    
    xor ah, ah
    int 1ah

    pop cx
    push cx
    mov ax, dx
    sub dx, cx
    push ax

    ;beallitjuk a szamolas sebesseget
    mov ax, si
    
; eltelt ido nagyobb mint az idovaltozas?
Beallit:
    xor ah, ah
    cmp dx, ax

    pop ax

    jc Kesleltet

;elozo ido aktualizalasa
    pop cx
    push ax

    jmp Torles
    
Program_Vege:

    mov ax, 03h
    int 10h

    pop cx
    mov ax, 4c00h
    int 21h

Uzenet:
    db "Kerek egy szamot 2 es 9 kozott!$"

Szamlalo:
    db ":$"
    
Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

    End Start 