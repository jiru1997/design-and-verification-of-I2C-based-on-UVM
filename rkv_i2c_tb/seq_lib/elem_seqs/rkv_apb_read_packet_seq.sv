`ifndef RKV_APB_READ_PACKET_SEQ_SV
`define RKV_APB_READ_PACKET_SEQ_SV

class rkv_apb_read_packet_seq extends rkv_apb_base_sequence;

  typedef enum {NOT_EMPTY_THEN_READ, FULL_THEN_READ, DIRECTED_READ} rkv_apb_read_packet_style_t;

  rand rkv_apb_read_packet_style_t read_style = NOT_EMPTY_THEN_READ;

  `uvm_object_utils(rkv_apb_read_packet_seq)

  constraint def_cstr {
    soft packet.size() == 1;
    soft read_style == NOT_EMPTY_THEN_READ;
    packet.size inside {[1:8]}; // max RX entries is 8 
  }

  function new (string name = "rkv_apb_read_packet_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();

    foreach(packet[i]) begin
      rgm.IC_DATA_CMD.CMD.set(RGM_READ); 
      rgm.IC_DATA_CMD.DAT.set(0); 
      rgm.IC_DATA_CMD.write(status, rgm.IC_DATA_CMD.get());
    end

    if(read_style == NOT_EMPTY_THEN_READ) begin
      foreach(packet[i]) begin
        // Wait until RX FIFO is not empty
        while(1) begin
          rgm.IC_STATUS.mirror(status);
          if(rgm.IC_STATUS.RFNE.get() == 1) break;
          repeat(100) @(p_sequencer.vif.cb_mon);
        end
        
        rgm.IC_DATA_CMD.mirror(status);
        packet[i] = rgm.IC_DATA_CMD.DAT.get();
      end
    end
    else if(read_style == FULL_THEN_READ) begin
      while(1) begin
        rgm.IC_STATUS.mirror(status);
        if(rgm.IC_STATUS.RFF.get() == 1) break;
        repeat(100) @(p_sequencer.vif.cb_mon);
      end
      foreach(packet[i]) begin
        rgm.IC_DATA_CMD.mirror(status);
        packet[i] = rgm.IC_DATA_CMD.DAT.get();
      end
    end
    else if(read_style == DIRECTED_READ) begin
      foreach(packet[i]) begin
        rgm.IC_DATA_CMD.mirror(status);
        packet[i] = rgm.IC_DATA_CMD.DAT.get();
      end
    end

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_APB_READ_PACKET_SEQ_SV
