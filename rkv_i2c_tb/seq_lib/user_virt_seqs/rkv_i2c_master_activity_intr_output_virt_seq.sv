`ifndef RKV_I2C_ACTIVITY_INTR_OUTPUT_VIRT_SEQ_SV
`define RKV_I2C_ACTIVITY_INTR_OUTPUT_VIRT_SEQ_SV
class rkv_i2c_master_activity_intr_output_virt_seq extends rkv_i2c_base_virtual_sequence;

  `uvm_object_utils(rkv_i2c_master_activity_intr_output_virt_seq)

  function new (string name = "rkv_i2c_master_activity_intr_output_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "=====================STARTED=====================", UVM_LOW)
    super.body();
    vif.wait_rstn_release();
    vif.wait_apb(10);

    `uvm_do_on_with(apb_cfg_seq, 
                    p_sequencer.apb_mst_sqr,
                    {SPEED == 2;
                    IC_10BITADDR_MASTER == 0;
                    IC_TAR == `LVC_I2C_SLAVE0_ADDRESS;
                    IC_FS_SCL_HCNT == 200;
                    IC_FS_SCL_LCNT == 200;
                    ENABLE == 1;
                  })
    rgm.IC_INTR_MASK.M_ACTIVITY.set(1);
    rgm.IC_INTR_MASK.M_START_DET.set(1);
    rgm.IC_INTR_MASK.M_STOP_DET.set(1);
    rgm.IC_INTR_MASK.update(status);
    
    `uvm_do_on_with(apb_write_packet_seq, 
                    p_sequencer.apb_mst_sqr,
                   {packet.size() == 2; 
                    packet[0] == 8'b1111_0000;
                    packet[1] == 8'b0101_0101;
                   })
                  
    `uvm_do_on(i2c_slv_write_resp_seq,p_sequencer.i2c_slv_sqr)
    `uvm_do_on_with(apb_intr_wait_seq,
                    p_sequencer.apb_mst_sqr,
                   {intr_id == IC_ACTIVITY_INTR_ID;
                   })

    // check if interrupt output is same as interrupt status field
    if(vif.get_intr(IC_ACTIVITY_INTR_ID) !== 1'b1)
      `uvm_error("INTRERR", "interrupt output IC_ACTIVITY_INTR_ID is not high")
    
    `uvm_do_on_with(apb_intr_clear_seq,p_sequencer.apb_mst_sqr,{intr_id == IC_ACTIVITY_INTR_ID;})
    `uvm_do_on_with(apb_intr_clear_seq,p_sequencer.apb_mst_sqr,{intr_id == IC_START_DET_INTR_ID;})
    `uvm_do_on_with(apb_intr_clear_seq,p_sequencer.apb_mst_sqr,{intr_id == IC_STOP_DET_INTR_ID;})
   
    `uvm_do_on(apb_wait_empty_seq, p_sequencer.apb_mst_sqr)

    #10us;

    // Attach element sequences below
    `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
  endtask

endclass
`endif // RKV_I2C_MASTER_DIRECTED_WRITE_PACKET_VIRT_SEQ_SV
