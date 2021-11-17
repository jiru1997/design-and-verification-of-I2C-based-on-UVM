
`ifndef RKV_APB_USER_CONFIG_SEQ_SV
`define RKV_APB_USER_CONFIG_SEQ_SV

class rkv_apb_user_config_seq extends rkv_apb_base_sequence;

  `uvm_object_utils(rkv_apb_user_config_seq)

  constraint def_cstr {
    soft SPEED == -1;
    soft IC_10BITADDR_MASTER == -1;
    soft IC_RESTART_EN == -1;
    soft TX_EMPTY_CTRL == -1;
    soft MASTER_MODE == -1;
    soft IC_SLAVE_DISABLE == -1;
    soft IC_TAR == -1;
    soft SPECIAL == -1;
    soft GC_OR_START == -1;
    soft IC_FS_SCL_HCNT == -1;
    soft IC_FS_SCL_LCNT == -1;
    soft TX_CMD_BLOCK == -1;
    soft ABORT == -1;
    soft ENABLE == -1;
    soft IC_SAR == -1;
    soft RX_TL == -1;
    soft TX_TL == -1;
    soft M_RESTART_DET == -1;
    soft M_START_DET == -1;
    soft M_STOP_DET == -1;
    soft M_ACTIVITY == -1;
}

  function new (string name = "rkv_apb_user_config_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();

    if(SPEED >= 0) rgm.IC_CON.SPEED.set(SPEED);
    //rgm.IC_CON.MASTER_MODE.set('h1);
    if(IC_10BITADDR_MASTER >= 0) rgm.IC_CON.IC_10BITADDR_MASTER.set(IC_10BITADDR_MASTER);
    if(IC_RESTART_EN >= 0) rgm.IC_CON.IC_RESTART_EN.set(IC_RESTART_EN);
    if(TX_EMPTY_CTRL >= 0) rgm.IC_CON.TX_EMPTY_CTRL.set(TX_EMPTY_CTRL);
    if(MASTER_MODE >= 0) rgm.IC_CON.MASTER_MODE.set(MASTER_MODE);
    if(IC_SLAVE_DISABLE >= 0) rgm.IC_CON.IC_SLAVE_DISABLE.set(IC_SLAVE_DISABLE);
    rgm.IC_CON.update(status);

    if(IC_TAR >= 0) rgm.IC_TAR.IC_TAR.set(IC_TAR);
    if(SPECIAL >= 0) rgm.IC_TAR.SPECIAL.set(SPECIAL);
    if(GC_OR_START >= 0) rgm.IC_TAR.GC_OR_START.set(GC_OR_START);
    rgm.IC_TAR.update(status);

    if(IC_SAR >= 0) rgm.IC_SAR.IC_SAR.set(IC_SAR);
    rgm.IC_SAR.update(status);

    // SCL_HCNT + SCL_LCNT = I2C baud clock T 
    // 2us + 2us -> 1000/4 = 250Kb/s
    if(IC_FS_SCL_HCNT >= 0) rgm.IC_FS_SCL_HCNT.write(status, 200); // 2us 
    if(IC_FS_SCL_LCNT >= 0) rgm.IC_FS_SCL_LCNT.write(status, 200); // 2us

    if(RX_TL >= 0) rgm.IC_RX_TL.RX_TL.set(RX_TL);
    rgm.IC_RX_TL.update(status);

    if(TX_TL >= 0) rgm.IC_TX_TL.TX_TL.set(TX_TL);
    rgm.IC_TX_TL.update(status);

    if(M_START_DET >= 0) rgm.IC_INTR_MASK.M_START_DET.set(M_START_DET);
    if(M_STOP_DET >= 0) rgm.IC_INTR_MASK.M_STOP_DET.set(M_STOP_DET);
    if(M_ACTIVITY >= 0) rgm.IC_INTR_MASK.M_ACTIVITY.set(M_ACTIVITY);
    rgm.IC_INTR_MASK.update(status);

    if(TX_CMD_BLOCK >= 0) rgm.IC_ENABLE.TX_CMD_BLOCK.set(TX_CMD_BLOCK);
    if(ABORT >= 0) rgm.IC_ENABLE.ABORT.set(ABORT);
    if(ENABLE >= 0) rgm.IC_ENABLE.ENABLE.set(ENABLE);
    rgm.IC_ENABLE.update(status);

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_APB_USER_CONFIG_SEQ_SV
