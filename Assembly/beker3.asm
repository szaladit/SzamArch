Code Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax,Code
    mov ds, ax

Init:
    ;betoltjuk a cimke erteket
    mov di, offset ertek

    ;kepernyo torles
    mov ax, 03
    int 10h

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 0
	mov dl, 0
	int 10h

    ;kiirom a szamlalot
    mov dx, offset maradek_uzenet
    mov ah, 09
    int 21h
    mov dx, offset maradek_szam
    int 21h

    ;pozicional
	mov ah, 02h
	mov bh, 0
	mov dh, 10
	mov dl, 0
	int 10h

    ;kiirja a menu1 string-et
	mov dx, offset menu1
	mov ah, 09h
	int 21h

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 10
	int 10h

Bevitel:
    ;varunk egy billentyu lenyomast
    xor ax, ax
    int 16h

    ;kepernyo torles
    mov bx, ax
    mov ax, 03
    int 10h
    mov ax, bx

    ;megnezzuk hogy a gomb 'ESC'-e?
    cmp al, 27
    jz Kilepes_cimke_14

    ;ellenorizzuk hogy a karakter 0-9? ha igen taroljuk
    mov cx, 10
    mov ah, '0'
Vizsg:
    cmp al, ah
    jz Tarol
    inc ah
    loop Vizsg

    ;ellenorizzuk, hogy 'b'-e? ha igen toroljuk az utolso beirt karaktert
    cmp al, 'b'
    jz Torol

    ;kurzor pozicionalas
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 0
    int 10h

    ;hiba string kiiras
    mov dx, offset hiba
    mov ah, 09
    int 21h

    jmp Bevitel
Bevitel_tmp:
    jmp Bevitel
Tarol:
    ;az aktualisan lenyomott karakter utan lezaro karaktert tarolunk
    mov [di], al
    inc di
    mov al, '$'
    mov [di], al

;     ;szamlalo csokkentese
;     mov cx, 4
;     mov bx, offset ertek
;     add bx, 4
; Szamol:
;     cmp bx, di
;     jz Tovabb
;     inc bx
;     loop Szamol
; Tovabb:
;     mov di, offset maradek_szam
;     dec [di]
;     mov di, offset ertek
;     add di, bx

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 0
	mov dl, 0
	int 10h

    ;kiiroma  szamlalot
    mov dx, offset maradek_uzenet
    mov ah, 09
    int 21h
    mov dx, offset maradek_szam
    int 21h

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 10
	int 10h

    ;kiirom az erteket
    mov dx, offset ertek
    mov ah, 09
    int 21h

    ;ellenorizzuk hogy beirtuk e mar mind a 4 karaktert
    mov ax, offset ertek
    add ax, 4
    cmp ax, di
    jnz Bevitel_tmp

    jmp Init2
Kilepes_cimke_14:
    jmp Kilepes_cimke_24
    ;az utolso beirt karakter torlese
Torol:
    dec di

    ;ellenorizzuk hogy beirtuk e mar mind a 4 karaktert
    mov ax, offset ertek
    sub ax, 1
    cmp ax, di
    jz Alsohatar

    ;az aktualisan lenyomott karakter utan lezaro karaktert tarolunk
    mov al, '$'
    mov [di], al

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 10
	int 10h

    ;kiiras
    mov dx, offset ertek
    mov ah, 09
    int 21h

    jmp Bevitel

Alsohatar:
    inc di
    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 0
	int 10h

    jmp Bevitel
;------------------------------------------------------------------------
;masodik 4 szamjegy------------------------------------------------------
Init2:
    ;betoltjuk a cimke erteket
    mov di, offset ertek2

    ;pozicional
	mov ah, 02h
	mov bh, 0
	mov dh, 10
	mov dl, 0
	int 10h

    ;kiirja a menu1 string-et
	mov dx, offset menu2
	mov ah, 09h
	int 21h

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 20
	int 10h

