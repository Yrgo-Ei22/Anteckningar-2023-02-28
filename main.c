/********************************************************************************
* main.c: Demonstration av kombinerat C- och assemblerprogram.
*         En lysdiod LED1 ansluten till pin 8 (PORTB0) blinkar var 100:e ms
*         vid nedtryckning av en tryckknapp BUTTON1 ansluten till pin 13 (PORTB5),
*         �vrig tid h�lls den sl�ckt.
*
*         Samtliga funktioner f�rutom delay_ms implementeras i assembler.
********************************************************************************/
#include "header.h"

/********************************************************************************
* delay_ms: Genererar f�rdr�jning m�tt i millisekunder.
*
*           - delay_time_ms: F�rdr�jningstiden m�tt i millisekunder.
********************************************************************************/
void delay_ms(const uint16_t delay_time_ms)
{
   for (uint16_t i = 0; i < delay_time_ms; ++i)
   {
      _delay_ms(1);
   }
   return;
}

/********************************************************************************
* main: Initierar systemet vid start. Programmet k�rs kontinuerligt s� l�nge
*       matningssp�nning tillf�rs. BUTTON1 pollas (l�ses av) kontinuerligt.
*       Vid nedtryckning blinkar lysdioden var 100:e ms, annars h�lls den sl�ckt.
********************************************************************************/
int main(void)
{
   setup();

   while (1)
   {
      if (button_is_pressed())
      {
         led_blink(100);
      }
      else
      {
         led_off();
      }
   }

   return 0;
}

