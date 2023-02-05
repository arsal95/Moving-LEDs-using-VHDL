# Moving-LEDs-using-VHDL

## Introduction:
The objective of this lab is to develop a VHDL program that can move or rotates the series of 8 LEDs in the left and right direction for a given pattern defined by the user through toggle switches. LEDs value is loading from Switches and also holding the previous input. Switches are connected to LEDs directly. Clock speed is needed to be reduced, so that physical blinking LEDs can be observed, to achieve this define a new counter which acts clock with reduced speed. All modes have to be verified by simulation.

The user defines the pattern by toggling any of the switches numbered from 0 to 7, connected parallel to their paired LEDs. This design also contains 4 push buttons to perform 4 different operations on these LEDs. Upon pressing btnd the pattern is loaded. If btnl is pressed the LEDs indicate the pattern moving to the left. If btnr is pressed the LEDs indicate the pattern moving to the right. Btnc is used to stop the rotation.

## Algorithm Description:

### Library:
* Using the “use” statement, all components of the package “STD_LOGIC_1164” part of library IEEE are visible for later use in the VHDL code. “Library” statement is included above the “use” statement so that compiler would know that “IEEE” is a library.
* VHDL datatype “STD_LOGIC” and rising_edge () is declared in IEEE.STD_LOGIC_1164.

### Entity:
Entity declaration represents the external interface to the design entity. Entity statement declares the design name; here it is “movelight”. This interface consists of the following input and output ports:

**System Inputs:**
* clk - system clock signal
* switches - 8 slide switches [will be a std_logic_vector (7 downto 0)]
* btnd - pushbutton (down): Load a new pattern from the switches
* btnl - pushbutton (left): rotate to the left
* btnc - pushbutton (center): stop rotation
* btnr - pushbutton (right): rotate to the right

**System Output:**
* leds - 8 leds [will be a std_logic_vector (7 downto 0)]

## Architecture:
* Architecture is a description of the inner design operation.
* The Architecture “Behavioral” is assigned to the entity “movelight” using the keyword “of”, such that the port definitions are visible to the architecture.
* Constant named “Max_count” is defined and assigned a value of 3 ”, sub_type of integer named “Count_type” is defined and assigned a range of “0 to Max_count-1”.
* Max_count is used to define the speed of the r_pulse.
* 3 signals named mv_left, mv_right, and r_pulse are defined of the type standard logic, Signal led_reg is defined as a standard logic vector with 8 bits. Signal led_reg acts as a memory device (register) to load the pattern from the switches when the appropriate button is pressed (btnd) and outputted to the LEDs.
* Furthermore, 3 processes named count_p, mvlogic, and lr_rot are defined.
* All processes take (clk) as a sensitivity list because all processes are time-dependent there is a need that all processes to be synchronized.
* In the process “count_p” the objective is to generate a repeating pulse named r_pulse, this is done to set the speed of the rotating LEDs. The process count_p is defined such that it sets a HIGH bit for r_pulse for after every 3 clock cycles and the HIGH BIT lasts 1 clock cycle.
* In the process “mvlogic” on every clock cycle, three conditions check the state of btnl, btnr and btnc, if btnl == 1 then mv_left == 1, if btnr = 1 then mv_right = 1, if btnc is pressed then both mv_left and mv_left are assigned 0.
* The process “lr_rot” is defined to implement the left and right rotation.

**Left Rotation:** The led register is assigned by concatenating bits from 6 to 0 and MSB bit 7. So, at each iteration due to this assignment provided that mv_left = ‘1’, the pattern is rotated to the left direction.

| *led_reg <= led_reg(6 downto 0) & led_reg(7);* |

**Right Rotation:** The led register is assigned by concatenating LSB bit 0 and bits 7 to 1. So, at each iteration due to this assignment provided that mv_right = ‘1’, the pattern is rotated to the right direction.
