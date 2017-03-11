;=============================================================================;
;                                                                             ;
; Plik           : arch1-2e.asm                                               ;
; Format         : EXE                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie programów           ;
;                  asemblerowych                                              ;
; Autorzy        : Przemyslaw Otrembski, Adrian D³ugosz, grupa 4, 5 marca 2017, godzina zajec  ;8:30
; Data zaliczenia: 08.08.2017                                                  ;
; Uwagi          : Program obliczajacy wzor: (3*a-b/a)*(d+3)                  ;
;                                                                             ;
;=============================================================================;

; obliczam ( 60 - 0.5 ) * 8 = 59.5 * 8  = 476
;obliczam w tym programie: d+3=8->d, b/a=0 ->b

                .MODEL SMALL

Dane            SEGMENT

a               DW      20	; DB Define Byte max  wielkosc  hex 0-255
b               DW      10		; DW - Define Word max wielkosc hex 0-65535
c               EQU     3
d               DW      5
Wynik        DW      ?
; num DWORD	0		; do tego word na koncu

Dane ENDS          ; bylo ENDSEG          Dane

Kod             SEGMENT

                ASSUME   CS:Kod, DS:Dane, SS:Stosik

Start:	; poczatek programu ( z :)
; Zaladowanie rejestru segmentowego danych
;mov CEL, ZRODLO. Sluzy do do kopiowania wartosci miedzy pamieciom a rejestrami, lub tylko miedzy rejestrami.

		;deklaracja danych
                mov     ax, SEG Dane    ; zaladowanie rejestru DS  ;czy te dwie linie musza byc?
                mov     ds, ax          ; segmentem danych
							
                mov 	ax, d
				mov	bx, c
				add 	ax, bx	; dodawanie
				mov	d, ax	; d=8  tj d= d+c = 5+3
				
				mov	ax, b
				mov	bx, a		
				div		bx	; dzielenie ax przez bx  czyli 10 / 20
				mov	b, ax	;	w ax jest wynik czyli 0.5 i przenosze do b, chyba powinno byc: 
				;mov	b, al  ; reszta trfia do ah  - powinno byc zamiast powyzszej liniii
		
; od teraz zle bo wynik mamy 0 w al i reszte czyli 5( raczej 10) w ah
;czyli calosc jest w ax a reszta jest w dx		gdy uzyje div a przy mul chyba dobrze

				mov    ax, a	; pod rejestr AX przypisz a , czyli w ax mamy 20
                mov    bx, c	; pod BX przypisz 3
				mul 	bx		;mnozenie. pomnó¿ bx razy ax
			; w ax jest 60
				mov	bx, b
				sub		ax, bx	;odejmowanie  w ax jest wynik 60 - 0.5 czyli 59,5
				
				;mnozenie
				mul		d			; mnozenie ax razy d czyli 59.5 rszy 8 = 476
				mov	Wynik, ax
				

                mov     ax, WORD PTR Wynik

				; koniec opuszczenie programu  21h to przerwanie DOSowe
                mov     ax, 4C01h  ; chyba 4c01h
                int     21h

Kod            ENDS

Stosik          SEGMENT    STACK

                DB      100h DUP (?)

Stosik       ENDS

                END     Start

