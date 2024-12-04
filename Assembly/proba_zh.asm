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

    add ax, 30h

    ;pozicional
	mov ah, 02h
	mov bh, 0
	mov dh, 0
	mov dl, 0
	int 10h

    mov dx, offset feladat1
    mov dx, ax

	mov	ah,9
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
; Számolja meg az alábbi mondat szavait és írja ki a képernyőre:
;
;	"Az assembly nyelv nem keverendő össze a gépi kóddal!"
;
; Feltételezzük, hogy a magyar helyesírási szabályoknak megfelelően a szavak 
; között mindig 1 szóköz van!
; Használja a program előre megírt üzenetét (mondat)!
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



; Eddig
; --------------------------------------------------------------------------
; Várakozás billentyű leütésre
	xor ax, ax
	int 16h
	

Feladat_3:
;===========================================================================
; 3. feladat:
; Döntse el a megnyomott billentyűről, hogy számot, vagy egyéb karaktert
; "vitt" be! A ciklusból CSAK AZ "ESC" billentyű leütésével lehet kilépni.
; Használja a program előre megírt üzeneteit (uzenetszam, uzenetnemszam)!
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
hibas_karakter	db	"Hibás karakter!$"


feladat2	db	"2. feladat: Szavak száma az alábbi mondatban:$"
feladat2_1	db	"Szavak száma: $"
mondat		db	"Az assembly nyelv nem keverendő össze a gépi kóddal!$"


feladat3	db	"3. feladat: Szám vagy nem szám: $"
uzenetszam	db	"Számjegy lett leütve!    $"
uzenetnemszam	db	"Nem számjegy lett leütve!$"


Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