Bevitel2:
    ;varunk egy billentyu lenyomast
    xor ax, ax
    int 16h

    ;kepernyo torles
    mov bx, ax
    mov ax, 03
    int 10h
    mov ax, bx

    ;megnezzuk hogy a gomb 'ESC'-e?
    cmp al, 27
    jz Kilepes_cimke_24

    ;ellenorizzuk hogy a karakter 0-9? ha igen taroljuk
    mov cx, 10
    mov ah, '0'
Vizsg2:
    cmp al, ah
    jz Tarol2
    inc ah
    loop Vizsg2

    ;ellenorizzuk, hogy 'b'-e? ha igen toroljuk az utolso beirt karaktert
    cmp al, 'b'
    jz Torol2

    ;kurzor pozicionalas
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 0
    int 10h

    ;hiba string kiiras
    mov dx, offset hiba
    mov ah, 09
    int 21h

    jmp Bevitel2
Kilepes_cimke_24:
    jmp Kilepes_cimke_34

Tarol2:
    ;az aktualisan lenyomott karakter utan lezaro karaktert tarolunk
    mov [di], al
    inc di
    mov al, '$'
    mov [di], al

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 10
	int 10h

    ;kiiras
    mov dx, offset ertek
    mov ah, 09
    int 21h

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 20
	int 10h

    ;kiiras
    mov dx, offset ertek2
    mov ah, 09
    int 21h

    ;ellenorizzuk hogy beirtuk e mar mind a 4 karaktert
    mov ax, offset ertek2
    add ax, 4
    cmp ax, di
    jnz Bevitel2
Kilepes_cimke_34:
    jmp Kilepes_cimke_vege

    ;az utolso beirt karakter torlese
Torol2:
    dec di

    ;ellenorizzuk hogy beirtuk e mar mind a 4 karaktert
    mov ax, offset ertek2
    sub ax, 1
    cmp ax, di
    jz Alsohatar2

    ;az aktualisan lenyomott karakter utan lezaro karaktert tarolunk
    mov al, '$'
    mov [di], al

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 10
	int 10h

    ;kiiras
    mov dx, offset ertek
    mov ah, 09
    int 21h

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 20
	int 10h

    ;kiiras
    mov dx, offset ertek2
    mov ah, 09
    int 21h

    jmp Bevitel2

Alsohatar2:
    inc di
    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 0
	int 10h

    jmp Bevitel2


Kilepes_cimke_vege:

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 10
	int 10h

    ;kiiras
    mov dx, offset ertek
    mov ah, 09
    int 21h

    ;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 20
	int 10h

    ;kiiras
    mov dx, offset ertek2
    mov ah, 09
    int 21h

    ;pozicional
	mov ah, 02h
	mov bh, 0
	mov dh, 10
	mov dl, 0
	int 10h

    ;kiirja a menu3 string-et
	mov dx, offset menu3
	mov ah, 09h
	int 21h

    ;varunk egy billentyu lenyomast
    xor ax, ax
    int 16h

    ;kepernyo torles
    mov bx, ax
    mov ax, 03
    int 10h
    mov ax, bx

    ;megnezzuk hogy a gomb 'ESC'-e?
    cmp al, 27
    jnz Kilepes_cimke_vege

    ;kurzor pozicionalas
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 0
    int 10h

    mov dx, offset veguzenet
    mov ah, 09h
    int 21h

    mov ax, 4c00h
    int 21h

hiba:
    db 'Nem megengedett karakter! Nyomjon ESC-t a Kilepes_cimke bezarasahoz!$'

ertek:
    db '****$'

ertek2:
    db '----$'

veguzenet:
    db 'Vege a bevitelnek!$'

menu1:
    db 'Kerem az elso negyjegyu szam beirasat!$'

menu2:
    db 'Kerem a masodik negyjegyu szam beirasat!$'

menu3:
    db 'ESC - kilepes$'

maradek_uzenet:
    db 'Maradek szamjegy: $'

maradek_szam:
    db '4$'

Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

    End Start

