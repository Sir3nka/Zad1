;;=============================================================================;
;                                                                             ;
; Plik           : arch1-2c.asm                                               ;
; Format         : COM                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie programów           ;
;                  asemblerowych                                              ;
; Autorzy        : Przemyslaw Otrembski, Adrian D³ugosz, grupa 4, 5 marca 2017, godzina zajec  ;8:30
; Data zaliczenia: 08.08.2017                                                  ;
; Uwagi          : Program znajdujacy najmniejsza liczbe w tablicy            ;
;                                                                             ;
;=============================================================================;

                .MODEL  TINY

Kod             SEGMENT

                ORG    100h														;musi byc 100h
                ASSUME  CS:Kod, DS:Kod, SS:Kod			; chyba zbedne
			
Start:

DL_TABLICA      EQU     12
Tablica         DB      01h, 02h, 00h, 10h, 12h, 33h
                DB      15h, 09h, 11h, 08h, 0Ah, 00h
Najmniejsza     DB      ?

                jmp     Poczatek

Poczatek:
                mov     bx, OFFSET Tablica
                mov     cx, DL_TABLICA		; ilosc elementow tablicy zmnijszane po kazdym przejsciu petli o 1
				
			;	mov 	Najmniejsza, [Tablica]		;	do Najmniejsza wrzuc element zerowy tablicy
				mov		dl, [Tablica]	; do dl wrzuc element zerowy
				xor 		ax, ax	; zerowanie ax
Petla:
                inc 		bx			; bx = bx+1
                mov	al,  byte ptr [ds:bx]	; wrzuc kolejny elem tabnlicy do 
                cmp	dl, al		;	porownaj Najmniejsza z danym elem tablicy
                jge     	Petla		; wykonaj skok jesli wiekrze lub rowne
                mov	dl, al


        loop     Petla

                mov     Najmniejsza, dl

                mov     ax, 4C00h							; ax,4C00h
                int     21h
				
Kod            ENDS

                END Start

