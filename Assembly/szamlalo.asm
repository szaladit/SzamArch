Code Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov ax, Code
	mov DS, ax
	mov ax, 03h
	int 10h

Kiir:
	mov ah, 02h
	mov bh, 0
	mov dh, 10
	mov dl, 0
	int 10h
	mov dx, offset uzenet1
	mov ah, 09h
	int 21h
	mov dx, offset szamlalo_1X
	int 21h
	mov dx, offset szamlalo_X1
	int 21h
	mov dx, offset uzenet2
	int 21h

Bevitel:
	xor ax, ax
	int 16h
	cmp al, 27
	jz Program_fele
	cmp al, 'a'
	jz Novel
	cmp al, 'd'
	jz Csokken
	jmp Bevitel

Novel:
	jmp OF_vizsgalat
OF_vege:
	mov di, offset szamlalo_X1
	mov al, [di]
	inc al
	mov [di], al
	jmp Kiir

OF_vizsgalat:
	mov di, offset szamlalo_X1
	mov al, [di]
	inc al
	cmp al, ':'
	jz Novel10
	jmp OF_vege

Novel10:
	mov al, '0'
	mov [di], al
	mov di, offset szamlalo_1X
	mov al, [di]
	inc al
	cmp al, ':'
	jz Max
	mov [di], al
	jmp Kiir
Max:
	dec al
	mov [di], al
	mov di, offset szamlalo_X1
	mov ah, [di]
	mov ah, '9'
	mov [di], ah
	jmp Kiir

Program_fele:
	jmp Program_Vege

Csokken:
	jmp UF_vizsgalat
UF_vege:
	mov di, offset szamlalo_X1
	mov al, [di]
	dec al
	mov [di], al
	jmp Kiir

UF_vizsgalat:
	mov di, offset szamlalo_X1
	mov al, [di]
	dec al
	cmp al, '/'
	jz Csokken10
	jmp UF_vege

Csokken10:
	mov al, '9'
	mov [di], al
	mov di, offset szamlalo_1X
	mov al, [di]
	dec al
	cmp al, '/'
	jz Min
	mov [di], al
	jmp Kiir
Min:
	inc al
	mov [di], al
	mov di, offset szamlalo_X1
	mov ah, [di]
	mov ah, '0'
	mov [di], ah
	jmp Kiir

Program_Vege:
	mov ax, 4c00h
	int 21h

uzenet1:
	db "Az 'a' billentyu $"

uzenet2:
	db " alkalommal volt leutve!$"

szamlalo_1X:
	db "0$"

szamlalo_X1:
	db "0$"

Code Ends

Data Segment
Data Ends

Stack Segment
Stack Ends

End Start
