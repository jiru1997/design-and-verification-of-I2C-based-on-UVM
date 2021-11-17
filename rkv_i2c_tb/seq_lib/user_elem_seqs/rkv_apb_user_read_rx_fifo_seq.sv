
`ifndef RKV_APB_USER_READ_RX_FIFO_SEQ_SV
`define RKV_APB_USER_READ_RX_FIFO_SEQ_SV

class rkv_apb_user_read_rx_fifo_seq extends rkv_apb_base_sequence;

  `uvm_object_utils(rkv_apb_user_read_rx_fifo_seq)

  constraint def_cstr {
    soft packet.size() == 1;
  }

  function new (string name = "rkv_apb_user_read_rx_fifo_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();

    foreach(packet[i]) begin
      rgm.IC_DATA_CMD.mirror(status);
    end

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_APB_USER_READ_RX_FIF_SEQ_SV
