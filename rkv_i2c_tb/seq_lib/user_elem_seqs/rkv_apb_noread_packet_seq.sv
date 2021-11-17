`ifndef RKV_APB_NOREAD_PACKET_SEQ_SV
`define RKV_APB_NOREAD_PACKET_SEQ_SV

class rkv_apb_noread_packet_seq extends rkv_apb_base_sequence;

  `uvm_object_utils(rkv_apb_noread_packet_seq)

  constraint def_cstr {
    soft packet.size() == 1;
  }

  function new (string name = "rkv_apb_noread_packet_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();

    foreach(packet[i]) begin
      rgm.IC_DATA_CMD.CMD.set(RGM_READ); 
      rgm.IC_DATA_CMD.DAT.set(0); 
      rgm.IC_DATA_CMD.write(status,9'b100000000);
    end

    /*foreach(packet[i]) begin
      // Wait until RX FIFO is not empty
      while(1) begin
        rgm.IC_STATUS.mirror(status);
        if(rgm.IC_STATUS.RFNE.get() == 1) break;
        repeat(100) @(p_sequencer.vif.cb_mon);
      end
      
    end*/

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_APB_NOREAD_PACKET_SEQ_SV
