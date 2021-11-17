`ifndef RKV_I2C_RX_OVER_INTR_VIRT_SEQ_SV
`define RKV_I2C_RX_OVER_INTR_VIRT_SEQ_SV

class rkv_i2c_master_rx_over_intr_virt_seq extends rkv_i2c_base_virtual_sequence;

  `uvm_object_utils(rkv_i2c_master_rx_over_intr_virt_seq)

  function new (string name = "rkv_i2c_master_rx_over_intr_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "=====================STARTED=====================", UVM_LOW)
    super.body();
    vif.wait_rstn_release();
    vif.wait_apb(10);

    // Write some data and wait TX EMPTY interupt
    `uvm_do_on_with(apb_cfg_seq, 
                    p_sequencer.apb_mst_sqr,
                    {SPEED == 2;
                    IC_10BITADDR_MASTER == 0;
                    IC_TAR == `LVC_I2C_SLAVE0_ADDRESS;
                    IC_FS_SCL_HCNT == 200;
                    IC_FS_SCL_LCNT == 200;
                    ENABLE == 1;
                  })
    
    fork
      `uvm_do_on_with(apb_noread_packet_seq,p_sequencer.apb_mst_sqr,{packet.size() == 8;})
      `uvm_do_on_with(i2c_slv_read_resp_seq, 
                      p_sequencer.i2c_slv_sqr,
                      {packet.size() == 8;
                       packet[0] == 8'b00000000;
                       packet[1] == 8'b00000001;
                       packet[2] == 8'b00000010;
                       packet[3] == 8'b00000011;
                       packet[4] == 8'b00000100;
                       packet[5] == 8'b00000101;
                       packet[6] == 8'b00000110;
                       packet[7] == 8'b00000111;
                       })
    join   
    rgm.IC_STATUS.mirror(status);
    rgm.IC_DATA_CMD.mirror(status);    
    fork
      `uvm_do_on_with(apb_noread_packet_seq,p_sequencer.apb_mst_sqr,{packet.size() == 2;})
      `uvm_do_on_with(i2c_slv_read_resp_seq, 
                      p_sequencer.i2c_slv_sqr,
                      {packet.size() == 2;
                      packet[0] == 8'b00001000;
                      packet[1] == 8'b00001001;
                     })
      tx_abrt_check();
    join_none

    `uvm_do_on_with(apb_intr_wait_seq,
                    p_sequencer.apb_mst_sqr,
                   {intr_id == IC_RX_OVER_INTR_ID;
                   })

                   
    if(vif.get_intr(IC_RX_OVER_INTR_ID) !== 1'b1) begin
      `uvm_error("INTRERR", "interrupt output IC_RX_OVER_INTR_ID is not high")
    end


    #10us;

    // Attach element sequences below
    `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
  endtask
  task tx_abrt_check();
  while(1) begin
    @(posedge vif.i2c_clk)
    if(vif.intr[3] == 1) begin
      rgm.IC_TX_ABRT_SOURCE.mirror(status); 
      break;
    end
  end
  endtask
endclass
`endif // RKV_I2C_MASTER_DIRECTED_INTERRUPT_VIRT_SEQ_S`ifndef RKV_I2C_MASTER_DIRECTED_INTERRUPT_VIRT_SEQ_SV
`define RKV_I2C_RX_OVER_INTR_VIRT_SEQ_SV


