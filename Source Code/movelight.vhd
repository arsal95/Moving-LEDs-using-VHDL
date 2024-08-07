----------------------------------------------------------------------------------
-- Engineer:        Arsal Abbas
-- Create Date: 	25-MAY-2022
-- Description: 	movelight - Behavioral
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity movelight is
	PORT ( clk : in std_logic; 
		   btnd : in std_logic;		-- load pattern from switches 
		   btnl : in std_logic;     -- left rotation
		   btnc : in std_logic;		-- stop rotation
		   btnr : in std_logic;		-- right rotation
		   switches : in std_logic_vector (7 downto 0);
		   leds : out std_logic_vector (7 downto 0) );
end movelight;

architecture Behavioral of movelight is
CONSTANT MAX_COUNT : INTEGER := 3;
SUBTYPE Count_type IS INTEGER RANGE 0 to MAX_COUNT-1;

SIGNAL led_reg : std_logic_vector (7 downto 0);
SIGNAL mv_left : std_logic := '0';
SIGNAL mv_right : std_logic := '0';
SIGNAL r_pulse : std_logic;

begin
	leds <= led_reg;
	
	-- speed of rotation
	count_p: PROCESS(clk)
	VARIABLE cnt : Count_type := MAX_COUNT-1;
	BEGIN
		IF rising_edge(clk) THEN
			r_pulse <= '0';
			IF cnt = 0 THEN
				r_pulse <= '1';
				cnt := MAX_COUNT-1;
			ELSE
				cnt := cnt -1;
			END IF;		
		END IF;
	END PROCESS count_p;
	
	-- mode of operation (left - right -stop)
	mvlogic: PROCESS(clk)
	BEGIN
		IF rising_edge(clk) THEN
			IF btnl='1' THEN
				mv_left <= '1';
				mv_right <= '0';
			ELSIF btnr='1' THEN
				mv_left <= '0';
				mv_right <= '1';
			ELSIF btnc='1' THEN
				mv_left <= '0';
				mv_right <= '0';
			END IF;
		END IF;
	END PROCESS mvlogic;
	
	-- push button storage and rotation handling
	lr_rot: PROCESS(clk)
	BEGIN
		IF rising_edge (clk) THEN
			IF r_pulse='1' THEN
				IF btnd='1' THEN
					led_reg <= switches;
					ELSIF mv_left='1' THEN
					led_reg <= led_reg(6 downto 0) & led_reg(7);
					ELSIF mv_right='1' THEN
					led_reg <= led_reg(0) & led_reg(7 downto 1);
					END IF;
				END IF;
			END IF;		
	END PROCESS lr_rot;
end Behavioral;
