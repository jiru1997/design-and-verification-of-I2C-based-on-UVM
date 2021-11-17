
`ifndef RKV_I2C_PKG_SV
`define RKV_I2C_PKG_SV

package rkv_i2c_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import lvc_apb_pkg::*;
  import lvc_i2c_pkg::*;
  `include "lvc_i2c_defines.svh"

  `include "ral_rkv_i2c.sv"
  `include "rkv_i2c_configs.svh"
  `include "rkv_i2c_master_scoreboard.sv"
  `include "rkv_i2c_cgm.sv"
  `include "rkv_i2c_virtual_sequencer.sv"
  `include "rkv_i2c_env.sv"
  `include "rkv_i2c_element_sequences.svh"
  `include "rkv_i2c_user_element_sequences.svh"
  `include "rkv_i2c_virtual_sequences.svh"
  `include "rkv_i2c_user_virtual_sequences.svh"
  `include "rkv_i2c_tests.svh"
  `include "rkv_i2c_user_tests.svh"

endpackage

`endif // RKV_I2C_PKG_SV
