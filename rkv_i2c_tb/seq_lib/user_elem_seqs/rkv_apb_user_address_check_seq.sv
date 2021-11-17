
`ifndef RKV_APB_USER_ADDRESS_CHECK_SEQ_SV
`define RKV_APB_USER_ADDRESS_CHECK_SEQ_SV

class rkv_apb_user_address_check_seq extends rkv_apb_base_sequence;

  `uvm_object_utils(rkv_apb_user_address_check_seq)
  rand bit [9:0] ADDR = -1;
  
  constraint def_cstr {
    soft ADDR == -1;
  }

  function new (string name = "rkv_apb_user_address_check_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();
    rgm.IC_ENABLE.set(0);
    rgm.IC_ENABLE.update(status);
    if(ADDR >= 0) rgm.IC_TAR.set(ADDR);
    rgm.IC_TAR.update(status);
    rgm.IC_ENABLE.ENABLE.set('h1);
    rgm.IC_ENABLE.update(status);

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_APB_USER_ADDRESS_CHECK_SEQ_SV
