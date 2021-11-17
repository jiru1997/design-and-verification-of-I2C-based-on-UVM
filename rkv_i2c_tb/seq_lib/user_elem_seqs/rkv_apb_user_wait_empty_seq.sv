
`ifndef RKV_APB_USER_WAIT_EMPTY_SEQ_SV
`define RKV_APB_USER_WAIT_EMPTY_SEQ_SV

class rkv_apb_user_wait_empty_seq extends rkv_apb_base_sequence;

  `uvm_object_utils(rkv_apb_user_wait_empty_seq)

  function new (string name = "rkv_apb_user_wait_empty_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();

    while(1) begin
      rgm.IC_STATUS.mirror(status);
      if(rgm.IC_STATUS.ACTIVITY.get() == 0 && rgm.IC_STATUS.TFE.get() == 1 && rgm.IC_STATUS.RFNE.get == 0) break;
      repeat(100) @(p_sequencer.vif.cb_mon);
    end

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_APB_USER_WAIT_EMPTY_SEQ_SV
