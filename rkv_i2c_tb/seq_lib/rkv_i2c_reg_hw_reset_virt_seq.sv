`ifndef RKV_I2C_REG_HW_RESET_VIRT_SEQ_SV
`define RKV_I2C_REG_HW_RESET_VIRT_SEQ_SV
class rkv_i2c_reg_hw_reset_virt_seq extends rkv_i2c_base_virtual_sequence;

  `uvm_object_utils(rkv_i2c_reg_hw_reset_virt_seq)

  function new (string name = "rkv_i2c_reg_hw_reset_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "=====================STARTED=====================", UVM_LOW)
    super.body();
    vif.wait_rstn_release();
    vif.wait_apb(10);

    // TODO
     reg_rst_seq = new();
    `uvm_info(get_type_name(), "Register reset sequence started", UVM_LOW)
    rgm.reset();
    reg_rst_seq.model = rgm;
    reg_rst_seq.start(m_sequencer);
    `uvm_info(get_type_name(), "Register reset sequence finished", UVM_LOW)

    rgm.IC_ENABLE.ENABLE.set(1);
    rgm.IC_ENABLE.update(status);

    #10us


    // Attach element sequences below
    `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
  endtask

endclass
`endif // RKV_I2C_REG_HW_RESET_VIRT_SEQ_SV
