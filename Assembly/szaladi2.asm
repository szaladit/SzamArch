Code Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov ax, Code
	mov DS, ax

	;kepernyo torles
	mov ax, 03h
	int 10h

	;betoltjuk a cimke erteket
    mov di, offset ertek1

Menu_kiiras:
	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 3
	mov dl, 0
	int 10h
	
	;kiiras konzolra
	mov dx, offset menu0
	mov ah, 09h
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 4
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset menu1
	mov ah, 09h
	int 21h
	mov dx, offset szamlalo1
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 5
	mov dl, 0
	int 10h
	
	;kiiras konzolra
	mov dx, offset menu2
	mov ah, 09h
	int 21h
	mov dx, offset szamlalo2
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 6
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset menu3
	mov ah, 09h
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset menu4
	mov ah, 09h
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 8
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset szamok_kiiras
	mov ah, 09h
	int 21h

	; ;kurzort pozicional
    ; mov ah, 02h
	; mov bh, 0
	; mov dh, 11
	; mov dl, 10
	; int 10h

	; ;kiiras konzolra
	; mov dx, offset ertek1
	; mov ah, 09h
	; int 21h

	; ;kurzort pozicional
    ; mov ah, 02h
	; mov bh, 0
	; mov dh, 11
	; mov dl, 20
	; int 10h

	; ;kiiras konzolra
	; mov dx, offset ertek2
	; mov ah, 09h
	; int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 14
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset uzenet_kiiras
	mov ah, 09h
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 10
	int 10h


Bevitel:
	;varunk egy billentyu lenyomast
	xor ax, ax
	int 16h

	;ellenorizzuk, hogy 'b'-e? ha igen toroljuk az utolso beirt karaktert
    cmp al, 'b'
    jz Karakter_torles

	;ha a lenyomott billentyu 'esc' akkor kilepes a programbol
	cmp al, 27
	jz Program_kilepes_szakasz_1

	push ax
	;ellenorizzuk hogy beirtuk e mar mind a 4 karaktert
    mov ax, offset ertek1
    add ax, 4
    cmp ax, di
    jz Szakasz_cimke1
	pop ax

	;ellenorizzuk hogy a karakter 0-9?, ha igen taroljuk
    mov cx, 10
    mov ah, '0'
Karakter_vizsgalat:
    cmp al, ah
    jz Karakter_tarolas
    inc ah
    loop Karakter_vizsgalat

	;ha egyik elvart karakternek sem felel meg akkor hiba kiiras a kepernyore
	;kurzor pozicionalas
    mov ah, 02h
    mov bh, 0
    mov dh, 15
    mov dl, 0
    int 10h

    ;hiba string kiiras
    mov dx, offset hiba_uzenet
    mov ah, 09
    int 21h

	jmp Bevitel

Karakter_tarolas:
	;kepernyo torles
    mov bx, ax
    mov ax, 03
    int 10h
    mov ax, bx

	;az aktualisan lenyomott karaktert taroljuk majd utan lezaro karaktert tarolunk
    mov [di], al
    inc di
    mov al, '$'
    mov [di], al

	jmp Ertek_kiiras

Karakter_torles:
	;kepernyo torles
    mov bx, ax
    mov ax, 03
    int 10h
    mov ax, bx

	;csokkentjuk ertek1 cimet
	dec di

    ;ellenorizzuk hogy van e meg karakter
    mov ax, offset ertek1
    sub ax, 1
    cmp ax, di
    jz Alsohatar

    ;az aktualisan lenyomott karakterre lezaro karaktert rakunk ezzel roviditve a stringet
    mov al, '$'
    mov [di], al

	jmp Ertek_kiiras

Alsohatar:
    inc di
    jmp Menu_kiiras

Program_kilepes_szakasz_1:
	jmp Program_kilepes_szakasz_2

Szakasz_cimke1:
	mov di, offset ertek2
	jmp Bevitel3

Ertek_kiiras:
	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 10
	int 10h

	;kiiras konzolra
	mov dx, offset ertek1
	mov ah, 09h
	int 21h

	;szamlalo csokkentese
	mov ah, 0
	mov si, dx
hanyszor:
	mov bl, [si]
	inc si
	inc ah
	cmp bl, '$'
	jnz hanyszor
	dec ah

	;szamlalo kiszamitasa es atirasa cim szerint
	mov si, offset szamlalo1
	mov bh, '4'
	sub bh, ah
	mov [si], bh

	jmp Menu_kiiras

Program_kilepes_szakasz_2:
	jmp Program_kilepes_szakasz_3

Ertek2_elokeszites:
	;betoltjuk a cimke2 erteket
    mov di, offset ertek2

