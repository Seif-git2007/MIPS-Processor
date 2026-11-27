library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    port (
        clk          : in     std_logic;
        reset        : in     std_logic;
        instr        : in     std_logic_vector(31 downto 0);
        aluoperation : in     std_logic_vector(3 downto 0);
        zero         : out    std_logic;
        regwrite     : in     std_logic;
        aluout       : buffer std_logic_vector(31 downto 0)
    );
end entity datapath;

architecture structural of datapath is
    -- TODO: Declare internal signals and components (RegisterFile, ALU)
begin
    -- TODO: Instantiate and wire RegisterFile and ALU
end architecture structural;
