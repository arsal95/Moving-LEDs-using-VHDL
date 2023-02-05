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