Menu_kiiras2:
	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 3
	mov dl, 0
	int 10h
	
	;kiiras konzolra
	mov dx, offset menu0
	mov ah, 09h
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 4
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset menu1
	mov ah, 09h
	int 21h
	mov dx, offset szamlalo1
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 5
	mov dl, 0
	int 10h
	
	;kiiras konzolra
	mov dx, offset menu2
	mov ah, 09h
	int 21h
	mov dx, offset szamlalo2
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 6
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset menu3
	mov ah, 09h
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 7
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset menu4
	mov ah, 09h
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 8
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset szamok_kiiras
	mov ah, 09h
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 10
	int 10h

	;kiiras konzolra
	mov dx, offset ertek1
	mov ah, 09h
	int 21h

	; ;kurzort pozicional
    ; mov ah, 02h
	; mov bh, 0
	; mov dh, 11
	; mov dl, 20
	; int 10h

	; ;kiiras konzolra
	; mov dx, offset ertek2
	; mov ah, 09h
	; int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 14
	mov dl, 0
	int 10h

	;kiiras konzolra
	mov dx, offset uzenet_kiiras
	mov ah, 09h
	int 21h

	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 20
	int 10h

Bevitel2:
	;varunk egy billentyu lenyomast
	xor ax, ax
	int 16h

	;ellenorizzuk, hogy 'b'-e? ha igen toroljuk az utolso beirt karaktert
    cmp al, 'b'
    jz Karakter_torles2

	;ha a lenyomott billentyu 'esc' akkor kilepes a programbol
	cmp al, 27
	jz Program_kilepes_szakasz_3

	push ax
	;ellenorizzuk hogy beirtuk e mar mind a 4 karaktert
    mov ax, offset ertek2
    add ax, 4
    cmp ax, di
    jz Felso_hatar

Bevitel3:
	pop ax
	;ellenorizzuk hogy a karakter 0-9?, ha igen taroljuk
    mov cx, 10
    mov ah, '0'
Karakter_vizsgalat2:
    cmp al, ah
    jz Karakter_tarolas2
    inc ah
    loop Karakter_vizsgalat2

	;ha egyik elvart karakternek sem felel meg akkor hiba kiiras a kepernyore
	;kurzor pozicionalas
    mov ah, 02h
    mov bh, 0
    mov dh, 15
    mov dl, 0
    int 10h

    ;hiba string kiiras
    mov dx, offset hiba_uzenet
    mov ah, 09
    int 21h

	jmp Bevitel2

Felso_hatar:
	;leutott billentyut visszarakjuk al-be a stack-ből
	pop ax
	;nem kell semmit csinálnunk, csak fenntartjuk a bekeres, torles, kilepes lehetoseget
	jmp Bevitel2

Program_kilepes_szakasz_3:
	jmp Program_kilepes_szakasz_4

Karakter_tarolas2:
	;kepernyo torles
    mov bx, ax
    mov ax, 03
    int 10h
    mov ax, bx

	;az aktualisan lenyomott karaktert taroljuk majd utan lezaro karaktert tarolunk
    mov [di], al
    inc di
    mov al, '$'
    mov [di], al

	jmp Ertek_kiiras2

Karakter_torles2:
	;kepernyo torles
    mov bx, ax
    mov ax, 03
    int 10h
    mov ax, bx

	;csokkentjuk ertek2 cimet
	dec di

    ;ellenorizzuk hogy van e meg karakter
    mov ax, offset ertek2
    sub ax, 1
    cmp ax, di
    jz Alsohatar2

    ;az aktualisan lenyomott karakterre lezaro karaktert rakunk ezzel roviditve a stringet
    mov al, '$'
    mov [di], al

	jmp Ertek_kiiras2

Alsohatar2:
	inc di
    jmp Menu_kiiras2

Program_kilepes_szakasz_4:
	jmp Program_Vege

Ertek_kiiras2:
	;kurzort pozicional
    mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 20
	int 10h

	;kiiras konzolra
	mov dx, offset ertek2
	mov ah, 09h
	int 21h

	;szamlalo csokkentese
	mov ah, 0
	mov si, dx
hanyszor2:
	mov bl, [si]
	inc si
	inc ah
	cmp bl, '$'
	jnz hanyszor2
	dec ah

	;szamlalo kiszamitasa es atirasa cim szerint
	mov si, offset szamlalo2
	mov bh, '4'
	sub bh, ah
	mov [si], bh

	jmp Menu_kiiras2

Program_Vege:
	;kepernyo torles
	mov ax, 03h
	int 10h

	;kurzor pozicionalas
    mov ah, 02h
    mov bh, 0
    mov dh, 10
    mov dl, 0
    int 10h

	;kiiras konzolra
    mov dx, offset veg_uzenet
    mov ah, 09h
    int 21h

    mov ax, 4c00h
    int 21h


menu0:
	db '|---------------------------------MENU----------------------------|$'

menu1:
    db '|-1---Kerem-az-elso-negyjegyu-szam-beirasat!---|---Maradek-szam: $'

menu2:
    db '|-2---Kerem-a-masodik-negyjegyu-szam-beirasat!-|---Maradek-szam: $'

menu3:
    db '|-3---Kilepeshez-nyomja-meg-az-"ESC"-gombot!----------------------|$'

menu4:
	db '|-----------------------------------------------------------------|$'

szamok_kiiras:
	db 'Beirt szamok: $'

szamlalo1:
	db '4|$'

szamlalo2:
	db '4|$'

ertek1:
    db '****$'

ertek2:
    db '----$'

uzenet_kiiras:
	db 'Program uzenete: $'

hiba_uzenet:
    db 'Nem megengedett karakter!$'
	
veg_uzenet:
    db 'Vege a bevitelnek! A program bezarult!$'

Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

End Start
