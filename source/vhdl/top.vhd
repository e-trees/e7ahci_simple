-- Copyright (C) 2016 e-trees.Japan, Inc. All Rights Reserved.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity top is
  port (
    IBUF_DS_N            : in    STD_LOGIC_VECTOR (0 to 0);
    IBUF_DS_P            : in    STD_LOGIC_VECTOR (0 to 0);
    pcie_7x_mgt_rxn      : in    STD_LOGIC_VECTOR (3 downto 0);
    pcie_7x_mgt_rxp      : in    STD_LOGIC_VECTOR (3 downto 0);
    pcie_7x_mgt_txn      : out   STD_LOGIC_VECTOR (3 downto 0);
    pcie_7x_mgt_txp      : out   STD_LOGIC_VECTOR (3 downto 0);
    
    sys_diff_clock_clk_n : in    STD_LOGIC;
    sys_diff_clock_clk_p : in    STD_LOGIC;
    ddr3_sdram_addr      : out   STD_LOGIC_VECTOR (13 downto 0);
    ddr3_sdram_ba        : out   STD_LOGIC_VECTOR (2 downto 0);
    ddr3_sdram_cas_n     : out   STD_LOGIC;
    ddr3_sdram_ck_n      : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_ck_p      : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_cke       : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_cs_n      : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_dm        : out   STD_LOGIC_VECTOR (7 downto 0);
    ddr3_sdram_dq        : inout STD_LOGIC_VECTOR (63 downto 0);
    ddr3_sdram_dqs_n     : inout STD_LOGIC_VECTOR (7 downto 0);
    ddr3_sdram_dqs_p     : inout STD_LOGIC_VECTOR (7 downto 0);
    ddr3_sdram_odt       : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_ras_n     : out   STD_LOGIC;
    ddr3_sdram_reset_n   : out   STD_LOGIC;
    ddr3_sdram_we_n      : out   STD_LOGIC;

    GPIO_LED : out STD_LOGIC_VECTOR(7 downto 0);
    
    reset                : in    STD_LOGIC
  );
end top;

