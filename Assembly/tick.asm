Code Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, ax

    ;inicializalas
    xor di, di
    xor dx, dx
    push dx

    ;kepernyo torles
    mov ax, 03h
    int 10h

    ;bekeres tarolasa
    mov si, offset Szamlalo

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

    ;eltaroljuk al-t a stack-ben
    push ax

    ;ha esc akkor kilep
    cmp al, 27
    jz Program_Vege

    ;ellenorizzuk hogy a karakter 2-9? ha igen taroljuk
    mov cx, 8
    mov ah, '2'
Vizsg:
    cmp al, ah
    jz Tovabb
    inc ah
    loop Vizsg

    ;nem tortenik semmi ha rossz karaktert írunk be
    jmp Bekeres

Tovabb:
    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 0
	int 10h

    ;kiirom a szamlalot
    mov dx, offset Szamlalo
    mov ah, 09
    int 21h

Kesleltet:
    ;ora beolvasasa
    xor ah, ah
    int 1ah

    ;kiszedjuk a neutott karaktert a stack-bol
    pop bx

    ;eltelt ido kiszamitasa
    pop cx
    push cx
    mov ax, dx
    sub dx, cx
    push ax

    ;beallitjuk a timer merteket
    mov al, bl

Beallit:
    xor ah, ah
    cmp dx, ax

    pop ax

    jc Kesleltet

    ;elozo ido aktualizalasa
    pop cx
    push ax

    ;szam csokkentes
	mov bh, -1
	add [si], bh

    ;ha 0 akkor kilepes
    mov bx, '0'
    cmp [si], bx

    jz Program_Vege

    jmp Tovabb

Program_Vege:

    ;kepernyo torles
    mov ax, 03h
    int 10h

    pop cx
    mov ax, 4c00h
    int 21h
    
Uzenet:
    db "Kerek egy szamot 2 es 9 kozott!$"

Input:
    db " $"

Szamlalo:
    db "9$"
    
Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

    End Start 