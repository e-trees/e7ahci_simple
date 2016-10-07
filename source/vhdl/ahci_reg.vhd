-- Copyright (C) 2016 e-trees.Japan, Inc. All Rights Reserved. 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity ahci_reg is
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    
    address : in  std_logic_vector(31 downto 0);
    din     : in  std_logic_vector(31 downto 0);
    dout    : out std_logic_vector(31 downto 0);
    we      : in  std_logic;
    en      : in  std_logic;

    values_address : in  signed(31 downto 0);
    values_din     : in  signed(31 downto 0);
    values_dout    : out signed(31 downto 0);
    values_we      : in  std_logic;
    values_oe      : in  std_logic;
    values_length  : out signed(31 downto 0)

    );
end ahci_reg;

architecture RTL of ahci_reg is

  function ntoh32(a: std_logic_vector(31 downto 0)) return std_logic_vector is
  begin
--    return a(7 downto 0) & a(15 downto 8) & a(23 downto 16) & a(31 downto 24);
    return a;
  end ntoh32;
    
  function hton32(a: std_logic_vector(31 downto 0)) return std_logic_vector is
  begin
    return ntoh32(a);
  end hton32;

  constant DEPTH : integer := 10;
  constant WIDTH : integer := 32;
  constant WORDS : integer := 128;
  
  signal AHCI_CAP       : std_logic_vector(31 downto 0) := X"40240000"; -- 00h
  signal AHCI_GHC       : std_logic_vector(31 downto 0) := X"80000000"; -- 04h
  signal AHCI_IS        : std_logic_vector(31 downto 0) := X"00000000"; -- 08h
  signal AHCI_PI        : std_logic_vector(31 downto 0) := X"00000001"; -- 0Ch
  signal AHCI_VS        : std_logic_vector(31 downto 0) := X"00010000"; -- 10h
  signal AHCI_CCC_CTL   : std_logic_vector(31 downto 0) := X"00010100"; -- 14h
  signal AHCI_CCC_PORTS : std_logic_vector(31 downto 0) := X"00000000"; -- 18h
  signal AHCI_EM_LOC    : std_logic_vector(31 downto 0) := X"00000000"; -- 1Ch
  signal AHCI_EM_CTL    : std_logic_vector(31 downto 0) := X"00000000"; -- 20h
  signal AHCI_CAP2      : std_logic_vector(31 downto 0) := X"00000000"; -- 24h
  signal AHCI_BOHC      : std_logic_vector(31 downto 0) := X"00000000"; -- 28h

  signal AHCI_P0CLB    : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 00h
  signal AHCI_P0CLBU   : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 04h
  signal AHCI_P0FB     : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 08h
  signal AHCI_P0FBU    : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 0Ch
  signal AHCI_P0IS     : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 10h
  signal AHCI_P0IE     : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 14h
  signal AHCI_P0CMD    : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 18h
  signal AHCI_P0TFD    : std_logic_vector(31 downto 0) := X"00000058";  -- 100h + 20h
  signal AHCI_P0SIG    : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 24h
  signal AHCI_P0SSTS   : std_logic_vector(31 downto 0) := X"00000123";  -- 100h + 28h
  signal AHCI_P0SCTL   : std_logic_vector(31 downto 0) := X"00000320";  -- 100h + 2Ch
  signal AHCI_P0SERR   : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 30h
