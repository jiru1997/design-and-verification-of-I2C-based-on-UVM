`ifndef RKV_I2C_MASTER_ABRT_TXDATA_NOACK_VIRT_SEQ_SV
`define RKV_I2C_MASTER_ABRT_TXDATA_NOACK_VIRT_SEQ_SV

class rkv_i2c_master_abrt_txdata_noack_virt_seq extends rkv_i2c_base_virtual_sequence;

  `uvm_object_utils(rkv_i2c_master_abrt_txdata_noack_virt_seq)

  function new (string name = "rkv_i2c_master_abrt_txdata_noack_virt_seq");
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
    `uvm_do_on_with(apb_write_packet_seq, 
                      p_sequencer.apb_mst_sqr,
                      {packet.size() == 2;
                      packet[0] == 8'b11110000;
                      packet[1] == 8'b11110001;
                       })
    `uvm_do_on_with(i2c_slv_write_resp_seq,p_sequencer.i2c_slv_sqr,{nack_data == 1;})      
  
    `uvm_do_on_with(apb_intr_wait_seq,
                    p_sequencer.apb_mst_sqr,
                   {intr_id == IC_TX_ABRT_INTR_ID;
                   })
    tx_abrt_check();

    // check if interrupt output is same as interrupt status field
    if(vif.get_intr(IC_TX_ABRT_INTR_ID) !== 1'b1)
      begin
        `uvm_error("INTRERR", "interrupt output IC_TX_ABRT_INTR_ID is not high")
      end
      else begin
        `uvm_do_on_with(apb_intr_clear_seq,p_sequencer.apb_mst_sqr,{intr_id == IC_TX_ABRT_INTR_ID;})
        repeat(100) @(p_sequencer.vif.i2c_clk);
        `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
    end
    // Attach element sequences below
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
`endif // RKV_I2C_MASTER_ABRT_TXDATA_NOACK_VIRT_SEQ_SV
