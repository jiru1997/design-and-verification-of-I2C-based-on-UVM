`ifndef RKV_I2C_QUICK_REG_ACCESS_VIRT_SEQ_SV
`define RKV_I2C_QUICK_REG_ACCESS_VIRT_SEQ_SV
class rkv_i2c_quick_reg_access_virt_seq extends rkv_i2c_base_virtual_sequence;

  `uvm_object_utils(rkv_i2c_quick_reg_access_virt_seq)

  function new (string name = "rkv_i2c_quick_reg_access_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "=====================STARTED=====================", UVM_LOW)
    super.body();
    vif.wait_rstn_release();
    vif.wait_apb(10);

    // TODO
    rgm.IC_CON.SPEED.set('h2);

    rgm.IC_TAR.IC_TAR.set(`LVC_I2C_SLAVE0_ADDRESS);
    // SCL_HCNT + SCL_LCNT = I2C baud clock T 
    // 2us + 2us -> 1000/4 = 250Kb/s
    rgm.IC_FS_SCL_HCNT.set(200); // 2us 

    rgm.IC_FS_SCL_LCNT.set(200); // 2us

    rgm.IC_ENABLE.ENABLE.set('h1);

    rgm.IC_DATA_CMD.DAT.set(8'b1100_1100);
    rgm.IC_DATA_CMD.CMD.set('h0); // WRITE=0, READ=1

    update_regs('{rgm.IC_CON, 
                  rgm.IC_TAR, 
                  rgm.IC_FS_SCL_HCNT, 
                  rgm.IC_FS_SCL_LCNT, 
                  rgm.IC_ENABLE, 
                  rgm.IC_DATA_CMD
                });

    rgm.IC_ENABLE.mirror(status, UVM_CHECK);
    // Attach element sequences below
    `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
  endtask

endclass
`endif // RKV_I2C_QUICK_REG_ACCESS_VIRT_SEQ_SV
