
`ifndef RKV_APB_BASE_SEQUENCE_SV
`define RKV_APB_BASE_SEQUENCE_SV

virtual class rkv_apb_base_sequence extends uvm_sequence #(lvc_apb_transfer);

  ral_block_rkv_i2c rgm;

  // WRITE/READ data packet content
  rand bit [7:0] packet[];
  rand int intr_id = 0;

  // RGM register field value
  rand int SPEED = -1;
  rand int IC_10BITADDR_MASTER = -1;
  rand int IC_RESTART_EN = -1;
  rand int TX_EMPTY_CTRL = -1;
  rand int MASTER_MODE = -1;
  rand int IC_SLAVE_DISABLE = -1;
  rand int SPECIAL = -1;
  rand int GC_OR_START = -1;
  rand int IC_TAR = -1;
  rand int IC_FS_SCL_HCNT = -1;
  rand int IC_FS_SCL_LCNT = -1;
  rand int TX_CMD_BLOCK = -1;
  rand int ABORT = -1;
  rand int ENABLE = -1;
  rand int DAT = -1;
  rand int CMD = -1;
  rand int IC_SAR = -1;
  rand int RX_TL = -1;
  rand int TX_TL = -1;
  rand int M_RESTART_DET = -1;
  rand int M_START_DET = -1;
  rand int M_STOP_DET = -1;
  rand int M_ACTIVITY = -1;
  
  `uvm_declare_p_sequencer(lvc_apb_master_sequencer)

  // Register model variables:
  uvm_status_e status;
  rand uvm_reg_data_t data;

  function new (string name = "rkv_apb_base_sequence");
    super.new(name);
  endfunction

  virtual task body();
    if(!uvm_config_db #(ral_block_rkv_i2c)::get(m_sequencer, "", "rgm", rgm)) begin
      `uvm_error("body", "Unable to find ral_block_rkv_i2c in uvm_config_db")
    end
    // TODO
    // Attach element sequences below
  endtask

  virtual task update_regs(uvm_reg regs[]);
    uvm_status_e status;
    foreach(regs[i]) regs[i].update(status);
  endtask
endclass

`endif // RKV_APB_BASE_SEQUENCE_SV
