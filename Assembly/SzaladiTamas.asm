;==========================================================================
; Processzorok utasitas szintu kezelese
; Levenlezo
;
; Nev: Szaládi Tamás
; Neptun kod: IYWOJD
; Datum: 2024.12.04
; 
;==========================================================================

Code Segment
	             assume CS:Code, DS:Data, SS:Stack

	Start:       
	             mov    ax, Code
	             mov    DS, AX

	Feladat_1:   
	;===========================================================================
	; 1. feladat:
	;
	; Karakteres uzemmodban rajzoljon egy rombuszt.
	;A rombusz egyik csucsa legyen a 6,12 koordinatan.
	;
	;A rombusz merete es elhelyezkedese az alabbi vazlatnak megfelelo legyen!
	;A feladatot szamolassal, ciklussal kell megoldani, sztringek kirajzolasa nem jo!
	;
	;    x
	;   x x
	;  x   x
	; x     x
	;x       x
	; x     x
	;  x   x
	;   x x
	;    x
	;
	;
	; Csak a programban megadott "x$" string-et használhatja!
	;
	;
	; 15 perc, 0 vagy 1 pont
	;===========================================================================
	Torles:      
	             mov    ax, 03h
	             int    10h

	             mov    dx, offset feladat1
	             mov    ah,9
	             int    21h
	             xor    ax, ax
	             int    16h
	
	             xor    ax, ax
	             xor    bx, bx
	             xor    cx, cx
	             xor    dx, dx
	             xor    di, di
	             xor    si, si
	; --------------------------------------------------------------------------
	; Ide irja a megfelelo programreszt!

			mov	di, offset iksz
			mov dh, 16  ;lefele offset
			mov dl, 1   ;jobbra offset

			push dx

			mov cx, 16

			Ciklus:

				;kurzort pozicional
				pop 	dx
				push	dx
				xor     bx, bx
				mov     ah, 02
				int     10h

				;Karakter kiiras:
				mov	ah,2
				mov	dx, [di]
				int	21h

				pop dx

				cmp cx, 12
				jg elso_negyed

				cmp cx, 8
				jg masodik_negyed

				cmp cx, 4
				jg harmadik_negyed

				cmp cx, 0
				jg negyedik_negyed

			negyed_veg:

				push dx

				loop Ciklus

				jmp elso_feladat_vege ;kilepes az elso feladatbol
			
			elso_negyed:
				add dh, 1  ;lefele offset
				add dl, 1   ;jobbra offset
				jmp negyed_veg

			masodik_negyed:
				sub dh, 1  ;lefele offset
				add dl, 1   ;jobbra offset
				jmp negyed_veg
			
			harmadik_negyed:
				sub dh, 1  ;lefele offset
				sub dl, 1   ;jobbra offset
				jmp negyed_veg

			negyedik_negyed:
				add dh, 1  ;lefele offset
				sub dl, 1   ;jobbra offset
				jmp negyed_veg

	elso_feladat_vege:
	; Eddig
	; --------------------------------------------------------------------------
	; Varakozas billentyu leutesre
	             xor    ax, ax
	             int    16h
	
	Feladat_2:   
	;===========================================================================
	; 2. feladat:
	;
	; Szamolja meg az alabbi mondat szavait es irja ki a  kepernyore:
	;
	;	"Az assembly nyelv nem keverendo ossze a gepi koddal!"
	;
	; Feltetelezzuk, hogy a magyar helyesirasi szabalyoknak megfeleloen a szavak
	; kozott mindig 1 szokoz van!
	; Hasznalja a program elore megirt uzenetet (mondat)!
	;
	; 15 perc, 0 vagy 1 pont
	;===========================================================================
	             mov    ax, 03h
	             int    10h

	             mov    ah,9
	             mov    dx, offset feladat2
	             int    21h

	             mov    dh, 2
	             mov    dl, 5
	             xor    bx, bx
	             mov    ah, 02
	             int    10h
	
	             mov    ah,9
	             mov    dx, offset mondat
	             int    21h

	             mov    dh, 3
	             mov    dl, 5
	             xor    bx, bx
	             mov    ah, 02
	             int    10h
	
	             mov    ah,9
	             mov    dx, offset feladat2_1
	             int    21h
	
	             xor    ax, ax
	             int    16h
	             xor    ax, ax
	             xor    bx, bx
	             xor    cx, cx
	             xor    dx, dx
	             xor    di, di
	             xor    si, si
	; --------------------------------------------------------------------------
	; Ide irja a megfelelo programreszt!
				mov	di, offset mondat
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

				mov dh, 3
				mov dl, 18
				xor bx, bx
				mov ah, 02
				int 10h 

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
	; Varakozas billentyu leutesre
	             xor    ax, ax
	             int    16h
	
	Feladat_3:   
	;===========================================================================
	; 3. feladat:
	;Karakteres uzemmodban irja ki a "Indul a gorog aludni!" uzenetet!
	;Hasznalja a meglevo "uzenet3" sztringet! Ne irja ki az "x" karaktert,
	;ami tobbszor is lehet egymas utan.
	;
	; 15 perc, 0 vagy 1 pont
	;===========================================================================
	             mov    ax, 03h
	             int    10h
	
	             mov    ah,9
	             mov    dx, offset feladat3
	             int    21h
	             xor    ax, ax
	             int    16h

	             xor    ax, ax
	             xor    bx, bx
	             xor    cx, cx
	             xor    dx, dx
	             xor    di, di
	             xor    si, si
	
	; --------------------------------------------------------------------------
	; Ide irja a megfelelo programreszt!



	; Eddig
	; --------------------------------------------------------------------------
	; Varakozas billentyu leutesre
	             xor    ax, ax
	             int    16h
	;4. feladat:
	;Szamitsa ki a "muvelet1" sztringben megadott osztast.
	;A ket szamjegyet elvalaszto "/" szimbolumot nem kell feldolgozni!
	;A osztas eredmenyet es a maradekot decimalis formaban irja ki + szoveg (eredmeny, maradek)!
	;==========================================================================
	             mov    ax, 03h
	             int    10h
	
	             mov    ah, 02h
	             mov    bh, 0
	             mov    dl,0                                                   	;DL:X koordinata
	             mov    dh,2                                                   	;DH:Y koordinata
	             int    10h

	             mov    dx, offset feladat4
	             mov    ah,9
	             int    21h
	             xor    ax,ax
	             int    16h

	             mov    ah, 02h
	             mov    bh, 0
	             mov    dl,0                                                   	;DL:X koordinata
	             mov    dh,6                                                   	;DH:Y koordinata
	             int    10h

	;**************************************************************************
	;Ide irja a megfelelo programreszt!
				mov di, offset muvelet1
				mov al, [di]    ;9
				sub al, 30h      ;konvert
				mov bl, [di+2]  ;2
				sub bl, 30h

				xor ah, ah
				xor bh, bh

				div bx ;ax ertek, dx maradek. Nekem valamiért kifagy ez a sor :(

				push dx

				;eredmeny Karakter kiiras:
				mov	ah,2
				mov	dx, ax
				int	21h

				;kurzort pozicional
				mov     dh, 1  ;lefele offset
				mov     dl, 5  ;jobbra offset
				xor     bx, bx
				mov     ah, 02
				int     10h

				pop dx

				;Maradek Karakter kiiras:
				mov	ah,2
				int	21h



	;Eddig
	;**************************************************************************
	             xor    ax,ax
	             int    16h

	             mov    ax, 03h
	             int    10h
	
	Program_Vege:
	             mov    ax, 4c00h
	             int    21h


	feladat1     db     "1. feladat: rajzolas $"
	iksz         db     "x$"


	feladat2     db     "2. feladat: Szavak szama az alabbi mondatban:$"
	feladat2_1   db     "Szavak szama: $"
	mondat       db     "Az assembly nyelv nem keverendo ossze a gepi koddal!$"


	feladat3     db     "3. feladat: Szoveg kiirasa: $"
	uzenet3      db     "x!xixnxdxuxxxxxlxax xgxxxxoxrxoxgxxx xax xlxuxdxxnxI"

	feladat4     db     "Negyedik feladat: szamolas.$"
	muvelet1     db     "9/2"

Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