architecture STRUCTURE of top is
  
  component design_1 is
  port (
    pcie_7x_mgt_rxn : in  STD_LOGIC_VECTOR (3 downto 0);
    pcie_7x_mgt_rxp : in  STD_LOGIC_VECTOR (3 downto 0);
    pcie_7x_mgt_txn : out STD_LOGIC_VECTOR (3 downto 0);
    pcie_7x_mgt_txp : out STD_LOGIC_VECTOR (3 downto 0);
    IBUF_DS_P       : in  STD_LOGIC_VECTOR (0 to 0);
    IBUF_DS_N       : in  STD_LOGIC_VECTOR (0 to 0);
    BRAM_PORTA_addr : out STD_LOGIC_VECTOR (14 downto 0);
    BRAM_PORTA_clk  : out STD_LOGIC;
    BRAM_PORTA_din  : out STD_LOGIC_VECTOR (31 downto 0);
    BRAM_PORTA_dout : in  STD_LOGIC_VECTOR (31 downto 0);
    BRAM_PORTA_en   : out STD_LOGIC;
    BRAM_PORTA_rst  : out STD_LOGIC;
    BRAM_PORTA_we   : out STD_LOGIC_VECTOR (3 downto 0);
    reset           : in  STD_LOGIC;
    user_clk        : out STD_LOGIC;
    user_reset_n    : out STD_LOGIC;
    
    S_AXI_awaddr    : in  STD_LOGIC_VECTOR (31 downto 0);
    S_AXI_awlen     : in  STD_LOGIC_VECTOR (7 downto 0);
    S_AXI_awsize    : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_awburst   : in  STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_awlock    : in  STD_LOGIC_VECTOR (0 to 0);
    S_AXI_awcache   : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_awprot    : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_awregion  : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_awqos     : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_awvalid   : in  STD_LOGIC;
    S_AXI_awready   : out STD_LOGIC;
    S_AXI_wdata     : in  STD_LOGIC_VECTOR (31 downto 0);
    S_AXI_wstrb     : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_wlast     : in  STD_LOGIC;
    S_AXI_wvalid    : in  STD_LOGIC;
    S_AXI_wready    : out STD_LOGIC;
    S_AXI_bresp     : out STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_bvalid    : out STD_LOGIC;
    S_AXI_bready    : in  STD_LOGIC;
    S_AXI_araddr    : in  STD_LOGIC_VECTOR (31 downto 0);
    S_AXI_arlen     : in  STD_LOGIC_VECTOR (7 downto 0);
    S_AXI_arsize    : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_arburst   : in  STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_arlock    : in  STD_LOGIC_VECTOR (0 to 0);
    S_AXI_arcache   : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_arprot    : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_arregion  : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_arqos     : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_arvalid   : in  STD_LOGIC;
    S_AXI_arready   : out STD_LOGIC;
    S_AXI_rdata     : out STD_LOGIC_VECTOR (31 downto 0);
    S_AXI_rresp     : out STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_rlast     : out STD_LOGIC;
    S_AXI_rvalid    : out STD_LOGIC;
    S_AXI_rready    : in  STD_LOGIC;

    ddr3_sdram_addr     : out   STD_LOGIC_VECTOR (13 downto 0);
    ddr3_sdram_ba       : out   STD_LOGIC_VECTOR (2 downto 0);
    ddr3_sdram_cas_n    : out   STD_LOGIC;
    ddr3_sdram_ck_n     : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_ck_p     : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_cke      : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_cs_n     : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_dm       : out   STD_LOGIC_VECTOR (7 downto 0);
    ddr3_sdram_dq       : inout STD_LOGIC_VECTOR (63 downto 0);
    ddr3_sdram_dqs_n    : inout STD_LOGIC_VECTOR (7 downto 0);
    ddr3_sdram_dqs_p    : inout STD_LOGIC_VECTOR (7 downto 0);
    ddr3_sdram_odt      : out   STD_LOGIC_VECTOR (0 to 0);
    ddr3_sdram_ras_n    : out   STD_LOGIC;
    ddr3_sdram_reset_n  : out   STD_LOGIC;
    ddr3_sdram_we_n     : out   STD_LOGIC;
    init_calib_complete : out   STD_LOGIC;
    mmcm_locked         : out   STD_LOGIC;

    S_AXI_0_araddr   : in  STD_LOGIC_VECTOR (31 downto 0);
    S_AXI_0_arburst  : in  STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_0_arcache  : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_0_arlen    : in  STD_LOGIC_VECTOR (7 downto 0);
    S_AXI_0_arlock   : in  STD_LOGIC_VECTOR (0 to 0);
    S_AXI_0_arprot   : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_0_arqos    : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_0_arready  : out STD_LOGIC;
    S_AXI_0_arregion : in  STD_LOGIC_VECTOR (3 downto 0);
--    S_AXI_0_arid : in  STD_LOGIC_VECTOR (0 downto 0);
    S_AXI_0_arsize   : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_0_arvalid  : in  STD_LOGIC;
    S_AXI_0_awaddr   : in  STD_LOGIC_VECTOR (31 downto 0);
    S_AXI_0_awburst  : in  STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_0_awcache  : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_0_awlen    : in  STD_LOGIC_VECTOR (7 downto 0);
    S_AXI_0_awlock   : in  STD_LOGIC_VECTOR (0 to 0);
    S_AXI_0_awprot   : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_0_awqos    : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_0_awready  : out STD_LOGIC;
    S_AXI_0_awregion : in  STD_LOGIC_VECTOR (3 downto 0);
--    S_AXI_0_awid : in  STD_LOGIC_VECTOR (0 downto 0);
    S_AXI_0_awsize   : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_0_awvalid  : in  STD_LOGIC;
--    S_AXI_0_bid : out  STD_LOGIC_VECTOR (0 downto 0);
    S_AXI_0_bready   : in  STD_LOGIC;
    S_AXI_0_bresp    : out STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_0_bvalid   : out STD_LOGIC;
    S_AXI_0_rdata    : out STD_LOGIC_VECTOR (511 downto 0);
    S_AXI_0_rlast    : out STD_LOGIC;
    S_AXI_0_rready   : in  STD_LOGIC;
    S_AXI_0_rresp    : out STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_0_rvalid   : out STD_LOGIC;
    S_AXI_0_wdata    : in  STD_LOGIC_VECTOR (511 downto 0);
    S_AXI_0_wlast    : in  STD_LOGIC;
    S_AXI_0_wready   : out STD_LOGIC;
    S_AXI_0_wstrb    : in  STD_LOGIC_VECTOR (63 downto 0);
    S_AXI_0_wvalid   : in  STD_LOGIC;

    S_AXI_1_araddr   : in  STD_LOGIC_VECTOR (31 downto 0);
    S_AXI_1_arburst  : in  STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_1_arcache  : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_1_arlen    : in  STD_LOGIC_VECTOR (7 downto 0);
    S_AXI_1_arlock   : in  STD_LOGIC_VECTOR (0 to 0);
    S_AXI_1_arprot   : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_1_arqos    : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_1_arready  : out STD_LOGIC;
    S_AXI_1_arregion : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_1_arsize   : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_1_arvalid  : in  STD_LOGIC;
    S_AXI_1_awaddr   : in  STD_LOGIC_VECTOR (31 downto 0);
    S_AXI_1_awburst  : in  STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_1_awcache  : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_1_awlen    : in  STD_LOGIC_VECTOR (7 downto 0);
    S_AXI_1_awlock   : in  STD_LOGIC_VECTOR (0 to 0);
    S_AXI_1_awprot   : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_1_awqos    : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_1_awready  : out STD_LOGIC;
    S_AXI_1_awregion : in  STD_LOGIC_VECTOR (3 downto 0);
    S_AXI_1_awsize   : in  STD_LOGIC_VECTOR (2 downto 0);
    S_AXI_1_awvalid  : in  STD_LOGIC;
    S_AXI_1_bready   : in  STD_LOGIC;
    S_AXI_1_bresp    : out STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_1_bvalid   : out STD_LOGIC;
    S_AXI_1_rdata    : out STD_LOGIC_VECTOR (511 downto 0);
    S_AXI_1_rlast    : out STD_LOGIC;
    S_AXI_1_rready   : in  STD_LOGIC;
    S_AXI_1_rresp    : out STD_LOGIC_VECTOR (1 downto 0);
    S_AXI_1_rvalid   : out STD_LOGIC;
    S_AXI_1_wdata    : in  STD_LOGIC_VECTOR (511 downto 0);
    S_AXI_1_wlast    : in  STD_LOGIC;
    S_AXI_1_wready   : out STD_LOGIC;
    S_AXI_1_wstrb    : in  STD_LOGIC_VECTOR (63 downto 0);
    S_AXI_1_wvalid   : in  STD_LOGIC;

    sys_diff_clock_clk_n : in STD_LOGIC;
    sys_diff_clock_clk_p : in STD_LOGIC;
    
    INTX_MSI_Request : in STD_LOGIC
  );
  end component design_1;

  component ahci_test_AHCI_Test
    port (
      clk : in std_logic;
      reset : in std_logic;
      
      reg_address_exp : in std_logic_vector(32-1 downto 0);
      reg_din_exp     : in std_logic_vector(32-1 downto 0);
      reg_dout_exp    : out std_logic_vector(32-1 downto 0);
      reg_we_exp      : in std_logic;
      reg_en_exp      : in std_logic;
      
      axi_ctrl_forbid_exp             : in  std_logic;
      axi_ctrl_axi_reader_ARADDR_exp  : out std_logic_vector(32-1 downto 0);
      axi_ctrl_axi_reader_ARLEN_exp   : out std_logic_vector(8-1 downto 0);
      axi_ctrl_axi_reader_ARVALID_exp : out std_logic;
      axi_ctrl_axi_reader_ARREADY_exp : in  std_logic;
      axi_ctrl_axi_reader_ARSIZE_exp  : out std_logic_vector(3-1 downto 0);
      axi_ctrl_axi_reader_ARBURST_exp : out std_logic_vector(2-1 downto 0);
      axi_ctrl_axi_reader_ARCACHE_exp : out std_logic_vector(4-1 downto 0);
      axi_ctrl_axi_reader_ARPROT_exp  : out std_logic_vector(3-1 downto 0);
      axi_ctrl_axi_reader_RDATA_exp   : in  std_logic_vector(32-1 downto 0);
      axi_ctrl_axi_reader_RRESP_exp   : in  std_logic_vector(2-1 downto 0);
      axi_ctrl_axi_reader_RLAST_exp   : in  std_logic;
      axi_ctrl_axi_reader_RVALID_exp  : in  std_logic;
      axi_ctrl_axi_reader_RREADY_exp  : out std_logic;
      axi_ctrl_axi_writer_AWADDR_exp  : out std_logic_vector(32-1 downto 0);
      axi_ctrl_axi_writer_AWLEN_exp   : out std_logic_vector(8-1 downto 0);
      axi_ctrl_axi_writer_AWVALID_exp : out std_logic;
      axi_ctrl_axi_writer_AWSIZE_exp  : out std_logic_vector(3-1 downto 0);
      axi_ctrl_axi_writer_AWBURST_exp : out std_logic_vector(2-1 downto 0);
      axi_ctrl_axi_writer_AWCACHE_exp : out std_logic_vector(4-1 downto 0);
      axi_ctrl_axi_writer_AWPROT_exp  : out std_logic_vector(3-1 downto 0);
      axi_ctrl_axi_writer_AWREADY_exp : in  std_logic;
      axi_ctrl_axi_writer_WDATA_exp   : out std_logic_vector(32-1 downto 0);
      axi_ctrl_axi_writer_WLAST_exp   : out std_logic;
      axi_ctrl_axi_writer_WVALID_exp  : out std_logic;
      axi_ctrl_axi_writer_WREADY_exp  : in  std_logic;
      axi_ctrl_axi_writer_WSTRB_exp   : out std_logic_vector(4-1 downto 0);
      axi_ctrl_axi_writer_BRESP_exp   : in  std_logic_vector(2-1 downto 0);
      axi_ctrl_axi_writer_BVALID_exp  : in  std_logic;
      axi_ctrl_axi_writer_BREADY_exp  : out std_logic;
      
      axi_obj0_data_address_external_exp : in  std_logic_vector(32-1 downto 0);
      axi_obj0_data_din_external_exp     : in  std_logic_vector(512-1 downto 0);
      axi_obj0_data_dout_external_exp    : out std_logic_vector(512-1 downto 0);
      axi_obj0_data_we_external_exp      : in  std_logic;
      axi_obj0_data_oe_external_exp      : in  std_logic;
      axi_obj0_ext_ctrl_exp              : in  std_logic;
      axi_obj0_forbid_exp                : in  std_logic;
      axi_obj0_axi_reader_ARADDR_exp     : out std_logic_vector(32-1 downto 0);
      axi_obj0_axi_reader_ARLEN_exp      : out std_logic_vector(8-1 downto 0);
      axi_obj0_axi_reader_ARVALID_exp    : out std_logic;
      axi_obj0_axi_reader_ARREADY_exp    : in  std_logic;
      axi_obj0_axi_reader_ARSIZE_exp     : out std_logic_vector(3-1 downto 0);
      axi_obj0_axi_reader_ARBURST_exp    : out std_logic_vector(2-1 downto 0);
      axi_obj0_axi_reader_ARCACHE_exp    : out std_logic_vector(4-1 downto 0);
      axi_obj0_axi_reader_ARPROT_exp     : out std_logic_vector(3-1 downto 0);
      axi_obj0_axi_reader_RDATA_exp      : in  std_logic_vector(512-1 downto 0);
      axi_obj0_axi_reader_RRESP_exp      : in  std_logic_vector(2-1 downto 0);
      axi_obj0_axi_reader_RLAST_exp      : in  std_logic;
      axi_obj0_axi_reader_RVALID_exp     : in  std_logic;
      axi_obj0_axi_reader_RREADY_exp     : out std_logic;
      axi_obj0_axi_writer_AWADDR_exp     : out std_logic_vector(32-1 downto 0);
      axi_obj0_axi_writer_AWLEN_exp      : out std_logic_vector(8-1 downto 0);
      axi_obj0_axi_writer_AWVALID_exp    : out std_logic;
      axi_obj0_axi_writer_AWSIZE_exp     : out std_logic_vector(3-1 downto 0);
      axi_obj0_axi_writer_AWBURST_exp    : out std_logic_vector(2-1 downto 0);
      axi_obj0_axi_writer_AWCACHE_exp    : out std_logic_vector(4-1 downto 0);
      axi_obj0_axi_writer_AWPROT_exp     : out std_logic_vector(3-1 downto 0);
      axi_obj0_axi_writer_AWREADY_exp    : in  std_logic;
      axi_obj0_axi_writer_WDATA_exp      : out std_logic_vector(512-1 downto 0);
      axi_obj0_axi_writer_WLAST_exp      : out std_logic;
      axi_obj0_axi_writer_WVALID_exp     : out std_logic;
      axi_obj0_axi_writer_WREADY_exp     : in  std_logic;
      axi_obj0_axi_writer_WSTRB_exp      : out std_logic_vector(64-1 downto 0);
      axi_obj0_axi_writer_BRESP_exp      : in  std_logic_vector(2-1 downto 0);
      axi_obj0_axi_writer_BVALID_exp     : in  std_logic;
      axi_obj0_axi_writer_BREADY_exp     : out std_logic;
      
      axi_obj1_data_address_external_exp : in  std_logic_vector(32-1 downto 0);
      axi_obj1_data_din_external_exp     : in  std_logic_vector(512-1 downto 0);
      axi_obj1_data_dout_external_exp    : out std_logic_vector(512-1 downto 0);
      axi_obj1_data_we_external_exp      : in  std_logic;
      axi_obj1_data_oe_external_exp      : in  std_logic;
      axi_obj1_ext_ctrl_exp              : in  std_logic;
      axi_obj1_forbid_exp                : in  std_logic;
      axi_obj1_axi_reader_ARADDR_exp     : out std_logic_vector(32-1 downto 0);
      axi_obj1_axi_reader_ARLEN_exp      : out std_logic_vector(8-1 downto 0);
      axi_obj1_axi_reader_ARVALID_exp    : out std_logic;
      axi_obj1_axi_reader_ARREADY_exp    : in  std_logic;
      axi_obj1_axi_reader_ARSIZE_exp     : out std_logic_vector(3-1 downto 0);
      axi_obj1_axi_reader_ARBURST_exp    : out std_logic_vector(2-1 downto 0);
      axi_obj1_axi_reader_ARCACHE_exp    : out std_logic_vector(4-1 downto 0);
      axi_obj1_axi_reader_ARPROT_exp     : out std_logic_vector(3-1 downto 0);
      axi_obj1_axi_reader_RDATA_exp      : in  std_logic_vector(512-1 downto 0);
      axi_obj1_axi_reader_RRESP_exp      : in  std_logic_vector(2-1 downto 0);
      axi_obj1_axi_reader_RLAST_exp      : in  std_logic;
      axi_obj1_axi_reader_RVALID_exp     : in  std_logic;
      axi_obj1_axi_reader_RREADY_exp     : out std_logic;
      axi_obj1_axi_writer_AWADDR_exp     : out std_logic_vector(32-1 downto 0);
      axi_obj1_axi_writer_AWLEN_exp      : out std_logic_vector(8-1 downto 0);
      axi_obj1_axi_writer_AWVALID_exp    : out std_logic;
      axi_obj1_axi_writer_AWSIZE_exp     : out std_logic_vector(3-1 downto 0);
      axi_obj1_axi_writer_AWBURST_exp    : out std_logic_vector(2-1 downto 0);
      axi_obj1_axi_writer_AWCACHE_exp    : out std_logic_vector(4-1 downto 0);
      axi_obj1_axi_writer_AWPROT_exp     : out std_logic_vector(3-1 downto 0);
      axi_obj1_axi_writer_AWREADY_exp    : in  std_logic;
      axi_obj1_axi_writer_WDATA_exp      : out std_logic_vector(512-1 downto 0);
      axi_obj1_axi_writer_WLAST_exp      : out std_logic;
      axi_obj1_axi_writer_WVALID_exp     : out std_logic;
      axi_obj1_axi_writer_WREADY_exp     : in  std_logic;
      axi_obj1_axi_writer_WSTRB_exp      : out std_logic_vector(64-1 downto 0);
      axi_obj1_axi_writer_BRESP_exp      : in  std_logic_vector(2-1 downto 0);
      axi_obj1_axi_writer_BVALID_exp     : in  std_logic;
      axi_obj1_axi_writer_BREADY_exp     : out std_logic;
      
      axi_memcpy_kick_dout_exp : out std_logic;
      axi_memcpy_busy_din_exp : in std_logic;
      axi_memcpy_0to1_dout_exp : out std_logic;
      axi_memcpy_1to0_dout_exp : out std_logic;
      axi_memcpy_num_dout_exp : out std_logic_vector(32-1 downto 0);

      interrupt_dout_exp : out std_logic;
      
      dw0_in  : in  signed(32-1 downto 0);
      dw0_we  : in  std_logic;
      dw0_out : out signed(32-1 downto 0);
      dw1_in  : in  signed(32-1 downto 0);
      dw1_we  : in  std_logic;
      dw1_out : out signed(32-1 downto 0);
      dw2_in  : in  signed(32-1 downto 0);
      dw2_we  : in  std_logic;
      dw2_out : out signed(32-1 downto 0);
      dw3_in  : in  signed(32-1 downto 0);
      dw3_we  : in  std_logic;
      dw3_out : out signed(32-1 downto 0);
      dw4_in  : in  signed(32-1 downto 0);
      dw4_we  : in  std_logic;
      dw4_out : out signed(32-1 downto 0);
      
      status_in  : in  signed(32-1 downto 0);
      status_we  : in  std_logic;
      status_out : out signed(32-1 downto 0);

      fpdma_sectors_in  : in  signed(32-1 downto 0);
      fpdma_sectors_we  : in  std_logic;
      fpdma_sectors_out : out signed(32-1 downto 0);
      fpdma_lba_in      : in  signed(32-1 downto 0);
      fpdma_lba_we      : in  std_logic;
      fpdma_lba_out     : out signed(32-1 downto 0);
      fpdma_lba_exp_in  : in  signed(32-1 downto 0);
      fpdma_lba_exp_we  : in  std_logic;
      fpdma_lba_exp_out : out signed(32-1 downto 0);
      ncq_tag_in        : in  signed(32-1 downto 0);
      ncq_tag_we        : in  std_logic;
      ncq_tag_out       : out signed(32-1 downto 0);
      
      debug_fpdma_src_in   : in  signed(32-1 downto 0);
      debug_fpdma_src_we   : in  std_logic;
      debug_fpdma_src_out  : out signed(32-1 downto 0);
      debug_fpdma_dest_in  : in  signed(32-1 downto 0);
      debug_fpdma_dest_we  : in  std_logic;
      debug_fpdma_dest_out : out signed(32-1 downto 0);
      debug_fpdma_rest_in  : in  signed(32-1 downto 0);
      debug_fpdma_rest_we  : in  std_logic;
      debug_fpdma_rest_out : out signed(32-1 downto 0);

      init_busy : out std_logic;
      init_req : in std_logic;
      test_busy  : out std_logic;
      test_req   : in  std_logic
      );
  end component ahci_test_AHCI_Test;

  component bram_copy
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
  end component bram_copy;

  attribute mark_debug : string;
  attribute keep : string;

  signal BRAM_PORTA_addr : STD_LOGIC_VECTOR (14 downto 0);
  signal BRAM_PORTA_clk  : STD_LOGIC;
  signal BRAM_PORTA_din  : STD_LOGIC_VECTOR (31 downto 0);
  signal BRAM_PORTA_dout : STD_LOGIC_VECTOR (31 downto 0);
  signal BRAM_PORTA_en   : STD_LOGIC;
  signal BRAM_PORTA_we   : STD_LOGIC_VECTOR (3 downto 0);

  signal BRAM_PORTA_addr_d : STD_LOGIC_VECTOR (14 downto 0);
  signal BRAM_PORTA_din_d  : STD_LOGIC_VECTOR (31 downto 0);
  signal BRAM_PORTA_dout_d : STD_LOGIC_VECTOR (31 downto 0);
  signal BRAM_PORTA_en_d   : STD_LOGIC;
  signal BRAM_PORTA_we_d   : STD_LOGIC_VECTOR (3 downto 0);
  
  attribute mark_debug of BRAM_PORTA_addr_d : signal is "true";
  attribute mark_debug of BRAM_PORTA_din_d  : signal is "true";
  attribute mark_debug of BRAM_PORTA_dout_d : signal is "true";
  attribute mark_debug of BRAM_PORTA_en_d   : signal is "true";
  attribute mark_debug of BRAM_PORTA_we_d   : signal is "true";
  
  attribute keep of BRAM_PORTA_addr_d : signal is "true";
  attribute keep of BRAM_PORTA_din_d  : signal is "true";
  attribute keep of BRAM_PORTA_dout_d : signal is "true";
  attribute keep of BRAM_PORTA_en_d   : signal is "true";
  attribute keep of BRAM_PORTA_we_d   : signal is "true";

  signal reg_addr : std_logic_vector(31 downto 0) := (others => '0');
  signal reg_we   : std_logic;

  signal user_clk, user_reset_n : std_logic;

  signal reset_counter : unsigned(31 downto 0) := (others => '0');
  signal delayed_reset_n_flag : std_logic := '0';


  signal ARADDR  : std_logic_vector(32-1 downto 0);
  signal ARLEN   : std_logic_vector(8-1 downto 0);
  signal ARVALID : std_logic;
  signal ARREADY : std_logic;
  signal ARSIZE  : std_logic_vector(3-1 downto 0);
  signal ARBURST : std_logic_vector(2-1 downto 0);
  signal ARCACHE : std_logic_vector(4-1 downto 0);
  signal ARPROT  : std_logic_vector(3-1 downto 0);
  signal RDATA   : std_logic_vector(32-1 downto 0);
  signal RRESP   : std_logic_vector(2-1 downto 0);
  signal RLAST   : std_logic;
  signal RVALID  : std_logic;
  signal RREADY  : std_logic;
  signal AWADDR  : std_logic_vector(32-1 downto 0);
  signal AWLEN   : std_logic_vector(8-1 downto 0);
  signal AWVALID : std_logic;
  signal AWSIZE  : std_logic_vector(3-1 downto 0);
  signal AWBURST : std_logic_vector(2-1 downto 0);
  signal AWCACHE : std_logic_vector(4-1 downto 0);
  signal AWPROT  : std_logic_vector(3-1 downto 0);
  signal AWREADY : std_logic;
  signal WDATA   : std_logic_vector(32-1 downto 0);
  signal WLAST   : std_logic;
  signal WVALID  : std_logic;
  signal WREADY  : std_logic;
  signal WSTRB   : std_logic_vector(4-1 downto 0);
  signal BRESP   : std_logic_vector(2-1 downto 0);
  signal BVALID  : std_logic;
  signal BREADY  : std_logic;

  signal ARADDR_d  : std_logic_vector(32-1 downto 0);
  signal ARLEN_d   : std_logic_vector(8-1 downto 0);
  signal ARVALID_d : std_logic;
  signal ARREADY_d : std_logic;
  signal ARSIZE_d  : std_logic_vector(3-1 downto 0);
  signal ARBURST_d : std_logic_vector(2-1 downto 0);
  signal ARCACHE_d : std_logic_vector(4-1 downto 0);
  signal ARPROT_d  : std_logic_vector(3-1 downto 0);
  signal RDATA_d   : std_logic_vector(32-1 downto 0);
  signal RRESP_d   : std_logic_vector(2-1 downto 0);
  signal RLAST_d   : std_logic;
  signal RVALID_d  : std_logic;
  signal RREADY_d  : std_logic;
  signal AWADDR_d  : std_logic_vector(32-1 downto 0);
  signal AWLEN_d   : std_logic_vector(8-1 downto 0);
  signal AWVALID_d : std_logic;
  signal AWSIZE_d  : std_logic_vector(3-1 downto 0);
  signal AWBURST_d : std_logic_vector(2-1 downto 0);
  signal AWCACHE_d : std_logic_vector(4-1 downto 0);
  signal AWPROT_d  : std_logic_vector(3-1 downto 0);
  signal AWREADY_d : std_logic;
  signal WDATA_d   : std_logic_vector(32-1 downto 0);
  signal WLAST_d   : std_logic;
  signal WVALID_d  : std_logic;
  signal WREADY_d  : std_logic;
  signal WSTRB_d   : std_logic_vector(4-1 downto 0);
  signal BRESP_d   : std_logic_vector(2-1 downto 0);
  signal BVALID_d  : std_logic;
  signal BREADY_d  : std_logic;

  attribute mark_debug of ARADDR_d  : signal is "true";
  attribute mark_debug of ARLEN_d   : signal is "true";
  attribute mark_debug of ARVALID_d : signal is "true";
  attribute mark_debug of ARREADY_d : signal is "true";
  attribute mark_debug of ARSIZE_d  : signal is "true";
  attribute mark_debug of ARBURST_d : signal is "true";
  attribute mark_debug of ARCACHE_d : signal is "true";
  attribute mark_debug of ARPROT_d  : signal is "true";
  attribute mark_debug of RDATA_d   : signal is "true";
  attribute mark_debug of RRESP_d   : signal is "true";
  attribute mark_debug of RLAST_d   : signal is "true";
  attribute mark_debug of RVALID_d  : signal is "true";
  attribute mark_debug of RREADY_d  : signal is "true";
  attribute mark_debug of AWADDR_d  : signal is "true";
  attribute mark_debug of AWLEN_d   : signal is "true";
  attribute mark_debug of AWVALID_d : signal is "true";
  attribute mark_debug of AWSIZE_d  : signal is "true";
  attribute mark_debug of AWBURST_d : signal is "true";
  attribute mark_debug of AWCACHE_d : signal is "true";
  attribute mark_debug of AWPROT_d  : signal is "true";
  attribute mark_debug of AWREADY_d : signal is "true";
  attribute mark_debug of WDATA_d   : signal is "true";
  attribute mark_debug of WLAST_d   : signal is "true";
  attribute mark_debug of WVALID_d  : signal is "true";
  attribute mark_debug of WREADY_d  : signal is "true";
  attribute mark_debug of WSTRB_d   : signal is "true";
  attribute mark_debug of BRESP_d   : signal is "true";
  attribute mark_debug of BVALID_d  : signal is "true";
  attribute mark_debug of BREADY_d  : signal is "true";

  attribute keep of ARADDR_d  : signal is "true";
  attribute keep of ARLEN_d   : signal is "true";
  attribute keep of ARVALID_d : signal is "true";
  attribute keep of ARREADY_d : signal is "true";
  attribute keep of ARSIZE_d  : signal is "true";
  attribute keep of ARBURST_d : signal is "true";
  attribute keep of ARCACHE_d : signal is "true";
  attribute keep of ARPROT_d  : signal is "true";
  attribute keep of RDATA_d   : signal is "true";
  attribute keep of RRESP_d   : signal is "true";
  attribute keep of RLAST_d   : signal is "true";
  attribute keep of RVALID_d  : signal is "true";
  attribute keep of RREADY_d  : signal is "true";
  attribute keep of AWADDR_d  : signal is "true";
  attribute keep of AWLEN_d   : signal is "true";
  attribute keep of AWVALID_d : signal is "true";
  attribute keep of AWSIZE_d  : signal is "true";
  attribute keep of AWBURST_d : signal is "true";
  attribute keep of AWCACHE_d : signal is "true";
  attribute keep of AWPROT_d  : signal is "true";
  attribute keep of AWREADY_d : signal is "true";
  attribute keep of WDATA_d   : signal is "true";
  attribute keep of WLAST_d   : signal is "true";
  attribute keep of WVALID_d  : signal is "true";
  attribute keep of WREADY_d  : signal is "true";
  attribute keep of WSTRB_d   : signal is "true";
  attribute keep of BRESP_d   : signal is "true";
  attribute keep of BVALID_d  : signal is "true";
  attribute keep of BREADY_d  : signal is "true";
  
  signal command_list_dw0 : signed(32-1 downto 0);
  signal command_list_dw1 : signed(32-1 downto 0);
  signal command_list_dw2 : signed(32-1 downto 0);
  signal command_list_dw3 : signed(32-1 downto 0);
  signal command_list_dw4 : signed(32-1 downto 0);

  signal ahci_test_status : signed(32-1 downto 0);

  signal command_list_dw0_d : signed(32-1 downto 0);
  signal command_list_dw1_d : signed(32-1 downto 0);
  signal command_list_dw2_d : signed(32-1 downto 0);
  signal command_list_dw3_d : signed(32-1 downto 0);
  signal command_list_dw4_d : signed(32-1 downto 0);
  
  signal ahci_test_status_d : signed(32-1 downto 0);

  attribute mark_debug of command_list_dw0_d : signal is "true";
  attribute mark_debug of command_list_dw1_d : signal is "true";
  attribute mark_debug of command_list_dw2_d : signal is "true";
  attribute mark_debug of command_list_dw3_d : signal is "true";
  attribute mark_debug of command_list_dw4_d : signal is "true";
  attribute mark_debug of ahci_test_status_d : signal is "true";
  
  attribute keep of command_list_dw0_d : signal is "true";
  attribute keep of command_list_dw1_d : signal is "true";
  attribute keep of command_list_dw2_d : signal is "true";
  attribute keep of command_list_dw3_d : signal is "true";
  attribute keep of command_list_dw4_d : signal is "true";
  attribute keep of ahci_test_status_d : signal is "true";

  signal ahci_values_address : std_logic_vector(31 downto 0);
  signal ahci_values_din     : std_logic_vector(31 downto 0);
  signal ahci_values_dout    : std_logic_vector(31 downto 0);
  signal ahci_values_we      : std_logic;
  signal ahci_values_oe      : std_logic;
  signal ahci_values_length  : signed(31 downto 0);

  signal INTX_MSI_Request : std_logic := '0';

  signal ahci_fpdma_sectors_out : signed(31 downto 0);
  signal ahci_fpdma_lba_out     : signed(31 downto 0);
  signal ahci_fpdma_lba_exp_out : signed(31 downto 0);
  signal ahci_ncq_tag_out       : signed(31 downto 0);

  signal ahci_fpdma_sectors_out_d : signed(31 downto 0);
  signal ahci_fpdma_lba_out_d     : signed(31 downto 0);
  signal ahci_fpdma_lba_exp_out_d : signed(31 downto 0);
  signal ahci_ncq_tag_out_d       : signed(31 downto 0);

  attribute mark_debug of ahci_fpdma_sectors_out_d : signal is "true";
  attribute mark_debug of ahci_fpdma_lba_out_d     : signal is "true";
  attribute mark_debug of ahci_fpdma_lba_exp_out_d : signal is "true";
  attribute mark_debug of ahci_ncq_tag_out_d       : signal is "true";

  attribute keep of ahci_fpdma_sectors_out_d : signal is "true";
  attribute keep of ahci_fpdma_lba_out_d     : signal is "true";
  attribute keep of ahci_fpdma_lba_exp_out_d : signal is "true";
  attribute keep of ahci_ncq_tag_out_d       : signal is "true";

  signal performance_counter : unsigned(31 downto 0) := (others => '0');
  
  attribute mark_debug of performance_counter : signal is "true";
  attribute keep of performance_counter : signal is "true";

  signal init_calib_complete : std_logic;
  signal mmcm_locked : std_logic;
  
  signal S_AXI_1_araddr   : STD_LOGIC_VECTOR (31 downto 0);
  signal S_AXI_1_arburst  : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_1_arcache  : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_arlen    : STD_LOGIC_VECTOR (7 downto 0);
  signal S_AXI_1_arlock   : STD_LOGIC_VECTOR (0 to 0);
  signal S_AXI_1_arprot   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_1_arqos    : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_arready  : STD_LOGIC;
  signal S_AXI_1_arregion : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_arsize   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_1_arvalid  : STD_LOGIC;
  signal S_AXI_1_awaddr   : STD_LOGIC_VECTOR (31 downto 0);
  signal S_AXI_1_awburst  : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_1_awcache  : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_awlen    : STD_LOGIC_VECTOR (7 downto 0);
  signal S_AXI_1_awlock   : STD_LOGIC_VECTOR (0 to 0);
  signal S_AXI_1_awprot   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_1_awqos    : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_awready  : STD_LOGIC;
  signal S_AXI_1_awregion : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_awsize   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_1_awvalid  : STD_LOGIC;
  signal S_AXI_1_bready   : STD_LOGIC;
  signal S_AXI_1_bresp    : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_1_bvalid   : STD_LOGIC;
  signal S_AXI_1_rdata    : STD_LOGIC_VECTOR (511 downto 0);
  signal S_AXI_1_rlast    : STD_LOGIC;
  signal S_AXI_1_rready   : STD_LOGIC;
  signal S_AXI_1_rresp    : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_1_rvalid   : STD_LOGIC;
  signal S_AXI_1_wdata    : STD_LOGIC_VECTOR (511 downto 0);
  signal S_AXI_1_wlast    : STD_LOGIC;
  signal S_AXI_1_wready   : STD_LOGIC;
  signal S_AXI_1_wstrb    : STD_LOGIC_VECTOR (63 downto 0);
  signal S_AXI_1_wvalid   : STD_LOGIC;

  signal S_AXI_0_araddr   : STD_LOGIC_VECTOR (31 downto 0);
  signal S_AXI_0_arburst  : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_0_arcache  : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_arlen    : STD_LOGIC_VECTOR (7 downto 0);
  signal S_AXI_0_arlock   : STD_LOGIC_VECTOR (0 to 0);
  signal S_AXI_0_arprot   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_0_arqos    : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_arready  : STD_LOGIC;
  signal S_AXI_0_arregion : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_arsize   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_0_arvalid  : STD_LOGIC;
  signal S_AXI_0_awaddr   : STD_LOGIC_VECTOR (31 downto 0);
  signal S_AXI_0_awburst  : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_0_awcache  : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_awlen    : STD_LOGIC_VECTOR (7 downto 0);
  signal S_AXI_0_awlock   : STD_LOGIC_VECTOR (0 to 0);
  signal S_AXI_0_awprot   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_0_awqos    : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_awready  : STD_LOGIC;
  signal S_AXI_0_awregion : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_awsize   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_0_awvalid  : STD_LOGIC;
  signal S_AXI_0_bready   : STD_LOGIC;
  signal S_AXI_0_bresp    : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_0_bvalid   : STD_LOGIC;
  signal S_AXI_0_rdata    : STD_LOGIC_VECTOR (511 downto 0);
  signal S_AXI_0_rlast    : STD_LOGIC;
  signal S_AXI_0_rready   : STD_LOGIC;
  signal S_AXI_0_rresp    : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_0_rvalid   : STD_LOGIC;
  signal S_AXI_0_wdata    : STD_LOGIC_VECTOR (511 downto 0);
  signal S_AXI_0_wlast    : STD_LOGIC;
  signal S_AXI_0_wready   : STD_LOGIC;
  signal S_AXI_0_wstrb    : STD_LOGIC_VECTOR (63 downto 0);
  signal S_AXI_0_wvalid   : STD_LOGIC;

  signal debug_fpdma_src_out  : signed(32-1 downto 0);
  signal debug_fpdma_dest_out : signed(32-1 downto 0);
  signal debug_fpdma_rest_out : signed(32-1 downto 0);

  signal debug_fpdma_src_out_d  : signed(32-1 downto 0);
  signal debug_fpdma_dest_out_d : signed(32-1 downto 0);
  signal debug_fpdma_rest_out_d : signed(32-1 downto 0);
  
  attribute mark_debug of debug_fpdma_src_out_d  : signal is "true";
  attribute mark_debug of debug_fpdma_dest_out_d : signal is "true";
  attribute mark_debug of debug_fpdma_rest_out_d : signal is "true";
  
  attribute keep of debug_fpdma_src_out_d  : signal is "true";
  attribute keep of debug_fpdma_dest_out_d : signal is "true";
  attribute keep of debug_fpdma_rest_out_d : signal is "true";

  signal S_AXI_1_araddr_d   : STD_LOGIC_VECTOR (31 downto 0);
  signal S_AXI_1_arburst_d  : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_1_arcache_d  : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_arlen_d    : STD_LOGIC_VECTOR (7 downto 0);
  signal S_AXI_1_arlock_d   : STD_LOGIC_VECTOR (0 to 0);
  signal S_AXI_1_arprot_d   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_1_arqos_d    : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_arready_d  : STD_LOGIC;
  signal S_AXI_1_arregion_d : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_arsize_d   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_1_arvalid_d  : STD_LOGIC;
  signal S_AXI_1_awaddr_d   : STD_LOGIC_VECTOR (31 downto 0);
  signal S_AXI_1_awburst_d  : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_1_awcache_d  : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_awlen_d    : STD_LOGIC_VECTOR (7 downto 0);
  signal S_AXI_1_awlock_d   : STD_LOGIC_VECTOR (0 to 0);
  signal S_AXI_1_awprot_d   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_1_awqos_d    : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_awready_d  : STD_LOGIC;
  signal S_AXI_1_awregion_d : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_1_awsize_d   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_1_awvalid_d  : STD_LOGIC;
  signal S_AXI_1_bready_d   : STD_LOGIC;
  signal S_AXI_1_bresp_d    : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_1_bvalid_d   : STD_LOGIC;
  signal S_AXI_1_rdata_d    : STD_LOGIC_VECTOR (511 downto 0);
  signal S_AXI_1_rlast_d    : STD_LOGIC;
  signal S_AXI_1_rready_d   : STD_LOGIC;
  signal S_AXI_1_rresp_d    : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_1_rvalid_d   : STD_LOGIC;
  signal S_AXI_1_wdata_d    : STD_LOGIC_VECTOR (511 downto 0);
  signal S_AXI_1_wlast_d    : STD_LOGIC;
  signal S_AXI_1_wready_d   : STD_LOGIC;
  signal S_AXI_1_wstrb_d    : STD_LOGIC_VECTOR (63 downto 0);
  signal S_AXI_1_wvalid_d   : STD_LOGIC;

  signal S_AXI_0_araddr_d   : STD_LOGIC_VECTOR (31 downto 0);
  signal S_AXI_0_arburst_d  : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_0_arcache_d  : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_arlen_d    : STD_LOGIC_VECTOR (7 downto 0);
  signal S_AXI_0_arlock_d   : STD_LOGIC_VECTOR (0 to 0);
  signal S_AXI_0_arprot_d   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_0_arqos_d    : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_arready_d  : STD_LOGIC;
  signal S_AXI_0_arregion_d : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_arsize_d   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_0_arvalid_d  : STD_LOGIC;
  signal S_AXI_0_awaddr_d   : STD_LOGIC_VECTOR (31 downto 0);
  signal S_AXI_0_awburst_d  : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_0_awcache_d  : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_awlen_d    : STD_LOGIC_VECTOR (7 downto 0);
  signal S_AXI_0_awlock_d   : STD_LOGIC_VECTOR (0 to 0);
  signal S_AXI_0_awprot_d   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_0_awqos_d    : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_awready_d  : STD_LOGIC;
  signal S_AXI_0_awregion_d : STD_LOGIC_VECTOR (3 downto 0);
  signal S_AXI_0_awsize_d   : STD_LOGIC_VECTOR (2 downto 0);
  signal S_AXI_0_awvalid_d  : STD_LOGIC;
  signal S_AXI_0_bready_d   : STD_LOGIC;
  signal S_AXI_0_bresp_d    : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_0_bvalid_d   : STD_LOGIC;
  signal S_AXI_0_rdata_d    : STD_LOGIC_VECTOR (511 downto 0);
  signal S_AXI_0_rlast_d    : STD_LOGIC;
  signal S_AXI_0_rready_d   : STD_LOGIC;
  signal S_AXI_0_rresp_d    : STD_LOGIC_VECTOR (1 downto 0);
  signal S_AXI_0_rvalid_d   : STD_LOGIC;
  signal S_AXI_0_wdata_d    : STD_LOGIC_VECTOR (511 downto 0);
  signal S_AXI_0_wlast_d    : STD_LOGIC;
  signal S_AXI_0_wready_d   : STD_LOGIC;
  signal S_AXI_0_wstrb_d    : STD_LOGIC_VECTOR (63 downto 0);
  signal S_AXI_0_wvalid_d   : STD_LOGIC;

  attribute mark_debug of S_AXI_1_araddr_d   : signal is "true";
  attribute mark_debug of S_AXI_1_arburst_d  : signal is "true";
  attribute mark_debug of S_AXI_1_arcache_d  : signal is "true";
  attribute mark_debug of S_AXI_1_arlen_d    : signal is "true";
  attribute mark_debug of S_AXI_1_arlock_d   : signal is "true";
  attribute mark_debug of S_AXI_1_arprot_d   : signal is "true";
  attribute mark_debug of S_AXI_1_arqos_d    : signal is "true";
  attribute mark_debug of S_AXI_1_arready_d  : signal is "true";
  attribute mark_debug of S_AXI_1_arregion_d : signal is "true";
  attribute mark_debug of S_AXI_1_arsize_d   : signal is "true";
  attribute mark_debug of S_AXI_1_arvalid_d  : signal is "true";
  attribute mark_debug of S_AXI_1_awaddr_d   : signal is "true";
  attribute mark_debug of S_AXI_1_awburst_d  : signal is "true";
  attribute mark_debug of S_AXI_1_awcache_d  : signal is "true";
  attribute mark_debug of S_AXI_1_awlen_d    : signal is "true";
  attribute mark_debug of S_AXI_1_awlock_d   : signal is "true";
  attribute mark_debug of S_AXI_1_awprot_d   : signal is "true";
  attribute mark_debug of S_AXI_1_awqos_d    : signal is "true";
  attribute mark_debug of S_AXI_1_awready_d  : signal is "true";
  attribute mark_debug of S_AXI_1_awregion_d : signal is "true";
  attribute mark_debug of S_AXI_1_awsize_d   : signal is "true";
  attribute mark_debug of S_AXI_1_awvalid_d  : signal is "true";
  attribute mark_debug of S_AXI_1_bready_d   : signal is "true";
  attribute mark_debug of S_AXI_1_bresp_d    : signal is "true";
  attribute mark_debug of S_AXI_1_bvalid_d   : signal is "true";
  attribute mark_debug of S_AXI_1_rdata_d    : signal is "true";
  attribute mark_debug of S_AXI_1_rlast_d    : signal is "true";
  attribute mark_debug of S_AXI_1_rready_d   : signal is "true";
  attribute mark_debug of S_AXI_1_rresp_d    : signal is "true";
  attribute mark_debug of S_AXI_1_rvalid_d   : signal is "true";
  attribute mark_debug of S_AXI_1_wdata_d    : signal is "true";
  attribute mark_debug of S_AXI_1_wlast_d    : signal is "true";
  attribute mark_debug of S_AXI_1_wready_d   : signal is "true";
  attribute mark_debug of S_AXI_1_wstrb_d    : signal is "true";
  attribute mark_debug of S_AXI_1_wvalid_d   : signal is "true";

  attribute keep of S_AXI_1_araddr_d   : signal is "true";
  attribute keep of S_AXI_1_arburst_d  : signal is "true";
  attribute keep of S_AXI_1_arcache_d  : signal is "true";
  attribute keep of S_AXI_1_arlen_d    : signal is "true";
  attribute keep of S_AXI_1_arlock_d   : signal is "true";
  attribute keep of S_AXI_1_arprot_d   : signal is "true";
  attribute keep of S_AXI_1_arqos_d    : signal is "true";
  attribute keep of S_AXI_1_arready_d  : signal is "true";
  attribute keep of S_AXI_1_arregion_d : signal is "true";
  attribute keep of S_AXI_1_arsize_d   : signal is "true";
  attribute keep of S_AXI_1_arvalid_d  : signal is "true";
  attribute keep of S_AXI_1_awaddr_d   : signal is "true";
  attribute keep of S_AXI_1_awburst_d  : signal is "true";
  attribute keep of S_AXI_1_awcache_d  : signal is "true";
  attribute keep of S_AXI_1_awlen_d    : signal is "true";
  attribute keep of S_AXI_1_awlock_d   : signal is "true";
  attribute keep of S_AXI_1_awprot_d   : signal is "true";
  attribute keep of S_AXI_1_awqos_d    : signal is "true";
  attribute keep of S_AXI_1_awready_d  : signal is "true";
  attribute keep of S_AXI_1_awregion_d : signal is "true";
  attribute keep of S_AXI_1_awsize_d   : signal is "true";
  attribute keep of S_AXI_1_awvalid_d  : signal is "true";
  attribute keep of S_AXI_1_bready_d   : signal is "true";
  attribute keep of S_AXI_1_bresp_d    : signal is "true";
  attribute keep of S_AXI_1_bvalid_d   : signal is "true";
  attribute keep of S_AXI_1_rdata_d    : signal is "true";
  attribute keep of S_AXI_1_rlast_d    : signal is "true";
  attribute keep of S_AXI_1_rready_d   : signal is "true";
  attribute keep of S_AXI_1_rresp_d    : signal is "true";
  attribute keep of S_AXI_1_rvalid_d   : signal is "true";
  attribute keep of S_AXI_1_wdata_d    : signal is "true";
  attribute keep of S_AXI_1_wlast_d    : signal is "true";
  attribute keep of S_AXI_1_wready_d   : signal is "true";
  attribute keep of S_AXI_1_wstrb_d    : signal is "true";
  attribute keep of S_AXI_1_wvalid_d   : signal is "true";

  attribute mark_debug of S_AXI_0_araddr_d   : signal is "true";
  attribute mark_debug of S_AXI_0_arburst_d  : signal is "true";
  attribute mark_debug of S_AXI_0_arcache_d  : signal is "true";
  attribute mark_debug of S_AXI_0_arlen_d    : signal is "true";
  attribute mark_debug of S_AXI_0_arlock_d   : signal is "true";
  attribute mark_debug of S_AXI_0_arprot_d   : signal is "true";
  attribute mark_debug of S_AXI_0_arqos_d    : signal is "true";
  attribute mark_debug of S_AXI_0_arready_d  : signal is "true";
  attribute mark_debug of S_AXI_0_arregion_d : signal is "true";
  attribute mark_debug of S_AXI_0_arsize_d   : signal is "true";
  attribute mark_debug of S_AXI_0_arvalid_d  : signal is "true";
  attribute mark_debug of S_AXI_0_awaddr_d   : signal is "true";
  attribute mark_debug of S_AXI_0_awburst_d  : signal is "true";
  attribute mark_debug of S_AXI_0_awcache_d  : signal is "true";
  attribute mark_debug of S_AXI_0_awlen_d    : signal is "true";
  attribute mark_debug of S_AXI_0_awlock_d   : signal is "true";
  attribute mark_debug of S_AXI_0_awprot_d   : signal is "true";
  attribute mark_debug of S_AXI_0_awqos_d    : signal is "true";
  attribute mark_debug of S_AXI_0_awready_d  : signal is "true";
  attribute mark_debug of S_AXI_0_awregion_d : signal is "true";
  attribute mark_debug of S_AXI_0_awsize_d   : signal is "true";
  attribute mark_debug of S_AXI_0_awvalid_d  : signal is "true";
  attribute mark_debug of S_AXI_0_bready_d   : signal is "true";
  attribute mark_debug of S_AXI_0_bresp_d    : signal is "true";
  attribute mark_debug of S_AXI_0_bvalid_d   : signal is "true";
  attribute mark_debug of S_AXI_0_rdata_d    : signal is "true";
  attribute mark_debug of S_AXI_0_rlast_d    : signal is "true";
  attribute mark_debug of S_AXI_0_rready_d   : signal is "true";
  attribute mark_debug of S_AXI_0_rresp_d    : signal is "true";
  attribute mark_debug of S_AXI_0_rvalid_d   : signal is "true";
  attribute mark_debug of S_AXI_0_wdata_d    : signal is "true";
  attribute mark_debug of S_AXI_0_wlast_d    : signal is "true";
  attribute mark_debug of S_AXI_0_wready_d   : signal is "true";
  attribute mark_debug of S_AXI_0_wstrb_d    : signal is "true";
  attribute mark_debug of S_AXI_0_wvalid_d   : signal is "true";

  attribute keep of S_AXI_0_araddr_d   : signal is "true";
  attribute keep of S_AXI_0_arburst_d  : signal is "true";
  attribute keep of S_AXI_0_arcache_d  : signal is "true";
  attribute keep of S_AXI_0_arlen_d    : signal is "true";
  attribute keep of S_AXI_0_arlock_d   : signal is "true";
  attribute keep of S_AXI_0_arprot_d   : signal is "true";
  attribute keep of S_AXI_0_arqos_d    : signal is "true";
  attribute keep of S_AXI_0_arready_d  : signal is "true";
  attribute keep of S_AXI_0_arregion_d : signal is "true";
  attribute keep of S_AXI_0_arsize_d   : signal is "true";
  attribute keep of S_AXI_0_arvalid_d  : signal is "true";
  attribute keep of S_AXI_0_awaddr_d   : signal is "true";
  attribute keep of S_AXI_0_awburst_d  : signal is "true";
  attribute keep of S_AXI_0_awcache_d  : signal is "true";
  attribute keep of S_AXI_0_awlen_d    : signal is "true";
  attribute keep of S_AXI_0_awlock_d   : signal is "true";
  attribute keep of S_AXI_0_awprot_d   : signal is "true";
  attribute keep of S_AXI_0_awqos_d    : signal is "true";
  attribute keep of S_AXI_0_awready_d  : signal is "true";
  attribute keep of S_AXI_0_awregion_d : signal is "true";
  attribute keep of S_AXI_0_awsize_d   : signal is "true";
  attribute keep of S_AXI_0_awvalid_d  : signal is "true";
  attribute keep of S_AXI_0_bready_d   : signal is "true";
  attribute keep of S_AXI_0_bresp_d    : signal is "true";
  attribute keep of S_AXI_0_bvalid_d   : signal is "true";
  attribute keep of S_AXI_0_rdata_d    : signal is "true";
  attribute keep of S_AXI_0_rlast_d    : signal is "true";
  attribute keep of S_AXI_0_rready_d   : signal is "true";
  attribute keep of S_AXI_0_rresp_d    : signal is "true";
  attribute keep of S_AXI_0_rvalid_d   : signal is "true";
  attribute keep of S_AXI_0_wdata_d    : signal is "true";
  attribute keep of S_AXI_0_wlast_d    : signal is "true";
  attribute keep of S_AXI_0_wready_d   : signal is "true";
  attribute keep of S_AXI_0_wstrb_d    : signal is "true";
  attribute keep of S_AXI_0_wvalid_d   : signal is "true";
  
  signal bram_copy_addr0 : std_logic_vector(31 downto 0);
  signal bram_copy_dout0 : std_logic_vector(511 downto 0);
  signal bram_copy_din0  : std_logic_vector(511 downto 0);
  signal bram_copy_we0   : std_logic;
  signal bram_copy_oe0   : std_logic;
    
  signal bram_copy_addr1 : std_logic_vector(31 downto 0);
  signal bram_copy_dout1 : std_logic_vector(511 downto 0);
  signal bram_copy_din1  : std_logic_vector(511 downto 0);
  signal bram_copy_we1   : std_logic;
  signal bram_copy_oe1   : std_logic;
    
  signal bram_copy_0_to_1 : std_logic;
  signal bram_copy_1_to_0 : std_logic;
  signal bram_copy_num    : std_logic_vector(31 downto 0);
    
  signal bram_copy_kick : std_logic;
  signal bram_copy_busy : std_logic;

  signal bram_copy_addr0_d  : std_logic_vector(31 downto 0);
  signal bram_copy_dout0_d  : std_logic_vector(511 downto 0);
  signal bram_copy_din0_d   : std_logic_vector(511 downto 0);
  signal bram_copy_we0_d    : std_logic;
  signal bram_copy_oe0_d    : std_logic;
  signal bram_copy_addr1_d  : std_logic_vector(31 downto 0);
  signal bram_copy_dout1_d  : std_logic_vector(511 downto 0);
  signal bram_copy_din1_d   : std_logic_vector(511 downto 0);
  signal bram_copy_we1_d    : std_logic;
  signal bram_copy_oe1_d    : std_logic;
  signal bram_copy_0_to_1_d : std_logic;
  signal bram_copy_1_to_0_d : std_logic;
  signal bram_copy_num_d    : std_logic_vector(31 downto 0);
  signal bram_copy_kick_d   : std_logic;
  signal bram_copy_busy_d   : std_logic;

  attribute mark_debug of bram_copy_addr0_d  : signal is "true";
  attribute mark_debug of bram_copy_dout0_d  : signal is "true";
  attribute mark_debug of bram_copy_din0_d   : signal is "true";
  attribute mark_debug of bram_copy_we0_d    : signal is "true";
  attribute mark_debug of bram_copy_oe0_d    : signal is "true";
  attribute mark_debug of bram_copy_addr1_d  : signal is "true";
  attribute mark_debug of bram_copy_dout1_d  : signal is "true";
  attribute mark_debug of bram_copy_din1_d   : signal is "true";
  attribute mark_debug of bram_copy_we1_d    : signal is "true";
  attribute mark_debug of bram_copy_oe1_d    : signal is "true";
  attribute mark_debug of bram_copy_0_to_1_d : signal is "true";
  attribute mark_debug of bram_copy_1_to_0_d : signal is "true";
  attribute mark_debug of bram_copy_num_d    : signal is "true";
  attribute mark_debug of bram_copy_kick_d   : signal is "true";
  attribute mark_debug of bram_copy_busy_d   : signal is "true";

  attribute keep of bram_copy_addr0_d  : signal is "true";
  attribute keep of bram_copy_dout0_d  : signal is "true";
  attribute keep of bram_copy_din0_d   : signal is "true";
  attribute keep of bram_copy_we0_d    : signal is "true";
  attribute keep of bram_copy_oe0_d    : signal is "true";
  attribute keep of bram_copy_addr1_d  : signal is "true";
  attribute keep of bram_copy_dout1_d  : signal is "true";
  attribute keep of bram_copy_din1_d   : signal is "true";
  attribute keep of bram_copy_we1_d    : signal is "true";
  attribute keep of bram_copy_oe1_d    : signal is "true";
  attribute keep of bram_copy_0_to_1_d : signal is "true";
  attribute keep of bram_copy_1_to_0_d : signal is "true";
  attribute keep of bram_copy_num_d    : signal is "true";
  attribute keep of bram_copy_kick_d   : signal is "true";
  attribute keep of bram_copy_busy_d   : signal is "true";

