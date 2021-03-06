;;=============================================================================;
;                                                                             ;
; Plik           : arch1-2c.asm                                               ;
; Format         : COM                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie program�w           ;
;                  asemblerowych                                              ;
; Autorzy        : Przemyslaw Otrembski, Adrian D�ugosz, grupa 2, 5 marca 2017, godzina zajec  ;8:30
; Data zaliczenia: 12.03.2017                                                  ;
; Uwagi          : Program znajdujacy najmniejsza liczbe w tablicy            ;
;                                                                             ;
;=============================================================================;

                .MODEL  TINY

Kod             SEGMENT

                ORG    100h														;musi byc  w plikach .com
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
                mov	al,  byte ptr [bx]	; wrzuc kolejny elem tabnlicy do - chyba al,[dx]
                cmp	dl, al		;	porownaj Najmniejsza z danym elem tablicy
										; por�wnuje cel ze zr�d�em
                jl     	Petla		; wykonaj skok gdy mniejsze
                mov	dl, al	; do dl wrzucam najmniejsza wartosc


        loop     Petla

                mov     Najmniejsza, dl

                mov     ax, 4C00h							; ax,4C00h
                int     21h
				
Kod            ENDS

                END Start

