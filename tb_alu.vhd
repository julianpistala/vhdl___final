library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end entity tb_alu;

architecture behavioral of tb_alu is

    component ALU
        port (
            A       : in  std_logic_vector(7 downto 0);
            B       : in  std_logic_vector(7 downto 0);
            ALU_Sel : in  std_logic_vector(2 downto 0);
            Result  : out std_logic_vector(7 downto 0);
            NZVC    : out std_logic_vector(3 downto 0)
        );
    end component;

    signal A       : std_logic_vector(7 downto 0) := (others => '0');
    signal B       : std_logic_vector(7 downto 0) := (others => '0');
    signal ALU_Sel : std_logic_vector(2 downto 0) := (others => '0');
    signal Result  : std_logic_vector(7 downto 0);
    signal NZVC    : std_logic_vector(3 downto 0);

begin

    DUT : ALU
        port map (
            A       => A,
            B       => B,
            ALU_Sel => ALU_Sel,
            Result  => Result,
            NZVC    => NZVC
        );

    STIMULUS : process
    begin

        ALU_Sel <= "000";

        A <= x"2D";
        B <= x"1B";
        wait for 20 ns;

        A <= x"56";
        B <= x"45";
        wait for 20 ns;

        A <= x"D8";
        B <= x"A4";
        wait for 20 ns;

        A <= x"BE";
        B <= x"C7";
        wait for 20 ns;

        A <= x"80";
        B <= x"80";
        wait for 20 ns;

        A <= x"90";
        B <= x"70";
        wait for 20 ns;

        ALU_Sel <= "001";

        A <= x"4F";
        B <= x"22";
        wait for 20 ns;

        A <= x"3A";
        B <= x"6D";
        wait for 20 ns;

        A <= x"A5";
        B <= x"A5";
        wait for 20 ns;

        A <= x"73";
        B <= x"D8";
        wait for 20 ns;

        A <= x"8A";
        B <= x"32";
        wait for 20 ns;

        ALU_Sel <= "111";
        A <= x"17";
        B <= x"5E";
        wait for 20 ns;

        wait;

    end process STIMULUS;

end architecture behavioral;

