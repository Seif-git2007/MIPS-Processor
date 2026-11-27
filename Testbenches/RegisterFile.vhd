library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    port (
        read_sel1  : in  std_logic_vector(4 downto 0);
        read_sel2  : in  std_logic_vector(4 downto 0);
        write_sel  : in  std_logic_vector(4 downto 0);
        write_ena  : in  std_logic;
        clk        : in  std_logic;
        write_data : in  std_logic_vector(31 downto 0);
        data1      : out std_logic_vector(31 downto 0);
        data2      : out std_logic_vector(31 downto 0)
    );
end entity RegisterFile;

architecture behavioral of RegisterFile is
begin
    -- TODO: Implement Register File logic
end architecture behavioral;
