;==========================================================================
; Processzorok utasításszintű kezelése
; Nappali
;
; Név: 
; Neptun kód: 
; Dátum: 
; 
;==========================================================================

Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

Feladat_1:
;===========================================================================
; 1. feladat:
;
; Határozza meg a (4^N / 8) függvény értékét, ahol az N egy a billentyűzetről 
; beolvasott pozitív egész szám, melynek értékei csak az alábbiak lehetnek:
;
; 		1, 2, 3
;
; A leütött billentyűt be kell helyettesíteni az N helyére, majd az eredményt 
; ki kell írni a kettőspont után! 
; 
; pl: (4^3 / 8)  = eredmény 8:
; 1. feladat: függvény eredménye: 8
;
; Nem megengedett karakter esetén írja ki, az alábbit: 
;  		"Hibás karakter!"
; (Csak egyszer fusson le)
; Használja a program előre megírt üzenetét (hibas_karakter)!
;
; 15 perc, 0 vagy 1 pont
;===========================================================================
Torles:
	mov	ax, 03h
	int	10h

	mov	dx, offset feladat1
	mov	ah,9
	int	21h
	
	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor di, di
	xor si, si
; --------------------------------------------------------------------------
; Ide írja a megfelelő programrészt!
    xor	ax, ax
	int	16h

    cmp al, 27
    jz Elso_vege

    cmp al, '0'
    jl Hiba

    cmp al, '9'
    jg Hiba

    sub al, 31h
    xor ah, ah
    mov cx, ax
    mov ax, 4
    mov bx, 4
Emeles:

    mul bx

    loop Emeles

    mov bx, 8
    div bx

	mov cx, ax
	cmp cx, 10
	jl Kiir2

	mov bx, 10
	div bx
	mov cx, dx

Kiir1:
	;pozicional
	mov ah, 02h
	mov bh, 0
	mov dh, 0
	mov dl, 42
	int 10h

	add ax, 30h
    mov dx, ax
	mov	ah,2
	int	21h

Kiir2:
    ;pozicional
	mov ah, 02h
	mov bh, 0
	mov dh, 0
	mov dl, 43
	int 10h

	add cx, 30h
    mov dx, cx
	mov	ah,2
	int	21h

	;pozicional
	mov ah, 02h
	mov bh, 0
	mov dh, 0
	mov dl, 44
	int 10h

	mov dx, '!'
	mov	ah,2
	int	21h

    jmp Elso_vege

Hiba:
    mov	dx, offset Hiba
	mov	ah,9
	int	21h

Elso_vege:
; Eddig
; -------------------------------------------------------------------------- 
; Várakozás billentyű leütésre
	xor	ax, ax
	int	16h
	
Feladat_2:
;===========================================================================
; 2. feladat:
;
; Szamolja meg az alabbi mondat szavait es irja ki a kepernyore:
;
;    "Az assembly nyelv nem keverendo ossze a gepi koddal!"
;
; Feltetelezzuk, hogy a magyar helyesirasi szabalyoknak megfeleloen a szavak 
; kozott mindig 1 szokoz van!
; Hasznalja a program elore megirt uzenetet (mondat)!
;
; 15 perc, 0 vagy 1 pont
;===========================================================================
	mov	ax, 03h
	int	10h

	mov	ah,9
	mov	dx, offset feladat2
	int	21h	

	mov     dh, 2
	mov     dl, 5
	xor     bx, bx
	mov     ah, 02
	int     10h 
	
	mov	ah,9
	mov	dx, offset mondat
	int	21h

	mov     dh, 3
	mov     dl, 5
	xor     bx, bx
	mov     ah, 02
	int     10h 
	
	mov	ah,9
	mov	dx, offset feladat2_1
	int	21h
	
	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor di, di
	xor si, si
	

; --------------------------------------------------------------------------
; Ide írja a megfelelő programrészt!

	mov	di, offset mondat
	mov bx, [di] ;just for debug
	mov bx, 0
	mov cx, 52
Vizsgal:

	mov ax, ' '
	cmp [di], al
	jz novel

	mov ax, '!'
	cmp [di], al
	jz novel

novel_vege:

	inc di

	loop Vizsgal

	push bx

	mov     dh, 3
	mov     dl, 18
	xor     bx, bx
	mov     ah, 02
	int     10h 

	pop bx
	xor bh, bh
	add bx, 30h
	
	mov	ah,2
	mov	dx, bx
	int	21h

	jmp masodik_vege

novel:
	inc bx
	jmp novel_vege

masodik_vege:
; Eddig
; --------------------------------------------------------------------------
; Várakozás billentyű leütésre
	xor ax, ax
	int 16h
	

Feladat_3:
;===========================================================================
; 3. feladat:
; Dontse el a megnyomott billentyurol, hogy szamot, vagy egyeb karaktert
; "vitt" be! A ciklusbol CSAK AZ "ESC" billentyű leutesevel lehet kilepni.
; Hasznalja a program elore megirt üzeneteit (uzenetszam, uzenetnemszam)!
;
; 15 perc, 0 vagy 1 pont
;===========================================================================
	mov	ax, 03h
	int	10h
	
	mov	ah,9
	mov	dx, offset feladat3
	int	21h	

	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor di, di
	xor si, si
	
; --------------------------------------------------------------------------
; Ide írja a megfelelő programrészt!
Ciklus:

	xor ax, ax
	int 16h

	push ax

	cmp al, 27
	jz harmadik_vege

	cmp al, '0'
	jl Nem_szam

	cmp al, '9'
	jg Nem_szam

	;kurzort pozicional
	mov     dh, 1  ;lefele offset
	mov     dl, 0 ;jobbra offset
	xor     bx, bx
	mov     ah, 02
	int     10h

	;string kiiras:
	mov	ah,9
	mov	dx, offset uzenetszam
	int	21h

	;kurzort pozicional
	mov     dh, 1  ;lefele offset
	mov     dl, 24 ;jobbra offset
	xor     bx, bx
	mov     ah, 02
	int     10h

	;Karakter kiiras:
	pop ax
	push ax
	mov	ah,2
	xor dh, dh
	mov	dl, al
	int	21h

Nem_szam_vege:
	jmp Ciklus

Nem_szam:

	;kurzort pozicional
	mov     dh, 1  ;lefele offset
	mov     dl, 0 ;jobbra offset
	xor     bx, bx
	mov     ah, 02
	int     10h

	;string kiiras:
	mov	ah,9
	mov	dx, offset uzenetnemszam
	int	21h
	jmp Nem_szam_vege


harmadik_vege:
; Eddig
; --------------------------------------------------------------------------
; Várakozás billentyű leütésre
	xor ax, ax
	int 16h	
	
	
	mov ax, 03h
	int 10h
	
Program_Vege:
	mov	ax, 4c00h
	int	21h


feladat1	    db	"1. feladat: (4^N / 8) fuggveny eredmenye: $" 
hibas_karakter	db	"Hibas karakter!$"


feladat2	db	"2. feladat: Szavak szama az alabbi mondatban:$"
feladat2_1	db	"Szavak szama: $"
mondat		db	"Az assembly nyelv nem keverendo ossze a gepi koddal!$"


feladat3	db	"3. feladat: Szam vagy nem szam: $"
uzenetszam	db	"Szamjegy lett leutve!    $"
uzenetnemszam	db	"Nem szamjegy lett leutve!$"


Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
