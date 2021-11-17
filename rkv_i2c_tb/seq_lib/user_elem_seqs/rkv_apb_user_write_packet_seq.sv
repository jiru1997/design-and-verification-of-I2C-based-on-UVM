
`ifndef RKV_APB_USER_WRITE_PACKET_SEQ_SV
`define RKV_APB_USER_WRITE_PACKET_SEQ_SV

class rkv_apb_user_write_packet_seq extends rkv_apb_base_sequence;

  `uvm_object_utils(rkv_apb_user_write_packet_seq)

  constraint def_cstr {
    soft packet.size() == 1;
  }

  function new (string name = "rkv_apb_user_write_packet_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();

    foreach(packet[i]) begin
      rgm.IC_DATA_CMD.DAT.set(packet[i]);
      rgm.IC_DATA_CMD.CMD.set(RGM_WRITE); 
      rgm.IC_DATA_CMD.write(status, rgm.IC_DATA_CMD.get());
    end

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_APB_USER_WRITE_PACKET_SEQ_SV
