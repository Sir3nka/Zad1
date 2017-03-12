;=============================================================================;
;                                                                             ;
; Plik           : arch1-2e.asm                                               ;
; Format         : EXE                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie programów           ;
;                  asemblerowych                                              ;
; Autorzy        : Przemyslaw Otrembski, Adrian D³ugosz, grupa 2, 5 marca 2017, godzina zajec  ;8:30
; Data zaliczenia: 08.03.2017                                                  ;
; Uwagi          : Program obliczajacy wzor: (3*a-b/a)*(d+3)                  ;
;                                                                             ;
;=============================================================================;

; obliczam ( 60 - 0.5 ) * 8 = 59.5 * 8  = 476
;obliczam w tym programie: d+3=8->d, b/a=0 ->b

                .MODEL SMALL

Dane            SEGMENT
					;deklaracja zmiennych
a               DB     20	; DB Define Byte max  wielkosc  hex 0-255
b               DW      10		; DW - Define Word max wielkosc hex 0-65535
c               EQU     3
d               DW      5
Wynik        DW      ?


Dane ENDS          ; bylo ENDSEG          Dane

Kod             SEGMENT

                ASSUME   CS:Kod, DS:Dane, SS:Stosik

Start:	; poczatek programu ( z :)
; Zaladowanie rejestru segmentowego danych
;mov CEL, ZRODLO. Sluzy do do kopiowania wartosci miedzy pamieciom a rejestrami, lub tylko miedzy rejestrami.

                mov     ax, SEG Dane    ; zaladowanie rejestru DS 
                mov     ds, ax          ; segmentem danych ;czy te dwie linie musza byc? - Tak
							
                mov 	ax, d
				mov	bx, c
				add 	ax, bx	; dodawanie
				mov	d, ax	; d=8  tj d= d+c = 5+3
				
				mov	ax, b
				mov	bl, a		
				div		bl	; dzielenie ax przez bx  czyli 10 / 20
				xor 		ah,ah	; musze wyzerowac reszte z dzieleania (0A)bo jak zostawie
										;dalej przy odejmowaniu mialbym
										;60 - ax czyli 003c - 0a00 wyszlo by f636
										; a jak wyzeruje reszte i zapamietam to bedzie 60-0=60
				mov	wynik, ax	;	w ax jest wynik czyli 0.5 i przenosze do zmiennej wynik
				;mov	b, al  ; reszta trafia do ah  - powinno byc zamiast powyzszej liniii

				mov    al, a	; pod rejestr AX przypisz a , czyli w ax mamy 20
                mov    bl, c	; pod BX przypisz 3
				mul 	bl		;mnozenie. pomnó¿ bl razy ax wynik 60
			; w ax jest 60
				mov	bx, wynik	;	 w wynik mialem wynik poprzedniego dzielenia 10/20 bez reszty
				sub		ax, bx	;odejmowanie  w ax jest wynik 60 
				; tu mam bledny wynik bo po odjeciu mam w ax f636=63030
				;mnozenie   tu mam blad 
				mov bx, d  ; do bx wrzucam 8 - wynik wczeniejsze d+3
				mul		bl			; mnozenie ax razy d czyli 60 razy 8 = 480
				mov	Wynik, ax
				
								; po co nam tu ta nastepna linijka raczej wywalic ja
                mov     ax, WORD PTR Wynik   ; konwertuje  wynik na DW - 16 bajtow?

				; koniec opuszczenie programu  21h to przerwanie DOSowe
                mov     ax, 4C01h  
                int     21h

Kod            ENDS

Stosik          SEGMENT    STACK		; caly segment stos jest tu niepotrzbny chyba

                DB      100h DUP (?)		

Stosik       ENDS

                END     Start

