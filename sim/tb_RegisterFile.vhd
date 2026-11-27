library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_RegisterFile is
end entity tb_RegisterFile;

architecture sim of tb_RegisterFile is
    -- Signals declaration
    signal clk        : std_logic := '0';
    signal write_ena  : std_logic := '0';
    signal read_sel1  : std_logic_vector(4 downto 0) := (others => '0');
    signal read_sel2  : std_logic_vector(4 downto 0) := (others => '0');
    signal write_sel  : std_logic_vector(4 downto 0) := (others => '0');
    signal write_data : std_logic_vector(31 downto 0) := (others => '0');
    signal data1      : std_logic_vector(31 downto 0);
    signal data2      : std_logic_vector(31 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.RegisterFile
        port map (
            read_sel1  => read_sel1,
            read_sel2  => read_sel2,
            write_sel  => write_sel,
            write_ena  => write_ena,
            clk        => clk,
            write_data => write_data,
            data1      => data1,
            data2      => data2
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
        -- TODO: Implement test cases
        wait;
    end process;
end architecture sim;
