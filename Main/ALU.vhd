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
    signal d1, d2, s : std_logic_vector(31 downto 0);
    signal c         : unsigned(32 downto 0);
    signal temp      : unsigned(32 downto 0);

begin
    d1   <= not data1 when aluop(3) = '1' else data1;
    d2   <= not data2 when aluop(2) = '1' else data2;
    c    <= (0 => aluop(2), others => '0');

    -- Sign-extend to 33 bits so signed subtraction (A - B) never overflows
    temp <= unsigned(d1(31) & d1) + unsigned(d2(31) & d2) + c;

    s <= d1 and d2 when aluop(1 downto 0) = "00" else
         d1 or d2  when aluop(1 downto 0) = "01" else
         std_logic_vector(temp(31 downto 0)) when aluop(1 downto 0) = "10" else
         (0 => temp(32), others => '0');

    dataout <= s;
    zflag   <= '1' when s = x"00000000" else '0';

    
        
    
    







end architecture behavioral;
