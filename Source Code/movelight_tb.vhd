----------------------------------------------------------------------------------
-- Engineer:        Arsal Abbas
-- Description:     movelight test bench
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity movelight_tb is
end movelight_tb;

architecture Behavioral of movelight_tb is
COMPONENT movelight IS	
	PORT ( clk : in std_logic; 
		   btnd : in std_logic;		-- load pattern from switches 
		   btnl : in std_logic;     -- left rotation
		   btnc : in std_logic;		-- stop rotation
		   btnr : in std_logic;		-- right rotaticmdon
		   switches : in std_logic_vector (7 downto 0);
		   leds : out std_logic_vector (7 downto 0) );
END COMPONENT movelight;

SIGNAL clk : std_logic := '0'; 
SIGNAL btnd : std_logic := '0';		 
SIGNAL btnl : std_logic := '0';     
SIGNAL btnc : std_logic := '0';		
SIGNAL btnr : std_logic := '0';
SIGNAL switches : std_logic_vector (7 downto 0) := x"07";
SIGNAL leds : std_logic_vector (7 downto 0) := x"00";
		   
CONSTANT clock_period : time := 10 ns;

begin

	uut : movelight
	PORT MAP ( clk => clk,
			   btnd => btnd,
			   btnl => btnl,
			   btnc => btnc,
			   btnr => btnr,
			   switches => switches,
			   leds => leds );
			   
	clk_p: PROCESS
	BEGIN
		clk <= '0';
		wait for clock_period / 2;
		clk <= '1';
		wait for clock_period / 2;
	END PROCESS clk_p;
	
	stim_p: PROCESS
	BEGIN
		wait for clock_period;
		btnd <= '1';
		wait for clock_period * 3;
		btnd <= '0';
		wait for clock_period;
		btnl <= '1';
		wait for clock_period;
		btnl <= '0';
		wait for clock_period * 12;
		btnc <= '1';
		wait for clock_period;
		btnc <= '0';
		wait for clock_period * 10;
		btnr <= '1';
		wait for clock_period;
		btnr <= '0';
		wait for clock_period *12;
		btnc <= '1';
		wait for clock_period;
		btnc <= '0';
		wait for clock_period * 10;
		report "movelight simulation done.";
		wait;
	END PROCESS stim_p;
end Behavioral;
