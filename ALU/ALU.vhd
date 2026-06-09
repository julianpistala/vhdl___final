library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        A       : in  std_logic_vector(7 downto 0);
        B       : in  std_logic_vector(7 downto 0);
        ALU_Sel : in  std_logic_vector(2 downto 0);
        Result  : out std_logic_vector(7 downto 0);
        NZVC    : out std_logic_vector(3 downto 0)
    );
end entity ALU;

architecture behavioral of ALU is
begin

    ALU_PROCESS : process (A, B, ALU_Sel)

        variable Sum_uns : unsigned(8 downto 0);

    begin

        Result  <= (others => '0');
        NZVC    <= (others => '0');
        Sum_uns := (others => '0');

        if (ALU_Sel = "000") then

            Sum_uns := unsigned('0' & A) + unsigned('0' & B);
            Result  <= std_logic_vector(Sum_uns(7 downto 0));

            NZVC(3) <= Sum_uns(7);

            if (Sum_uns(7 downto 0) = x"00") then
                NZVC(2) <= '1';
            else
                NZVC(2) <= '0';
            end if;

            if ((A(7)='0' and B(7)='0' and Sum_uns(7)='1') or
                (A(7)='1' and B(7)='1' and Sum_uns(7)='0')) then
                NZVC(1) <= '1';
            else
                NZVC(1) <= '0';
            end if;

            NZVC(0) <= Sum_uns(8);

        elsif (ALU_Sel = "001") then

            Sum_uns := unsigned('0' & A) + unsigned('0' & (not B)) + 1;
            Result  <= std_logic_vector(Sum_uns(7 downto 0));

            NZVC(3) <= Sum_uns(7);

            if (Sum_uns(7 downto 0) = x"00") then
                NZVC(2) <= '1';
            else
                NZVC(2) <= '0';
            end if;

            if ((A(7)='0' and B(7)='1' and Sum_uns(7)='1') or
                (A(7)='1' and B(7)='0' and Sum_uns(7)='0')) then
                NZVC(1) <= '1';
            else
                NZVC(1) <= '0';
            end if;

            NZVC(0) <= Sum_uns(8);

        else

            Result <= (others => '0');
            NZVC   <= (others => '0');

        end if;

    end process ALU_PROCESS;

end architecture behavioral;

