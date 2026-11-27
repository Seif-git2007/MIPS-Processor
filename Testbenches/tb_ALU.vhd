library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ALU is
end entity tb_ALU;

architecture sim of tb_ALU is
    -- Signals declaration
    signal data1   : std_logic_vector(31 downto 0) := (others => '0');
    signal data2   : std_logic_vector(31 downto 0) := (others => '0');
    signal aluop   : std_logic_vector(3 downto 0)  := (others => '0');
    signal dataout : std_logic_vector(31 downto 0);
    signal zflag   : std_logic;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.ALU
        port map (
            data1   => data1,
            data2   => data2,
            aluop   => aluop,
            dataout => dataout,
            zflag   => zflag
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- TODO: Implement test cases for AND, OR, ADD, SUB, NOR, SLT
        wait;
    end process;
end architecture sim;
