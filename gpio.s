/********************************************************************************
* gpio.h: Innehåller subrutiner för GPIO-implementering.
********************************************************************************/

/********************************************************************************
* __SFR_OFFSET: Tar bort offset mellan I/O-adresser och dataadresser. Därmed
*               läses PORTB som 0x25, inte 0x05. Om vi inte hade gjort detta
*               hade OUT och IN inte fungerat, då vi hade skrivit fel.
*               Notera två understreck framför SFR (Special Function Register).
*               Offseten är normalt 0x20, vi sätter den till 0.
********************************************************************************/
#define __SFR_OFFSET 0 

;/********************************************************************************
;* Inkluderingsdirektiv: Inkludera enbart assemblerkompatibla bibliotek.
;*                       I praktiken behövs enbart avr/io.h så att vi får
;*                       information om PORTB, DDRB med mera. Ta bort offset
;*                       mellan I/O-adresser och dataadresser med makrot 
;*                       __SFR_OFFSET innan ni inkluderar avr/io.h
;********************************************************************************/
#include <avr/io.h>

;/********************************************************************************
;* Makrodefinitioner:
;*                    Notering: Använd #define i stället för .EQU när vi kör 
;*                              kombinerad C och assembler.
;*                              Skriv inga inline-kommentarer på makron!
;********************************************************************************/
#define LED1    PORTB0
#define BUTTON1 PORTB5 

;/********************************************************************************
;* Globala subrutiner (synliga utanför filen, kan anropas från C-filer):
;********************************************************************************/
.GLOBAL setup
.GLOBAL button_is_pressed
.GLOBAL led_blink
.GLOBAL led_off

;/********************************************************************************
;* Externa subrutiner (ligger utanför filen, men ska kunna anropas härifrån).
;********************************************************************************/
.EXTERN delay_ms

;/********************************************************************************
;* setup: Sätter LED1 till utport och aktiverar den interna pullup-resistorn
;*        på tryckknappens pin.
;********************************************************************************/
setup:
   LDI R16, (1 << LED1)
   OUT DDRB, R16
   LDI R17, (1 << BUTTON1)
   OUT PORTB, R17
   RET

;/********************************************************************************
;* button_is_pressed: Indikerar ifall BUTTON1 är nedtryckt genom att returnera
;*                    1 eller 0 via R24 (kompilatorn använder alltid R24
;*                    för returvärden och vid behov R25).
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
;*            - R25:R24: Blinkhastigheten mätt i millisekunder.
;********************************************************************************/
led_blink:
   RCALL led_on 
   RCALL delay_ms 
   RCALL led_off
   RCALL delay_ms
   RET

;/********************************************************************************
;* led_off: Släcker LED1.
;********************************************************************************/
led_off:
   IN R16, PORTB 
   ANDI R16, ~(1 << LED1) 
   OUT PORTB, R16
   RET

;/********************************************************************************
;* led_on: Tänder LED1.
;********************************************************************************/
led_on:
   IN R16, PORTB
   ORI R16, (1 << LED1)
   OUT PORTB, R16
   RET