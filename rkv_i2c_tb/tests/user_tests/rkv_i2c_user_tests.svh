
`ifndef RKV_I2C_USER_TESTS_SVH
`define RKV_I2C_USER_TESTS_SVH

// cg test
`include "rkv_i2c_master_sda_control_cg_test.sv"

`include "rkv_i2c_master_address_cg_test.sv"
`include "rkv_i2c_master_enabled_cg_test.sv"
`include "rkv_i2c_master_timeout_cg_test.sv"

// function test
`include "rkv_i2c_master_start_byte_test.sv"
`include "rkv_i2c_master_hs_master_code_test.sv"

// interrupt test
`include "rkv_i2c_master_tx_empty_intr_test.sv"
`include "rkv_i2c_master_rx_over_intr_test.sv"
`include "rkv_i2c_master_rx_full_intr_test.sv"
`include "rkv_i2c_master_tx_abrt_intr_test.sv"
`include "rkv_i2c_master_tx_full_intr_test.sv"
`include "rkv_i2c_master_activity_intr_output_test.sv"

//	abort test
`include "rkv_i2c_master_abrt_7b_addr_noack_test.sv"
`include "rkv_i2c_master_abrt_sbyte_norstrt_test.sv"
`include "rkv_i2c_master_abrt_txdata_noack_test.sv"
`include "rkv_i2c_master_abrt_10b_rd_norstrt_test.sv"

// cnt seq
`include "rkv_i2c_master_ss_cnt_test.sv"
`include "rkv_i2c_master_fs_cnt_test.sv"
`include "rkv_i2c_master_hs_cnt_test.sv"

//other test

`endif // RKV_I2C_USER_TESTS_SVH

