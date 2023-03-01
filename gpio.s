/********************************************************************************
* gpio.h: Inneh�ller subrutiner f�r GPIO-implementering.
********************************************************************************/

/********************************************************************************
* __SFR_OFFSET: Tar bort offset mellan I/O-adresser och dataadresser. D�rmed
*               l�ses PORTB som 0x25, inte 0x05. Om vi inte hade gjort detta
*               hade OUT och IN inte fungerat, d� vi hade skrivit fel.
*               Notera tv� understreck framf�r SFR (Special Function Register).
*               Offseten �r normalt 0x20, vi s�tter den till 0.
********************************************************************************/
#define __SFR_OFFSET 0 

;/********************************************************************************
;* Inkluderingsdirektiv: Inkludera enbart assemblerkompatibla bibliotek.
;*                       I praktiken beh�vs enbart avr/io.h s� att vi f�r
;*                       information om PORTB, DDRB med mera. Ta bort offset
;*                       mellan I/O-adresser och dataadresser med makrot 
;*                       __SFR_OFFSET innan ni inkluderar avr/io.h
;********************************************************************************/
#include <avr/io.h>

;/********************************************************************************
;* Makrodefinitioner:
;*                    Notering: Anv�nd #define i st�llet f�r .EQU n�r vi k�r 
;*                              kombinerad C och assembler.
;*                              Skriv inga inline-kommentarer p� makron!
;********************************************************************************/
#define LED1    PORTB0
#define BUTTON1 PORTB5 

;/********************************************************************************
;* Globala subrutiner (synliga utanf�r filen, kan anropas fr�n C-filer):
;********************************************************************************/
.GLOBAL setup
.GLOBAL button_is_pressed
.GLOBAL led_blink
.GLOBAL led_off

;/********************************************************************************
;* Externa subrutiner (ligger utanf�r filen, men ska kunna anropas h�rifr�n).
;********************************************************************************/
.EXTERN delay_ms

;/********************************************************************************
;* setup: S�tter LED1 till utport och aktiverar den interna pullup-resistorn
;*        p� tryckknappens pin.
;********************************************************************************/
setup:
   LDI R16, (1 << LED1)
   OUT DDRB, R16
   LDI R17, (1 << BUTTON1)
   OUT PORTB, R17
   RET

;/********************************************************************************
;* button_is_pressed: Indikerar ifall BUTTON1 �r nedtryckt genom att returnera
;*                    1 eller 0 via R24 (kompilatorn anv�nder alltid R24
;*                    f�r returv�rden och vid behov R25).
;********************************************************************************/
button_is_pressed:
   IN R24, PINB
   ANDI R24, (1 << BUTTON1)
   BRNE button_is_pressed_return_1 
button_is_pressed_return_0:
   RET 
button_is_pressed_return_1:
   LDI R24, 0x01
   RET

;/********************************************************************************
;* led_blink: Blinkar LED1 med angiven blinkhastighet i millisekunder.
;*
;*            - R25:R24: Blinkhastigheten m�tt i millisekunder.
;********************************************************************************/
led_blink:
   RCALL led_on 
   RCALL delay_ms 
   RCALL led_off
   RCALL delay_ms
   RET

;/********************************************************************************
;* led_off: Sl�cker LED1.
;********************************************************************************/
led_off:
   IN R16, PORTB 
   ANDI R16, ~(1 << LED1) 
   OUT PORTB, R16
   RET

;/********************************************************************************
;* led_on: T�nder LED1.
;********************************************************************************/
led_on:
   IN R16, PORTB
   ORI R16, (1 << LED1)
   OUT PORTB, R16
   RET