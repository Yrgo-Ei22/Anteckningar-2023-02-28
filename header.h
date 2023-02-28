/********************************************************************************
* header.h: Inneh�ller inkluderingsdirektiv, makron och funktionsdeklarationer.
*           En lysdiod LED1 ansluten till pin 8 (PORTB0) blinkar var 100:e
*           ms vid nedtryckning av en tryckknapp BUTTON1 ansluten till pin 13
*           (PORTB5), �vrig tid h�lls den sl�ckt.
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
* setup: S�tter LED1 till utport och aktiverar den interna pullup-resistorn
*        p� tryckknappens pin.
********************************************************************************/
void setup(void);

/********************************************************************************
* button_is_pressed: Indikerar ifall BUTTON1 �r nedtryckt genom att returnera
*                    true eller false.
********************************************************************************/
bool button_is_pressed(void);

/********************************************************************************
* led_blink: Blinkar LED1 med angiven blinkhastighet i millisekunder.
*
*            - blink_speed_ms: Blinkhastigheten m�tt i millisekunder.
********************************************************************************/
void led_blink(const uint16_t blink_speed_ms);

/********************************************************************************
* led_off: Sl�cker LED1.
********************************************************************************/
void led_off(void);

/********************************************************************************
* delay_ms: Genererar f�rdr�jning m�tt i millisekunder.
*
*           - delay_time_ms: F�rdr�jningstiden m�tt i millisekunder.
********************************************************************************/
void delay_ms(const uint16_t delay_time_ms);

#endif /* HEADER_H_ */