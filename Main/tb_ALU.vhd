library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ALU is
end entity tb_ALU;

architecture sim of tb_ALU is
    signal data1   : std_logic_vector(31 downto 0) := (others => '0');
    signal data2   : std_logic_vector(31 downto 0) := (others => '0');
    signal aluop   : std_logic_vector(3 downto 0)  := (others => '0');
    signal dataout : std_logic_vector(31 downto 0);
    signal zflag   : std_logic;

    constant OP_AND : std_logic_vector(3 downto 0) := "0000";
    constant OP_OR  : std_logic_vector(3 downto 0) := "0001";
    constant OP_ADD : std_logic_vector(3 downto 0) := "0010";
    constant OP_SUB : std_logic_vector(3 downto 0) := "0110";
    constant OP_NOR : std_logic_vector(3 downto 0) := "1100";
    constant OP_SLT : std_logic_vector(3 downto 0) := "0111";
begin
    uut: entity work.ALU
        port map (
            data1   => data1,
            data2   => data2,
            aluop   => aluop,
            dataout => dataout,
            zflag   => zflag
        );

    stim_proc: process
        variable fail_count : integer := 0;
        variable test_count : integer := 0;

        procedure check_alu(
            constant name     : in string;
            constant op       : in std_logic_vector(3 downto 0);
            constant a        : in std_logic_vector(31 downto 0);
            constant b        : in std_logic_vector(31 downto 0);
            constant exp_out  : in std_logic_vector(31 downto 0);
            constant exp_zero : in std_logic
        ) is
        begin
            test_count := test_count + 1;
            aluop <= op;
            data1 <= a;
            data2 <= b;
            wait for 10 ns;

            if dataout /= exp_out or zflag /= exp_zero then
                fail_count := fail_count + 1;
                report "FAIL [" & name & "]" severity error;
            else
                report "PASS [" & name & "]" severity note;
            end if;
        end procedure check_alu;
    begin
        -- AND
        check_alu("AND basic",          OP_AND, x"F0F00F0F", x"0FF0FF00", x"00F00F00", '0');
        check_alu("AND all ones",       OP_AND, x"FFFFFFFF", x"FFFFFFFF", x"FFFFFFFF", '0');
        check_alu("AND disjoint zero",  OP_AND, x"AAAAAAAA", x"55555555", x"00000000", '1');

        -- OR
        check_alu("OR basic",           OP_OR,  x"F000000F", x"0FF000F0", x"FFF000FF", '0');
        check_alu("OR zero zero",       OP_OR,  x"00000000", x"00000000", x"00000000", '1');

        -- ADD
        check_alu("ADD 5 + 3",          OP_ADD, x"00000005", x"00000003", x"00000008", '0');
        check_alu("ADD 5 + (-3)",       OP_ADD, x"00000005", x"FFFFFFFD", x"00000002", '0');
        check_alu("ADD 5 + (-5) zero",  OP_ADD, x"00000005", x"FFFFFFFB", x"00000000", '1');

        -- SUB
        check_alu("SUB 10 - 4",         OP_SUB, x"0000000A", x"00000004", x"00000006", '0');
        check_alu("SUB 4 - 10",         OP_SUB, x"00000004", x"0000000A", x"FFFFFFFA", '0');
        check_alu("SUB A - A zero",     OP_SUB, x"12345678", x"12345678", x"00000000", '1');

        -- NOR
        check_alu("NOR 0 nor 0",        OP_NOR, x"00000000", x"00000000", x"FFFFFFFF", '0');
        check_alu("NOR complementary",  OP_NOR, x"0000FFFF", x"FFFF0000", x"00000000", '1');
        check_alu("NOR FFFFFFFF nor 0", OP_NOR, x"FFFFFFFF", x"00000000", x"00000000", '1');

        -- SLT 
        check_alu("SLT 3 < 5",          OP_SLT, x"00000003", x"00000005", x"00000001", '0');
        check_alu("SLT 5 < 3",          OP_SLT, x"00000005", x"00000003", x"00000000", '1');
        check_alu("SLT -5 < -2",        OP_SLT, x"FFFFFFFB", x"FFFFFFFE", x"00000001", '0');
        check_alu("SLT -2 < 5",         OP_SLT, x"FFFFFFFE", x"00000005", x"00000001", '0');
        check_alu("SLT 5 < -2",         OP_SLT, x"00000005", x"FFFFFFFE", x"00000000", '1');
        check_alu("SLT 5 < 5 equal",    OP_SLT, x"00000005", x"00000005", x"00000000", '1');

        check_alu("SLT INT_MIN < +1",      OP_SLT, x"80000000", x"00000001", x"00000001", '0');
        check_alu("SLT INT_MAX < -1",      OP_SLT, x"7FFFFFFF", x"FFFFFFFF", x"00000000", '1');
        check_alu("SLT INT_MIN < INT_MAX", OP_SLT, x"80000000", x"7FFFFFFF", x"00000001", '0');
        check_alu("SLT INT_MAX < INT_MIN", OP_SLT, x"7FFFFFFF", x"80000000", x"00000000", '1');
        check_alu("SLT INT_MIN < INT_MIN", OP_SLT, x"80000000", x"80000000", x"00000000", '1');

        check_alu("ADD -1 + 1 wrap",       OP_ADD, x"FFFFFFFF", x"00000001", x"00000000", '1');
        check_alu("ADD INT_MAX + 1 wrap",  OP_ADD, x"7FFFFFFF", x"00000001", x"80000000", '0');
        check_alu("SUB 0 - 1 wrap",        OP_SUB, x"00000000", x"00000001", x"FFFFFFFF", '0');
        check_alu("SUB INT_MIN - 1 wrap",  OP_SUB, x"80000000", x"00000001", x"7FFFFFFF", '0');


        wait;
    end process;
end architecture sim;