begin

  GPIO_LED(0) <= '1';
  GPIO_LED(1) <= '0';
  GPIO_LED(2) <= '0';
  GPIO_LED(3) <= '0';
  GPIO_LED(4) <= '0';
  GPIO_LED(5) <= user_reset_n;
  GPIO_LED(6) <= init_calib_complete;
  GPIO_LED(7) <= mmcm_locked;

  process(user_clk)
  begin
    if user_clk'event and user_clk = '1' then
      if user_reset_n = '0' then
        reset_counter <= (others => '0');
        delayed_reset_n_flag <= '0';
      else
        if reset_counter < 100 then
          reset_counter <= reset_counter + 1;
          delayed_reset_n_flag <= '0';
        else
          delayed_reset_n_flag <= '1';
        end if;
      end if;
    end if;
  end process;

  design_1_i : design_1
    port map (
      BRAM_PORTA_addr(14 downto 0) => BRAM_PORTA_addr(14 downto 0),
      BRAM_PORTA_clk               => BRAM_PORTA_clk,
      BRAM_PORTA_din(31 downto 0)  => BRAM_PORTA_din(31 downto 0),
      BRAM_PORTA_dout(31 downto 0) => BRAM_PORTA_dout(31 downto 0),
      BRAM_PORTA_en                => BRAM_PORTA_en,
      BRAM_PORTA_rst               => open,
      BRAM_PORTA_we(3 downto 0)    => BRAM_PORTA_we(3 downto 0),
      IBUF_DS_N(0)                 => IBUF_DS_N(0),
      IBUF_DS_P(0)                 => IBUF_DS_P(0),
      pcie_7x_mgt_rxn(3 downto 0)  => pcie_7x_mgt_rxn(3 downto 0),
      pcie_7x_mgt_rxp(3 downto 0)  => pcie_7x_mgt_rxp(3 downto 0),
      pcie_7x_mgt_txn(3 downto 0)  => pcie_7x_mgt_txn(3 downto 0),
      pcie_7x_mgt_txp(3 downto 0)  => pcie_7x_mgt_txp(3 downto 0),
      
      reset        => reset,
      user_clk     => user_clk,
      user_reset_n => user_reset_n,
      
      S_AXI_awaddr    => AWADDR,
      S_AXI_awlen     => AWLEN,
      S_AXI_awsize    => AWSIZE,
      S_AXI_awburst   => AWBURST,
      S_AXI_awlock    => (others => '0'),
      S_AXI_awcache   => AWCACHE,
      S_AXI_awprot    => AWPROT,
      S_AXI_awregion  => (others => '0'),
      S_AXI_awqos     => (others => '0'),
      S_AXI_awvalid   => AWVALID,
      S_AXI_awready   => AWREADY,
      S_AXI_wdata     => WDATA,
      S_AXI_wstrb     => WSTRB,
      S_AXI_wlast     => WLAST,
      S_AXI_wvalid    => WVALID,
      S_AXI_wready    => WREADY,
      S_AXI_bresp     => BRESP,
      S_AXI_bvalid    => BVALID,
      S_AXI_bready    => BREADY,
      S_AXI_araddr    => ARADDR,
      S_AXI_arlen     => ARLEN,
      S_AXI_arsize    => ARSIZE,
      S_AXI_arburst   => ARBURST,
      S_AXI_arlock    => (others => '0'),
      S_AXI_arcache   => ARCACHE,
      S_AXI_arprot    => ARPROT,
      S_AXI_arregion  => (others => '0'),
      S_AXI_arqos     => (others => '0'),
      S_AXI_arvalid   => ARVALID,
      S_AXI_arready   => ARREADY,
      S_AXI_rdata     => RDATA,
      S_AXI_rresp     => RRESP,
      S_AXI_rlast     => RLAST,
      S_AXI_rvalid    => RVALID,
      S_AXI_rready    => RREADY,
      INTX_MSI_Request => INTX_MSI_Request,

      ddr3_sdram_addr    => ddr3_sdram_addr,
      ddr3_sdram_ba      => ddr3_sdram_ba,
      ddr3_sdram_cas_n   => ddr3_sdram_cas_n,
      ddr3_sdram_ck_n    => ddr3_sdram_ck_n,
      ddr3_sdram_ck_p    => ddr3_sdram_ck_p,
      ddr3_sdram_cke     => ddr3_sdram_cke,
      ddr3_sdram_cs_n    => ddr3_sdram_cs_n,
      ddr3_sdram_dm      => ddr3_sdram_dm,
      ddr3_sdram_dq      => ddr3_sdram_dq,
      ddr3_sdram_dqs_n   => ddr3_sdram_dqs_n,
      ddr3_sdram_dqs_p   => ddr3_sdram_dqs_p,
      ddr3_sdram_odt     => ddr3_sdram_odt,
      ddr3_sdram_ras_n   => ddr3_sdram_ras_n,
      ddr3_sdram_reset_n => ddr3_sdram_reset_n,
      ddr3_sdram_we_n    => ddr3_sdram_we_n,
      
      init_calib_complete => init_calib_complete,
      mmcm_locked         => mmcm_locked,

      S_AXI_0_araddr   => S_AXI_0_araddr,
      S_AXI_0_arburst  => S_AXI_0_arburst,
      S_AXI_0_arcache  => S_AXI_0_arcache,
      S_AXI_0_arlen    => S_AXI_0_arlen,
      S_AXI_0_arlock   => S_AXI_0_arlock,
      S_AXI_0_arprot   => S_AXI_0_arprot,
      S_AXI_0_arqos    => S_AXI_0_arqos,
      S_AXI_0_arready  => S_AXI_0_arready,
      S_AXI_0_arregion => S_AXI_0_arregion,
--      S_AXI_0_arid => "0",
      S_AXI_0_arsize   => S_AXI_0_arsize,
      S_AXI_0_arvalid  => S_AXI_0_arvalid,
      S_AXI_0_awaddr   => S_AXI_0_awaddr,
      S_AXI_0_awburst  => S_AXI_0_awburst,
      S_AXI_0_awcache  => S_AXI_0_awcache,
      S_AXI_0_awlen    => S_AXI_0_awlen,
      S_AXI_0_awlock   => S_AXI_0_awlock,
      S_AXI_0_awprot   => S_AXI_0_awprot,
      S_AXI_0_awqos    => S_AXI_0_awqos,
      S_AXI_0_awready  => S_AXI_0_awready,
      S_AXI_0_awregion => S_AXI_0_awregion,
--      S_AXI_0_awid => "0",
      S_AXI_0_awsize   => S_AXI_0_awsize,
      S_AXI_0_awvalid  => S_AXI_0_awvalid,
--      S_AXI_0_bid => open,
      S_AXI_0_bready   => S_AXI_0_bready,
      S_AXI_0_bresp    => S_AXI_0_bresp,
      S_AXI_0_bvalid   => S_AXI_0_bvalid,
      S_AXI_0_rdata    => S_AXI_0_rdata,
      S_AXI_0_rlast    => S_AXI_0_rlast,
      S_AXI_0_rready   => S_AXI_0_rready,
      S_AXI_0_rresp    => S_AXI_0_rresp,
      S_AXI_0_rvalid   => S_AXI_0_rvalid,
      S_AXI_0_wdata    => S_AXI_0_wdata,
      S_AXI_0_wlast    => S_AXI_0_wlast,
      S_AXI_0_wready   => S_AXI_0_wready,
      S_AXI_0_wstrb    => S_AXI_0_wstrb,
      S_AXI_0_wvalid   => S_AXI_0_wvalid,
 
      S_AXI_1_araddr   => S_AXI_1_araddr,
      S_AXI_1_arburst  => S_AXI_1_arburst,
      S_AXI_1_arcache  => S_AXI_1_arcache,
      S_AXI_1_arlen    => S_AXI_1_arlen,
      S_AXI_1_arlock   => S_AXI_1_arlock,
      S_AXI_1_arprot   => S_AXI_1_arprot,
      S_AXI_1_arqos    => S_AXI_1_arqos,
      S_AXI_1_arready  => S_AXI_1_arready,
      S_AXI_1_arregion => S_AXI_1_arregion,
      S_AXI_1_arsize   => S_AXI_1_arsize,
      S_AXI_1_arvalid  => S_AXI_1_arvalid,
      S_AXI_1_awaddr   => S_AXI_1_awaddr,
      S_AXI_1_awburst  => S_AXI_1_awburst,
      S_AXI_1_awcache  => S_AXI_1_awcache,
      S_AXI_1_awlen    => S_AXI_1_awlen,
      S_AXI_1_awlock   => S_AXI_1_awlock,
      S_AXI_1_awprot   => S_AXI_1_awprot,
      S_AXI_1_awqos    => S_AXI_1_awqos,
      S_AXI_1_awready  => S_AXI_1_awready,
      S_AXI_1_awregion => S_AXI_1_awregion,
      S_AXI_1_awsize   => S_AXI_1_awsize,
      S_AXI_1_awvalid  => S_AXI_1_awvalid,
      S_AXI_1_bready   => S_AXI_1_bready,
      S_AXI_1_bresp    => S_AXI_1_bresp,
      S_AXI_1_bvalid   => S_AXI_1_bvalid,
      S_AXI_1_rdata    => S_AXI_1_rdata,
      S_AXI_1_rlast    => S_AXI_1_rlast,
      S_AXI_1_rready   => S_AXI_1_rready,
      S_AXI_1_rresp    => S_AXI_1_rresp,
      S_AXI_1_rvalid   => S_AXI_1_rvalid,
      S_AXI_1_wdata    => S_AXI_1_wdata,
      S_AXI_1_wlast    => S_AXI_1_wlast,
      S_AXI_1_wready   => S_AXI_1_wready,
      S_AXI_1_wstrb    => S_AXI_1_wstrb,
      S_AXI_1_wvalid   => S_AXI_1_wvalid,

      sys_diff_clock_clk_n => sys_diff_clock_clk_n,
      sys_diff_clock_clk_p => sys_diff_clock_clk_p
      
      );

  process(BRAM_PORTA_clk)
  begin
    if BRAM_PORTA_clk'event and BRAM_PORTA_clk = '1' then
      BRAM_PORTA_addr_d <= BRAM_PORTA_addr;
      BRAM_PORTA_din_d  <= BRAM_PORTA_din;
      BRAM_PORTA_dout_d <= BRAM_PORTA_dout;
      BRAM_PORTA_en_d   <= BRAM_PORTA_en;
      BRAM_PORTA_we_d   <= BRAM_PORTA_we;
    end if;
  end process;

  reg_addr(12 downto 0) <= BRAM_PORTA_addr(14 downto 2);
  reg_we <= BRAM_PORTA_we(0) and BRAM_PORTA_we(1) and BRAM_PORTA_we(2) and BRAM_PORTA_we(3);

  U_AHCI : ahci_test_AHCI_Test port map(
    clk   => user_clk,
    reset => not user_reset_n,

    reg_address_exp => reg_addr,
    reg_din_exp     => BRAM_PORTA_din,
    reg_dout_exp    => BRAM_PORTA_dout,
    reg_we_exp      => reg_we,
    reg_en_exp      => BRAM_PORTA_en,

    axi_ctrl_forbid_exp             => '0',
    axi_ctrl_axi_reader_ARADDR_exp  => ARADDR,
    axi_ctrl_axi_reader_ARLEN_exp   => ARLEN,
    axi_ctrl_axi_reader_ARVALID_exp => ARVALID,
    axi_ctrl_axi_reader_ARREADY_exp => ARREADY,
    axi_ctrl_axi_reader_ARSIZE_exp  => ARSIZE,
    axi_ctrl_axi_reader_ARBURST_exp => ARBURST,
    axi_ctrl_axi_reader_ARCACHE_exp => ARCACHE,
    axi_ctrl_axi_reader_ARPROT_exp  => ARPROT,
    axi_ctrl_axi_reader_RDATA_exp   => RDATA,
    axi_ctrl_axi_reader_RRESP_exp   => RRESP,
    axi_ctrl_axi_reader_RLAST_exp   => RLAST,
    axi_ctrl_axi_reader_RVALID_exp  => RVALID,
    axi_ctrl_axi_reader_RREADY_exp  => RREADY,
    axi_ctrl_axi_writer_AWADDR_exp  => AWADDR,
    axi_ctrl_axi_writer_AWLEN_exp   => AWLEN,
    axi_ctrl_axi_writer_AWVALID_exp => AWVALID,
    axi_ctrl_axi_writer_AWSIZE_exp  => AWSIZE,
    axi_ctrl_axi_writer_AWBURST_exp => AWBURST,
    axi_ctrl_axi_writer_AWCACHE_exp => AWCACHE,
    axi_ctrl_axi_writer_AWPROT_exp  => AWPROT,
    axi_ctrl_axi_writer_AWREADY_exp => AWREADY,
    axi_ctrl_axi_writer_WDATA_exp   => WDATA,
    axi_ctrl_axi_writer_WLAST_exp   => WLAST,
    axi_ctrl_axi_writer_WVALID_exp  => WVALID,
    axi_ctrl_axi_writer_WREADY_exp  => WREADY,
    axi_ctrl_axi_writer_WSTRB_exp   => WSTRB,
    axi_ctrl_axi_writer_BRESP_exp   => BRESP,
    axi_ctrl_axi_writer_BVALID_exp  => BVALID,
    axi_ctrl_axi_writer_BREADY_exp  => BREADY,

    axi_obj0_data_address_external_exp => bram_copy_addr0,
    axi_obj0_data_din_external_exp     => bram_copy_dout0,
    axi_obj0_data_dout_external_exp    => bram_copy_din0,
    axi_obj0_data_we_external_exp      => bram_copy_we0,
    axi_obj0_data_oe_external_exp      => bram_copy_oe0,
    axi_obj0_ext_ctrl_exp              => bram_copy_busy,
    
    axi_obj0_forbid_exp             => '0',
    axi_obj0_axi_reader_ARADDR_exp  => S_AXI_0_araddr,
    axi_obj0_axi_reader_ARLEN_exp   => S_AXI_0_arlen,
    axi_obj0_axi_reader_ARVALID_exp => S_AXI_0_arvalid,
    axi_obj0_axi_reader_ARREADY_exp => S_AXI_0_arready,
    axi_obj0_axi_reader_ARSIZE_exp  => S_AXI_0_arsize,
    axi_obj0_axi_reader_ARBURST_exp => S_AXI_0_arburst,
    axi_obj0_axi_reader_ARCACHE_exp => S_AXI_0_arcache,
    axi_obj0_axi_reader_ARPROT_exp  => S_AXI_0_arprot,
    axi_obj0_axi_reader_RDATA_exp   => S_AXI_0_rdata,
    axi_obj0_axi_reader_RRESP_exp   => S_AXI_0_rresp,
    axi_obj0_axi_reader_RLAST_exp   => S_AXI_0_rlast,
    axi_obj0_axi_reader_RVALID_exp  => S_AXI_0_rvalid,
    axi_obj0_axi_reader_RREADY_exp  => S_AXI_0_rready,
    axi_obj0_axi_writer_AWADDR_exp  => S_AXI_0_awaddr,
    axi_obj0_axi_writer_AWLEN_exp   => S_AXI_0_awlen,
    axi_obj0_axi_writer_AWVALID_exp => S_AXI_0_awvalid,
    axi_obj0_axi_writer_AWSIZE_exp  => S_AXI_0_awsize,
    axi_obj0_axi_writer_AWBURST_exp => S_AXI_0_awburst,
    axi_obj0_axi_writer_AWCACHE_exp => S_AXI_0_awcache,
    axi_obj0_axi_writer_AWPROT_exp  => S_AXI_0_awprot,
    axi_obj0_axi_writer_AWREADY_exp => S_AXI_0_awready,
    axi_obj0_axi_writer_WDATA_exp   => S_AXI_0_wdata,
    axi_obj0_axi_writer_WLAST_exp   => S_AXI_0_wlast,
    axi_obj0_axi_writer_WVALID_exp  => S_AXI_0_wvalid,
    axi_obj0_axi_writer_WREADY_exp  => S_AXI_0_wready,
    axi_obj0_axi_writer_WSTRB_exp   => S_AXI_0_wstrb,
    axi_obj0_axi_writer_BRESP_exp   => S_AXI_0_bresp,
    axi_obj0_axi_writer_BVALID_exp  => S_AXI_0_bvalid,
    axi_obj0_axi_writer_BREADY_exp  => S_AXI_0_bready,
    
    axi_obj1_data_address_external_exp => bram_copy_addr1,
    axi_obj1_data_din_external_exp     => bram_copy_dout1,
    axi_obj1_data_dout_external_exp    => bram_copy_din1,
    axi_obj1_data_we_external_exp      => bram_copy_we1,
    axi_obj1_data_oe_external_exp      => bram_copy_oe1,
    axi_obj1_ext_ctrl_exp              => bram_copy_busy,
    
    axi_obj1_forbid_exp             => '0',
    axi_obj1_axi_reader_ARADDR_exp  => S_AXI_1_araddr,
    axi_obj1_axi_reader_ARLEN_exp   => S_AXI_1_arlen,
    axi_obj1_axi_reader_ARVALID_exp => S_AXI_1_arvalid,
    axi_obj1_axi_reader_ARREADY_exp => S_AXI_1_arready,
    axi_obj1_axi_reader_ARSIZE_exp  => S_AXI_1_arsize,
    axi_obj1_axi_reader_ARBURST_exp => S_AXI_1_arburst,
    axi_obj1_axi_reader_ARCACHE_exp => S_AXI_1_arcache,
    axi_obj1_axi_reader_ARPROT_exp  => S_AXI_1_arprot,
    axi_obj1_axi_reader_RDATA_exp   => S_AXI_1_rdata,
    axi_obj1_axi_reader_RRESP_exp   => S_AXI_1_rresp,
    axi_obj1_axi_reader_RLAST_exp   => S_AXI_1_rlast,
    axi_obj1_axi_reader_RVALID_exp  => S_AXI_1_rvalid,
    axi_obj1_axi_reader_RREADY_exp  => S_AXI_1_rready,
    axi_obj1_axi_writer_AWADDR_exp  => S_AXI_1_awaddr,
    axi_obj1_axi_writer_AWLEN_exp   => S_AXI_1_awlen,
    axi_obj1_axi_writer_AWVALID_exp => S_AXI_1_awvalid,
    axi_obj1_axi_writer_AWSIZE_exp  => S_AXI_1_awsize,
    axi_obj1_axi_writer_AWBURST_exp => S_AXI_1_awburst,
    axi_obj1_axi_writer_AWCACHE_exp => S_AXI_1_awcache,
    axi_obj1_axi_writer_AWPROT_exp  => S_AXI_1_awprot,
    axi_obj1_axi_writer_AWREADY_exp => S_AXI_1_awready,
    axi_obj1_axi_writer_WDATA_exp   => S_AXI_1_wdata,
    axi_obj1_axi_writer_WLAST_exp   => S_AXI_1_wlast,
    axi_obj1_axi_writer_WVALID_exp  => S_AXI_1_wvalid,
    axi_obj1_axi_writer_WREADY_exp  => S_AXI_1_wready,
    axi_obj1_axi_writer_WSTRB_exp   => S_AXI_1_wstrb,
    axi_obj1_axi_writer_BRESP_exp   => S_AXI_1_bresp,
    axi_obj1_axi_writer_BVALID_exp  => S_AXI_1_bvalid,
    axi_obj1_axi_writer_BREADY_exp  => S_AXI_1_bready,
    
    axi_memcpy_kick_dout_exp => bram_copy_kick,
    axi_memcpy_busy_din_exp  => bram_copy_busy,
    axi_memcpy_0to1_dout_exp => bram_copy_0_to_1,
    axi_memcpy_1to0_dout_exp => bram_copy_1_to_0,
    axi_memcpy_num_dout_exp  => bram_copy_num,

    interrupt_dout_exp => INTX_MSI_Request,

    dw0_in  => (others => '0'),
    dw0_we  => '0',
    dw0_out => command_list_dw0,
    dw1_in  => (others => '0'),
    dw1_we  => '0',
    dw1_out => command_list_dw1,
    dw2_in  => (others => '0'),
    dw2_we  => '0',
    dw2_out => command_list_dw2,
    dw3_in  => (others => '0'),
    dw3_we  => '0',
    dw3_out => command_list_dw3,
    dw4_in  => (others => '0'),
    dw4_we  => '0',
    dw4_out => command_list_dw4,
    
    status_in  => (others => '0'),
    status_we  => '0',
    status_out => ahci_test_status,

    fpdma_sectors_in  => (others => '0'),
    fpdma_sectors_we  => '0',
    fpdma_sectors_out => ahci_fpdma_sectors_out,
    fpdma_lba_in      => (others => '0'),
    fpdma_lba_we      => '0',
    fpdma_lba_out     => ahci_fpdma_lba_out,
    fpdma_lba_exp_in  => (others => '0'),
    fpdma_lba_exp_we  => '0',
    fpdma_lba_exp_out => ahci_fpdma_lba_exp_out,
    ncq_tag_in        => (others => '0'),
    ncq_tag_we        => '0',
    ncq_tag_out       => ahci_ncq_tag_out,
    
    debug_fpdma_src_in   => (others => '0'),
    debug_fpdma_src_we   => '0',
    debug_fpdma_src_out  => debug_fpdma_src_out,
    debug_fpdma_dest_in  => (others => '0'),
    debug_fpdma_dest_we  => '0',
    debug_fpdma_dest_out => debug_fpdma_dest_out,
    debug_fpdma_rest_in  => (others => '0'),
    debug_fpdma_rest_we  => '0',
    debug_fpdma_rest_out => debug_fpdma_rest_out,
    
    init_busy  => open,
    init_req   => '0',

    test_busy  => open,
    test_req   => delayed_reset_n_flag
    );

  process(user_clk)
  begin
    if user_clk'event and user_clk = '1' then
      command_list_dw0_d <= command_list_dw0;
      command_list_dw1_d <= command_list_dw1;
      command_list_dw2_d <= command_list_dw2;
      command_list_dw3_d <= command_list_dw3;
      command_list_dw4_d <= command_list_dw4;
      ahci_test_status_d <= ahci_test_status;

      ahci_fpdma_sectors_out_d <= ahci_fpdma_sectors_out;
      ahci_fpdma_lba_out_d     <= ahci_fpdma_lba_out;
      ahci_fpdma_lba_exp_out_d <= ahci_fpdma_lba_exp_out;
      ahci_ncq_tag_out_d       <= ahci_ncq_tag_out;

      ARADDR_d  <= ARADDR;
      ARLEN_d   <= ARLEN;
      ARVALID_d <= ARVALID;
      ARREADY_d <= ARREADY;
      ARSIZE_d  <= ARSIZE;
      ARBURST_d <= ARBURST;
      ARCACHE_d <= ARCACHE;
      ARPROT_d  <= ARPROT;
      RDATA_d   <= RDATA;
      RRESP_d   <= RRESP;
      RLAST_d   <= RLAST;
      RVALID_d  <= RVALID;
      RREADY_d  <= RREADY;
      AWADDR_d  <= AWADDR;
      AWLEN_d   <= AWLEN;
      AWVALID_d <= AWVALID;
      AWSIZE_d  <= AWSIZE;
      AWBURST_d <= AWBURST;
      AWCACHE_d <= AWCACHE;
      AWPROT_d  <= AWPROT;
      AWREADY_d <= AWREADY;
      WDATA_d   <= WDATA;
      WLAST_d   <= WLAST;
      WVALID_d  <= WVALID;
      WREADY_d  <= WREADY;
      WSTRB_d   <= WSTRB;
      BRESP_d   <= BRESP;
      BVALID_d  <= BVALID;
      BREADY_d  <= BREADY;

      debug_fpdma_src_out_d  <= debug_fpdma_src_out;
      debug_fpdma_dest_out_d <= debug_fpdma_dest_out;
      debug_fpdma_rest_out_d <= debug_fpdma_rest_out;
      
      S_AXI_0_araddr_d   <= S_AXI_0_araddr;
      S_AXI_0_arburst_d  <= S_AXI_0_arburst;
      S_AXI_0_arcache_d  <= S_AXI_0_arcache;
      S_AXI_0_arlen_d    <= S_AXI_0_arlen;
      S_AXI_0_arlock_d   <= S_AXI_0_arlock;
      S_AXI_0_arprot_d   <= S_AXI_0_arprot;
      S_AXI_0_arqos_d    <= S_AXI_0_arqos;
      S_AXI_0_arready_d  <= S_AXI_0_arready;
      S_AXI_0_arregion_d <= S_AXI_0_arregion;
      S_AXI_0_arsize_d   <= S_AXI_0_arsize;
      S_AXI_0_arvalid_d  <= S_AXI_0_arvalid;
      S_AXI_0_awaddr_d   <= S_AXI_0_awaddr;
      S_AXI_0_awburst_d  <= S_AXI_0_awburst;
      S_AXI_0_awcache_d  <= S_AXI_0_awcache;
      S_AXI_0_awlen_d    <= S_AXI_0_awlen;
      S_AXI_0_awlock_d   <= S_AXI_0_awlock;
      S_AXI_0_awprot_d   <= S_AXI_0_awprot;
      S_AXI_0_awqos_d    <= S_AXI_0_awqos;
      S_AXI_0_awready_d  <= S_AXI_0_awready;
      S_AXI_0_awregion_d <= S_AXI_0_awregion;
      S_AXI_0_awsize_d   <= S_AXI_0_awsize;
      S_AXI_0_awvalid_d  <= S_AXI_0_awvalid;
      S_AXI_0_bready_d   <= S_AXI_0_bready;
      S_AXI_0_bresp_d    <= S_AXI_0_bresp;
      S_AXI_0_bvalid_d   <= S_AXI_0_bvalid;
      S_AXI_0_rdata_d    <= S_AXI_0_rdata;
      S_AXI_0_rlast_d    <= S_AXI_0_rlast;
      S_AXI_0_rready_d   <= S_AXI_0_rready;
      S_AXI_0_rresp_d    <= S_AXI_0_rresp;
      S_AXI_0_rvalid_d   <= S_AXI_0_rvalid;
      S_AXI_0_wdata_d    <= S_AXI_0_wdata;
      S_AXI_0_wlast_d    <= S_AXI_0_wlast;
      S_AXI_0_wready_d   <= S_AXI_0_wready;
      S_AXI_0_wstrb_d    <= S_AXI_0_wstrb;
      S_AXI_0_wvalid_d   <= S_AXI_0_wvalid;
      
      S_AXI_1_araddr_d   <= S_AXI_1_araddr;
      S_AXI_1_arburst_d  <= S_AXI_1_arburst;
      S_AXI_1_arcache_d  <= S_AXI_1_arcache;
      S_AXI_1_arlen_d    <= S_AXI_1_arlen;
      S_AXI_1_arlock_d   <= S_AXI_1_arlock;
      S_AXI_1_arprot_d   <= S_AXI_1_arprot;
      S_AXI_1_arqos_d    <= S_AXI_1_arqos;
      S_AXI_1_arready_d  <= S_AXI_1_arready;
      S_AXI_1_arregion_d <= S_AXI_1_arregion;
      S_AXI_1_arsize_d   <= S_AXI_1_arsize;
      S_AXI_1_arvalid_d  <= S_AXI_1_arvalid;
      S_AXI_1_awaddr_d   <= S_AXI_1_awaddr;
      S_AXI_1_awburst_d  <= S_AXI_1_awburst;
      S_AXI_1_awcache_d  <= S_AXI_1_awcache;
      S_AXI_1_awlen_d    <= S_AXI_1_awlen;
      S_AXI_1_awlock_d   <= S_AXI_1_awlock;
      S_AXI_1_awprot_d   <= S_AXI_1_awprot;
      S_AXI_1_awqos_d    <= S_AXI_1_awqos;
      S_AXI_1_awready_d  <= S_AXI_1_awready;
      S_AXI_1_awregion_d <= S_AXI_1_awregion;
      S_AXI_1_awsize_d   <= S_AXI_1_awsize;
      S_AXI_1_awvalid_d  <= S_AXI_1_awvalid;
      S_AXI_1_bready_d   <= S_AXI_1_bready;
      S_AXI_1_bresp_d    <= S_AXI_1_bresp;
      S_AXI_1_bvalid_d   <= S_AXI_1_bvalid;
      S_AXI_1_rdata_d    <= S_AXI_1_rdata;
      S_AXI_1_rlast_d    <= S_AXI_1_rlast;
      S_AXI_1_rready_d   <= S_AXI_1_rready;
      S_AXI_1_rresp_d    <= S_AXI_1_rresp;
      S_AXI_1_rvalid_d   <= S_AXI_1_rvalid;
      S_AXI_1_wdata_d    <= S_AXI_1_wdata;
      S_AXI_1_wlast_d    <= S_AXI_1_wlast;
      S_AXI_1_wready_d   <= S_AXI_1_wready;
      S_AXI_1_wstrb_d    <= S_AXI_1_wstrb;
      S_AXI_1_wvalid_d   <= S_AXI_1_wvalid;
      
      bram_copy_addr0_d  <= bram_copy_addr0;
      bram_copy_dout0_d  <= bram_copy_dout0;
      bram_copy_din0_d   <= bram_copy_din0;
      bram_copy_we0_d    <= bram_copy_we0;
      bram_copy_oe0_d    <= bram_copy_oe0;
      bram_copy_addr1_d  <= bram_copy_addr1;
      bram_copy_dout1_d  <= bram_copy_dout1;
      bram_copy_din1_d   <= bram_copy_din1;
      bram_copy_we1_d    <= bram_copy_we1;
      bram_copy_oe1_d    <= bram_copy_oe1;
      bram_copy_0_to_1_d <= bram_copy_0_to_1;
      bram_copy_1_to_0_d <= bram_copy_1_to_0;
      bram_copy_num_d    <= bram_copy_num;
      bram_copy_kick_d   <= bram_copy_kick;
      bram_copy_busy_d   <= bram_copy_busy;
      
    end if;
  end process;
  
  process(user_clk)
  begin
    if user_clk'event and user_clk = '1' then
      if to_integer(ahci_test_status) = 4 then
        performance_counter <= (others => '0');
      else
        performance_counter <= performance_counter + 1;
      end if;
    end if;
  end process;

  U_BRAM_COPY: bram_copy port map(
    clk => user_clk,
    reset => not user_reset_n,
    
    addr0 => bram_copy_addr0,
    dout0 => bram_copy_dout0,
    din0  => bram_copy_din0,
    we0   => bram_copy_we0,
    oe0   => bram_copy_oe0,
    
    addr1 => bram_copy_addr1,
    dout1 => bram_copy_dout1,
    din1  => bram_copy_din1,
    we1   => bram_copy_we1,
    oe1   => bram_copy_oe1,
    
    copy_0_to_1 => bram_copy_0_to_1,
    copy_1_to_0 => bram_copy_1_to_0,
    copy_num    => bram_copy_num,
    
    kick => bram_copy_kick,
    busy => bram_copy_busy
    );
  
end STRUCTURE;
