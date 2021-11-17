
`ifndef RKV_I2C_BASE_SEQUENCE_SV
`define RKV_I2C_BASE_SEQUENCE_SV

virtual class rkv_i2c_base_sequence extends uvm_sequence #(lvc_i2c_slave_transaction);

  ral_block_rkv_i2c rgm;

  lvc_i2c_configuration cfg;

  `uvm_declare_p_sequencer(lvc_i2c_master_sequencer)

  // Register model variables:
  uvm_status_e status;
  rand uvm_reg_data_t data;

  virtual task pre_body();
    if(!uvm_config_db #(ral_block_rkv_i2c)::get(m_sequencer, "", "rgm", rgm)) begin
      `uvm_error("body", "Unable to find ral_block_rkv_i2c in uvm_config_db")
    end
    p_sequencer.get_cfg(cfg);
  endtask
endclass


`endif // RKV_I2C_BASE_SEQUENCE_SV
