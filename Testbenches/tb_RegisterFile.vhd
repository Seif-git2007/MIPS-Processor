library ieee;
use ieee.std_logic_1164.all;

entity tb_RegisterFile is end tb_RegisterFile;

architecture sim of tb_RegisterFile is
  signal read_sel1, read_sel2, write_sel : std_logic_vector(4 downto 0) := (others => '0');
  signal write_ena : std_logic := '0';
  signal clk       : std_logic := '0';
  signal write_data, data1, data2 : std_logic_vector(31 downto 0) := (others => '0');
begin
  uut: entity work.RegisterFile
    port map (read_sel1, read_sel2, write_sel, write_ena, clk, write_data, data1, data2);

  clk <= not clk after 5 ns;   -- rising edges at 5, 15, 25 ns ...

  process
  begin
    -- write 5 into $2
    write_sel <= "00010"; write_data <= x"00000005"; write_ena <= '1';
    wait until rising_edge(clk); wait for 1 ns;
    -- write 12 into $3
    write_sel <= "00011"; write_data <= x"0000000C";
    wait until rising_edge(clk); wait for 1 ns;
    -- read both back at the same time
    write_ena <= '0';
    read_sel1 <= "00010"; read_sel2 <= "00011";
    wait for 1 ns;
    assert data1 = x"00000005" report "$2 wrong" severity error;
    assert data2 = x"0000000C" report "$3 wrong" severity error;
    -- try to write $0: must stay 0
    write_sel <= "00000"; write_data <= x"FFFFFFFF"; write_ena <= '1';
    wait until rising_edge(clk); wait for 1 ns;
    read_sel1 <= "00000"; wait for 1 ns;
    assert data1 = x"00000000" report "$0 was overwritten" severity error;
    -- write_ena = 0: $2 must keep its value
    write_sel <= "00010"; write_data <= x"DEADBEEF"; write_ena <= '0';
    wait until rising_edge(clk); wait for 1 ns;
    read_sel1 <= "00010"; wait for 1 ns;
    assert data1 = x"00000005" report "write happened with ena=0" severity error;
    report "RegisterFile test finished";
    wait;
  end process;
end sim;