
`ifndef RKV_I2C_ELEMENT_SEQUENCES_SVH
`define RKV_I2C_ELEMENT_SEQUENCES_SVH

`include "rkv_apb_base_sequence.sv"
`include "rkv_apb_config_seq.sv"
`include "rkv_apb_write_packet_seq.sv"
`include "rkv_apb_read_packet_seq.sv"
`include "rkv_apb_wait_empty_seq.sv"
`include "rkv_apb_intr_enable_seq.sv"
`include "rkv_apb_intr_wait_seq.sv"
`include "rkv_apb_intr_clear_seq.sv"

`include "rkv_i2c_base_sequence.sv"
`include "rkv_i2c_slave_base_sequence.sv"
`include "rkv_i2c_slave_write_response_seq.sv"
`include "rkv_i2c_slave_read_response_seq.sv"


`endif // RKV_I2C_ELEMENT_SEQUENCES_SVH
