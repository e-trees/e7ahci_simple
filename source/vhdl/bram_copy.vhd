library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bram_copy is

  port (
    clk : in std_logic;
    reset : in std_logic;

    addr0 : out std_logic_vector(31 downto 0);
    dout0 : out std_logic_vector(511 downto 0);
    din0  : in  std_logic_vector(511 downto 0);
    we0   : out std_logic;
    oe0   : out std_logic;

    addr1 : out std_logic_vector(31 downto 0);
    dout1 : out std_logic_vector(511 downto 0);
    din1  : in  std_logic_vector(511 downto 0);
    we1   : out std_logic;
    oe1   : out std_logic;

    copy_0_to_1 : in std_logic;
    copy_1_to_0 : in std_logic;
    copy_num    : in std_logic_vector(31 downto 0);

    kick : in  std_logic;
    busy : out std_logic
    );
  
end bram_copy;

architecture RTL of bram_copy is

  signal kick_d : std_logic := '0';

  signal num_reg : unsigned(31 downto 0) := (others => '0');
  signal dir_reg : std_logic := '0';

  signal busy_reg : std_logic := '0';
  
  signal waddr   : unsigned(31 downto 0);
  signal waddr_d : unsigned(31 downto 0);
  signal raddr   : unsigned(31 downto 0);

  type stateType is (IDLE, BRAM_WAIT, DO_COPY, DO_END);
  signal state : stateType := IDLE;
  
begin
  
  process(clk)
  begin
    if clk'event and clk = '1' then
      kick_d <= kick;
    end if;
  end process;

  busy <= busy_reg or kick;

  addr0 <= std_logic_vector(raddr) when dir_reg = '0' else std_logic_vector(waddr_d); -- read from 0 and write to 1
  addr1 <= std_logic_vector(waddr_d) when dir_reg = '0' else std_logic_vector(raddr); -- read from 1 and write to 0

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        state <= IDLE;
        busy_reg <= '0';
        we0 <= '0';
        we1 <= '0';
        oe0 <= '0';
        oe1 <= '0';
        waddr <= (others => '0');
        waddr_d <= (others => '0');
        raddr <= (others => '0');
      else
        waddr_d <= waddr;
        case (state) is
          
          when IDLE =>
            if (kick_d = '0' and kick = '1') and -- kick'rising_edge
               (copy_1_to_0 = '1' or copy_0_to_1 = '1') and
               (unsigned(copy_num) > 0) then  
              state    <= BRAM_WAIT;
              busy_reg <= '1';
              num_reg  <= unsigned(copy_num);
              if copy_0_to_1 = '1' then
                dir_reg <= '0'; -- copy_0_to_1
                oe0 <= '1';
                oe1 <= '0';
              elsif copy_1_to_0 = '1' then
                dir_reg <= '1'; -- copy_1_to_0
                oe0 <= '0';
                oe1 <= '1';
              end if;
            else
              busy_reg <= '0';
              num_reg  <= (others => '0');
              oe0 <= '0';
              oe1 <= '0';
            end if;
            we0 <= '0';
            we1 <= '0';
            waddr <= (others => '0');
            raddr <= (others => '0');
            
          when  BRAM_WAIT =>
            state <= DO_COPY;
            raddr <= raddr + 1;

          when DO_COPY =>
            waddr <= waddr + 1;
            raddr <= raddr + 1;
            
            if dir_reg = '0' then
              we1   <= '1';
              dout1 <= din0;
            else
              we0   <= '1';
              dout0 <= din1;
            end if;
            
            if num_reg = waddr + 1 then -- last word
              state <= DO_END;
            end if;

          when DO_END =>
            busy_reg <= '0';
            state <= IDLE;
            we0   <= '0';
            we1   <= '0';

          when others =>
            state <= IDLE;
            
        end case;
      end if;
    end if;
  end process;
  
end RTL;


