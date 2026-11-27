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
    signal src1, src2, alu_result : std_logic_vector(31 downto 0);

begin
    RF : entity work.RegisterFile
        port map(
            read_sel1  => instr(25 downto 21),
            read_sel2  => instr(20 downto 16),
            write_sel  => instr(15 downto 11),
            write_ena  => regwrite,
            clk        => clk,
            write_data => alu_result,
            data1      => src1,
            data2      => src2
        )
    ALU : entity work.ALU
        port map(
            data1   => src1,
            data2   => src2,
            aluop   => aluoperation,
            dataout => alu_result,
            zflag   => zero
        );
    
    aluout <= alu_result;
end architecture structural;