--  signal AHCI_P0SACT   : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 34h
  signal AHCI_P0SACT   : std_logic_vector(31 downto 0) := X"FFFFFFFE";  -- 100h + 34h
  signal AHCI_P0CI     : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 38h
  signal AHCI_P0SNTF   : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 3Ch
  signal AHCI_P0FBS    : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 40h
  signal AHCI_P0DEVSLP : std_logic_vector(31 downto 0) := X"00000000";  -- 100h + 44h

  signal q : std_logic_vector(31 downto 0) := (others => '0');
  signal q_b : std_logic_vector(31 downto 0) := (others => '0');

  signal address_d : std_logic_vector(31 downto 0);
  signal din_d     : std_logic_vector(31 downto 0);
  signal dout_d    : std_logic_vector(31 downto 0);
  signal we_d      : std_logic;
  signal en_d      : std_logic;

  signal values_address_d : std_logic_vector(31 downto 0);
  signal values_din_d     : std_logic_vector(31 downto 0);
  signal values_dout_d    : std_logic_vector(31 downto 0);
  signal values_we_d      : std_logic;
  signal values_oe_d      : std_logic;

  attribute mark_debug : string;
  attribute keep : string;

  attribute mark_debug of address_d        : signal is "true";
  attribute mark_debug of din_d            : signal is "true";
  attribute mark_debug of dout_d           : signal is "true";
  attribute mark_debug of we_d             : signal is "true";
  attribute mark_debug of en_d             : signal is "true";
  attribute mark_debug of values_address_d : signal is "true";
  attribute mark_debug of values_din_d     : signal is "true";
  attribute mark_debug of values_dout_d    : signal is "true";
  attribute mark_debug of values_we_d      : signal is "true";
  attribute mark_debug of values_oe_d      : signal is "true";

  attribute keep of address_d        : signal is "true";
  attribute keep of din_d            : signal is "true";
  attribute keep of dout_d           : signal is "true";
  attribute keep of we_d             : signal is "true";
  attribute keep of en_d             : signal is "true";
  attribute keep of values_address_d : signal is "true";
  attribute keep of values_din_d     : signal is "true";
  attribute keep of values_dout_d    : signal is "true";
  attribute keep of values_we_d      : signal is "true";
  attribute keep of values_oe_d      : signal is "true";

