`ifndef RKV_APB_INTR_ENABLE_SEQ_SV
`define RKV_APB_INTR_ENABLE_SEQ_SV

class rkv_apb_intr_enable_seq extends rkv_apb_base_sequence;

  `uvm_object_utils(rkv_apb_intr_enable_seq)


  function new (string name = "rkv_apb_intr_enable_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();


    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_APB_INTR_ENABLE_SEQ_SV
