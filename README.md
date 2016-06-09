# proy_2_grupo_4_sem_1_2016
Proyecto2: Lectura RTC y mostrar los datos en VGA con numeros generados con ROM
El codigo esta desordenado con muchos modulos. Para comprender el funcionamiento básico revisar los modulos de:
  1. vga640x480: se encarga de mostrar las imágenes en la VGA, ademas de los pulsos de control para la VGA
  2. FSM: es la maquina de estados que se encarga de generar la secuencia de AD, RD, CS, WR para controlar la lectura y escritura del RTC
  3. Control_IO: se encarga del control de los puertos bidireccionales que comunican la VGA con el RTC, estos son:
      AD
      WR
      CS
      AD
      [7:0]dato_rtc)
  4. Char_RAM: el nombre es incorrecto, es una ROM. Es la memoria que tiene los bitmaps de los numeros que consulta el
     modulo vga640x480 para encender los pixeles necesarios en la pantalla.

Los demás módulos son contadores (especialmente para almacenar los datos ingresados por el usuario), divisores de clk y decodificadores.
La escritura al RTC de los datos deseados por el usuario NO se implementó en este proyecto.
