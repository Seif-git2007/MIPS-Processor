library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port (
        data1   : in  std_logic_vector(31 downto 0);
        data2   : in  std_logic_vector(31 downto 0);
        aluop   : in  std_logic_vector(3 downto 0);
        dataout : out std_logic_vector(31 downto 0);
        zflag   : out std_logic
    );
end entity ALU;

architecture behavioral of ALU is
begin
    -- TODO: Implement ALU logic
end architecture behavioral;