begin

  dout <= q;
  values_dout <= signed(q_b);

  process(clk)
  begin
    if clk'event and clk = '1' then
      address_d        <= address;
      din_d            <= din;
      dout_d           <= q;
      we_d             <= we;
      en_d             <= en;
      values_address_d <= std_logic_vector(values_address);
      values_din_d     <= std_logic_vector(values_din);
      values_dout_d    <= std_logic_vector(q_b);
      values_we_d      <= values_we;
      values_oe_d      <= values_oe;
    end if;
  end process;
  
  process(clk)
  begin
    if clk'event and clk = '1' then
      
      case to_integer(unsigned(address)) is
        
        when 0  => q <= AHCI_CAP;
        when 1  => q <= AHCI_GHC;
        when 2  => q <= AHCI_IS;
        when 3  => q <= AHCI_PI;
        when 4  => q <= AHCI_VS;
        when 5  => q <= AHCI_CCC_CTL;
        when 6  => q <= AHCI_CCC_PORTS;
        when 7  => q <= AHCI_EM_LOC;
        when 8  => q <= AHCI_EM_CTL;
        when 9  => q <= AHCI_CAP2;
        when 10 => q <= AHCI_BOHC;
                   
        when 64 => q <= AHCI_P0CLB;   -- 100h + 00h
        when 65 => q <= AHCI_P0CLBU;  -- 100h + 04h
        when 66 => q <= AHCI_P0FB;    -- 100h + 08h
        when 67 => q <= AHCI_P0FBU;   -- 100h + 0Ch
        when 68 => q <= AHCI_P0IS;    -- 100h + 10h
        when 69 => q <= AHCI_P0IE;    -- 100h + 14h
        when 70 => q <= AHCI_P0CMD;   -- 100h + 18h
        when 71 => q <= X"00000000";  -- 100h + 1Ch(reserved)
        when 72 => q <= AHCI_P0TFD;   -- 100h + 20h
        when 73 => q <= AHCI_P0SIG;   -- 100h + 24h
        when 74 => q <= AHCI_P0SSTS;  -- 100h + 28h
        when 75 => q <= AHCI_P0SCTL;  -- 100h + 2Ch
        when 76 => q <= AHCI_P0SERR;  -- 100h + 30h
        when 77 => q <= AHCI_P0SACT;  -- 100h + 34h
        when 78 => q <= AHCI_P0CI;    -- 100h + 38h
        when 79 => q <= AHCI_P0SNTF;  -- 100h + 3Ch
        when 80 => q <= AHCI_P0FBS;   -- 100h + 40h
        when 81 => q <= AHCI_P0DEVSLP;-- 100h + 44h
                   
        when others => null;
      end case;
      
      if en = '1' then
        if we = '1' then
          
          case to_integer(unsigned(address)) is
            
            when 0  => null; -- AHCI_CAP <= din;
            when 1  => null; -- AHCI_GHC <= din;
            when 2  => AHCI_IS <= AHCI_IS and (not din);
            when 3  => null; -- AHCI_PI <= din;
            when 4  => null; -- AHCI_VS <= din;
            when 5  => null; -- AHCI_CCC_CTL <= din;
            when 6  => null; -- AHCI_CCC_PORTS <= din;
            when 7  => null; -- AHCI_EM_LOC <= din;
            when 8  =>
              if din(0) = '1' then
                AHCI_EM_CTL(0) <= '0'; -- STS.MR
              end if;
            when 9  => null; -- AHCI_CAP2 <= din;
            when 10 => null; -- AHCI_BOHC <= din;

            when 64 => AHCI_P0CLB <= din;
            when 65 => null; -- AHCI_P0CLBU <= din;
            when 66 => AHCI_P0FB <= din;
            when 67 => null; -- AHCI_P0FBU <= din;
            when 68 =>
              AHCI_P0IS(31 downto 26) <= AHCI_P0IS(31 downto 26) and (not din(31 downto 26));
              AHCI_P0IS(24 downto 23) <= AHCI_P0IS(24 downto 23) and (not din(24 downto 23));
              AHCI_P0IS(7) <= AHCI_P0IS(7) and (not din(7));
              AHCI_P0IS(5) <= AHCI_P0IS(5) and (not din(5));
              AHCI_P0IS(3 downto 0) <= AHCI_P0IS(3 downto 0) and (not din(3 downto 0));
            when 69 => AHCI_P0IE <= din;
            when 70 => AHCI_P0CMD <= din;
            when 71 => null; -- reserved
            when 72 => null; -- AHCI_P0TFD <= din;
            when 73 => null; -- AHCI_P0SIG <= din;
            when 74 => null; -- AHCI_P0SSTS <= din;
            when 75 => null; -- AHCI_P0SCTL <= din;
            when 76 => null; -- AHCI_P0SERR <= din;
            when 77 => AHCI_P0SACT <= AHCI_P0SACT or din;
            when 78 => AHCI_P0CI <= AHCI_P0CI or din;
            when 79 => null; -- AHCI_P0SNTF <= din;
            when 80 => null; -- AHCI_P0FBS <= din;
            when 81 => null; -- AHCI_P0DEVSLP <= din;
                       
            when others => null;
          end case;
        end if;
        
      else

        if values_we = '1' then
          
          case to_integer(values_address) is
            
            when 0  => AHCI_CAP       <= std_logic_vector(values_din);
            when 1  => AHCI_GHC       <= std_logic_vector(values_din);
            when 2  => AHCI_IS        <= std_logic_vector(values_din);
            when 3  => AHCI_PI        <= std_logic_vector(values_din);
            when 4  => AHCI_VS        <= std_logic_vector(values_din);
            when 5  => AHCI_CCC_CTL   <= std_logic_vector(values_din);
            when 6  => AHCI_CCC_PORTS <= std_logic_vector(values_din);
            when 7  => AHCI_EM_LOC    <= std_logic_vector(values_din);
            when 8  => AHCI_EM_CTL    <= std_logic_vector(values_din);
            when 9  => AHCI_CAP2      <= std_logic_vector(values_din);
            when 10 => AHCI_BOHC      <= std_logic_vector(values_din);
                       
            when 64 => AHCI_P0CLB    <= std_logic_vector(values_din); -- 100h + 00h
            when 65 => AHCI_P0CLBU   <= std_logic_vector(values_din); -- 100h + 04h
            when 66 => AHCI_P0FB     <= std_logic_vector(values_din); -- 100h + 08h
            when 67 => AHCI_P0FBU    <= std_logic_vector(values_din); -- 100h + 0Ch
            when 68 => AHCI_P0IS     <= std_logic_vector(values_din); -- 100h + 10h
            when 69 => AHCI_P0IE     <= std_logic_vector(values_din); -- 100h + 14h
            when 70 => AHCI_P0CMD    <= std_logic_vector(values_din); -- 100h + 18h
            when 71 => null;                                          -- 100h + 1Ch(reserved)
            when 72 => AHCI_P0TFD    <= std_logic_vector(values_din); -- 100h + 1Ch(reserved)
            when 73 => AHCI_P0SIG    <= std_logic_vector(values_din); -- 100h + 20h
            when 74 => AHCI_P0SSTS   <= std_logic_vector(values_din); -- 100h + 24h
            when 75 => AHCI_P0SCTL   <= std_logic_vector(values_din); -- 100h + 28h
            when 76 => AHCI_P0SERR   <= std_logic_vector(values_din); -- 100h + 2Ch
            when 77 => AHCI_P0SACT   <= std_logic_vector(values_din); -- 100h + 30h
            when 78 => AHCI_P0CI     <= std_logic_vector(values_din); -- 100h + 34h
            when 79 => AHCI_P0SNTF   <= std_logic_vector(values_din); -- 100h + 38h
            when 80 => AHCI_P0FBS    <= std_logic_vector(values_din); -- 100h + 3Ch
            when 81 => AHCI_P0DEVSLP <= std_logic_vector(values_din); -- 100h + 40h
                       
            when others => null;
          end case;
          
        end if;
        
      end if;

      case to_integer(values_address) is
        
        when 0  => q_b <= AHCI_CAP;
        when 1  => q_b <= AHCI_GHC;
        when 2  => q_b <= AHCI_IS;
        when 3  => q_b <= AHCI_PI;
        when 4  => q_b <= AHCI_VS;
        when 5  => q_b <= AHCI_CCC_CTL;
        when 6  => q_b <= AHCI_CCC_PORTS;
        when 7  => q_b <= AHCI_EM_LOC;
        when 8  => q_b <= AHCI_EM_CTL;
        when 9  => q_b <= AHCI_CAP2;
        when 10 => q_b <= AHCI_BOHC;
                   
        when 64 => q_b <= AHCI_P0CLB;
        when 65 => q_b <= AHCI_P0CLBU;
        when 66 => q_b <= AHCI_P0FB;
        when 67 => q_b <= AHCI_P0FBU;
        when 68 => q_b <= AHCI_P0IS;
        when 69 => q_b <= AHCI_P0IE;
        when 70 => q_b <= AHCI_P0CMD;
        when 71 => q_b <= X"00000000"; -- reserved
        when 72 => q_b <= AHCI_P0TFD;
        when 73 => q_b <= AHCI_P0SIG;
        when 74 => q_b <= AHCI_P0SSTS;
        when 75 => q_b <= AHCI_P0SCTL;
        when 76 => q_b <= AHCI_P0SERR;
        when 77 => q_b <= AHCI_P0SACT;
        when 78 => q_b <= AHCI_P0CI;
        when 79 => q_b <= AHCI_P0SNTF;
        when 80 => q_b <= AHCI_P0FBS;
        when 81 => q_b <= AHCI_P0DEVSLP;
                   
        when others => null;
      end case;
      
    end if;
  end process;
    
end RTL;
