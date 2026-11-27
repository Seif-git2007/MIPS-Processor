library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_datapath is
end entity tb_datapath;

architecture sim of tb_datapath is
    -- Signals declaration
    signal clk          : std_logic := '0';
    signal reset        : std_logic := '0';
    signal instr        : std_logic_vector(31 downto 0) := (others => '0');
    signal aluoperation : std_logic_vector(3 downto 0)  := (others => '0');
    signal zero         : std_logic;
    signal regwrite     : std_logic := '0';
    signal aluout       : std_logic_vector(31 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.datapath
        port map (
            clk          => clk,
            reset        => reset,
            instr        => instr,
            aluoperation => aluoperation,
            zero         => zero,
            regwrite     => regwrite,
            aluout       => aluout
        );

    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- TODO: Implement test cases for R-type instructions
        wait;
    end process;
end architecture sim;
