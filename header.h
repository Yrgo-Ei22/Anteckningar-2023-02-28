/********************************************************************************
* header.h: Innehåller inkluderingsdirektiv, makron och funktionsdeklarationer.
*           En lysdiod LED1 ansluten till pin 8 (PORTB0) blinkar var 100:e
*           ms vid nedtryckning av en tryckknapp BUTTON1 ansluten till pin 13
*           (PORTB5), övrig tid hålls den släckt.
********************************************************************************/
#ifndef HEADER_H_
#define HEADER_H_

/********************************************************************************
* F_CPU: Definierar klockfrekvensen till 16 MHz.
********************************************************************************/
#define F_CPU 16000000UL

/********************************************************************************
* Inkluderingsdirektiv:
********************************************************************************/
#include <avr/io.h> 
#include <util/delay.h>
#include <stdbool.h>

/********************************************************************************
* setup: Sätter LED1 till utport och aktiverar den interna pullup-resistorn
*        på tryckknappens pin.
********************************************************************************/
void setup(void);

/********************************************************************************
* button_is_pressed: Indikerar ifall BUTTON1 är nedtryckt genom att returnera
*                    true eller false.
********************************************************************************/
bool button_is_pressed(void);

/********************************************************************************
* led_blink: Blinkar LED1 med angiven blinkhastighet i millisekunder.
*
*            - blink_speed_ms: Blinkhastigheten mätt i millisekunder.
********************************************************************************/
void led_blink(const uint16_t blink_speed_ms);

/********************************************************************************
* led_off: Släcker LED1.
********************************************************************************/
void led_off(void);

/********************************************************************************
* delay_ms: Genererar fördröjning mätt i millisekunder.
*
*           - delay_time_ms: Fördröjningstiden mätt i millisekunder.
********************************************************************************/
void delay_ms(const uint16_t delay_time_ms);

#endif /* HEADER_H_ */