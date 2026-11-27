library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_datapath is
end entity tb_datapath;

architecture sim of tb_datapath is
    signal clk          : std_logic := '0';
    signal reset        : std_logic := '0';
    signal instr        : std_logic_vector(31 downto 0) := (others => '0');
    signal aluoperation : std_logic_vector(3 downto 0)  := (others => '0');
    signal zero         : std_logic;
    signal regwrite     : std_logic := '0';
    signal aluout       : std_logic_vector(31 downto 0);
    signal sim_done     : boolean   := false;

    constant clk_period : time := 10 ns;
begin
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

    -- Clock process stops automatically when simulation finishes
    clk_process: process
    begin
        while not sim_done loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    stim_proc: process
    begin
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period;

        -- nor $1, $0, $0 (0x00000827)
        instr        <= x"00000827";
        aluoperation <= "1100";
        regwrite     <= '1';
        wait for clk_period;

        -- sub $2, $0, $1 (0x00011022)
        instr        <= x"00011022";
        aluoperation <= "0110";
        regwrite     <= '1';
        wait for clk_period;

        -- add $3, $2, $2 (0x00421820)
        instr        <= x"00421820";
        aluoperation <= "0010";
        regwrite     <= '1';
        wait for clk_period;

        -- or $4, $3, $2 (0x00622025)
        instr        <= x"00622025";
        aluoperation <= "0001";
        regwrite     <= '1';
        wait for clk_period;

        -- and $5, $4, $2 (0x00822824)
        instr        <= x"00822824";
        aluoperation <= "0000";
        regwrite     <= '1';
        wait for clk_period;

        -- slt $6, $2, $3 (0x0043302A)
        instr        <= x"0043302A";
        aluoperation <= "0111";
        regwrite     <= '1';
        wait for clk_period;

        -- sub $7, $3, $3 (0x00633822)
        instr        <= x"00633822";
        aluoperation <= "0110";
        regwrite     <= '1';
        wait for clk_period;

        regwrite <= '0';
        sim_done <= true; -- Terminates the clock and stops the simulation cleanly!
        wait;
    end process;
end architecture sim;
