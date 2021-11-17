

`ifndef RKV_I2C_VIRTUAL_SEQUENCER_SV
`define RKV_I2C_VIRTUAL_SEQUENCER_SV

class rkv_i2c_virtual_sequencer extends uvm_sequencer;
  lvc_apb_master_sequencer apb_mst_sqr;
  lvc_i2c_master_sequencer i2c_mst_sqr;
  lvc_i2c_slave_sequencer i2c_slv_sqr;
  rkv_i2c_config cfg;
  ral_block_rkv_i2c rgm;
  virtual rkv_i2c_if vif;

  `uvm_component_utils(rkv_i2c_virtual_sequencer)

  function new (string name = "rkv_i2c_virtual_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(rkv_i2c_config)::get(this, "", "cfg", cfg)) begin
      `uvm_error("build_phase", "Unable to get rkv_i2c_config from uvm_config_db")
    end
    vif = cfg.vif;
    rgm = cfg.rgm;
  endfunction

endclass

`endif // RKV_I2C_VIRTUAL_SEQUENCER_SV
