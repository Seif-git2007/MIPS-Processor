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
    type reg_arr is array (0 to 31) of std_logic_vector(31 downto 0);
    signal regs : reg_arr := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if write_ena = '1' and write_sel /= "00000" then
                regs(to_integer(unsigned(write_sel))) <= write_data;
            end if;
        end if;
    end process;

    data1 <= regs(to_integer(unsigned(read_sel1)));
    data2 <= regs(to_integer(unsigned(read_sel2)));
end architecture behavioral;
