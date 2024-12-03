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

    ;ha esc akkor kilep
    cmp al, 27
    jz Program_Vege

    ;ellenorizzuk hogy a karakter 2-9? ha igen taroljuk
    mov cx, 8
    mov ah, '2'
        mov di, dx
    mov ah, 1
    sub [di], ah
Vizsg:
    cmp al, ah
    jz Tovabb
    inc ah
    loop Vizsg

    ;nem tortenik semmi ha rossz karaktert írunk be
    jmp Bekeres

Tovabb:
    ;leutott billentyut kovertaljuk es eltaroljuk
    sub al, '0'
    mov bl, al

Szamlalo_kiiras:
    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 0
	int 10h

    ;kiirom a szamlalot
    mov dx, si
    mov ah, 09
    int 21h

Kesleltet:
    ;ora beolvasasa a cx dx-be
    xor ah, ah
    int 1ah

    ;eltelt ido kiszamitasa
    pop cx      ;regi ido kivetele
    push cx     ;regi ido visszatetele
    push dx     ;aktualis ido mentese a verembe
    sub dx, cx  ;dx-ben a T eltelt = T aktualis - T regi 

    ;beallitjuk a timer merteket
    sub bl, 1
    mov al, bl

Beallit:
    xor ah, ah  ;ah-t nullazom
    cmp dx, ax  ;megnezem hogy dx es ax erteke kulonbozo e
    pop ax      ;kiszedem a timer erteket a verembol
    jc Kesleltet

    ;elozo ido aktualizalasa
    pop cx      ;regi ido kivetele a verembol
    push ax     ;aktualis ido elmentese

    ;ha 0 akkor kilepes
    mov bx, '0'
    mov ax, [si]
    cmp al, bl
    jz Program_Vege

    ;szam csokkentes
	mov bh, -1
	add [si], bh

    jmp Szamlalo_kiiras

Program_Vege:

    ;kepernyo torles
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