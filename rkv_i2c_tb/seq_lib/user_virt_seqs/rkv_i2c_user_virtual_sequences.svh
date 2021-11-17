
`ifndef RKV_I2C_USER_VIRTUAL_SEQUENCES_SVH
`define RKV_I2C_USER_VIRTUAL_SEQUENCES_SVH

// cg seq
`include "rkv_i2c_master_sda_control_cg_virt_seq.sv"

`include "rkv_i2c_master_address_cg_virt_seq.sv"
`include "rkv_i2c_master_enabled_cg_virt_seq.sv"
`include "rkv_i2c_master_timeout_cg_virt_seq.sv"

// function seq
`include "rkv_i2c_master_start_byte_virt_seq.sv"
`include "rkv_i2c_master_hs_master_code_virt_seq.sv"

// intr seq
`include "rkv_i2c_master_tx_empty_intr_virt_seq.sv"
`include "rkv_i2c_master_rx_over_intr_virt_seq.sv"
`include "rkv_i2c_master_rx_full_intr_virt_seq.sv"
`include "rkv_i2c_master_tx_abrt_intr_virt_seq.sv"
`include "rkv_i2c_master_tx_full_intr_virt_seq.sv"
`include "rkv_i2c_master_activity_intr_output_virt_seq.sv"

// abrt source seq
`include "rkv_i2c_master_abrt_7b_addr_noack_virt_seq.sv"
`include "rkv_i2c_master_abrt_sbyte_norstrt_virt_seq.sv"
`include "rkv_i2c_master_abrt_txdata_noack_virt_seq.sv"
`include "rkv_i2c_master_abrt_10b_rd_norstrt_virt_seq.sv"

// cnt seq
`include "rkv_i2c_master_ss_cnt_virt_seq.sv"
`include "rkv_i2c_master_fs_cnt_virt_seq.sv"
`include "rkv_i2c_master_hs_cnt_virt_seq.sv"

// other seq

`endif // RKV_I2C_USER_VIRTUAL_SEQUENCES_SVH

