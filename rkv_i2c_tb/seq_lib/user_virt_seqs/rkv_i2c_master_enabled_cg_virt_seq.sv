`ifndef RKV_I2C_ENABLED_CG_VIRT_SEQ_SV
`define RKV_I2C_ENABLED_CG_VIRT_SEQ_SV
class rkv_i2c_master_enabled_cg_virt_seq extends rkv_i2c_base_virtual_sequence;

  `uvm_object_utils(rkv_i2c_master_enabled_cg_virt_seq)

  function new (string name = "rkv_i2c_master_enabled_cg_virt_seq");
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
                  })
    //disable then write
    rgm.IC_ENABLE.ENABLE.set(0);
    rgm.IC_ENABLE.update(status);
    // APB bus not blocked, and data lost
    // NO I2C TX data out, and no need to give 
    // i2c write response sequence
    `uvm_do_on_with(apb_write_packet_seq, 
                  p_sequencer.apb_mst_sqr,
                  {packet.size() == 1;
                  packet[0] == 8'b11110000;
                   })
    rgm.IC_STATUS.mirror(status);

    //enable then write,disable before send to i2c
    rgm.IC_ENABLE.ENABLE.set(1);
    rgm.IC_ENABLE.update(status);
    
    `uvm_do_on_with(apb_write_packet_seq, 
                    p_sequencer.apb_mst_sqr,
                    {packet.size() == 2;
                    packet[0] == 8'b11110001;
                    packet[1] == 8'b11110010;
                     })
    rgm.IC_STATUS.mirror(status);
    rgm.IC_ENABLE.ENABLE.set(0);
    rgm.IC_ENABLE.update(status);
    rgm.IC_STATUS.mirror(status);


    `uvm_do_on_with(apb_noread_packet_seq,p_sequencer.apb_mst_sqr,{packet.size() == 1;})
    #10us;
    rgm.IC_STATUS.mirror(status);

    //disable between data receive
    rgm.IC_ENABLE.ENABLE.set(1);
    rgm.IC_ENABLE.update(status);
    fork
      `uvm_do_on_with(apb_noread_packet_seq,p_sequencer.apb_mst_sqr,{packet.size() == 3;})
      `uvm_do_on_with(i2c_slv_read_resp_seq, 
                      p_sequencer.i2c_slv_sqr,
                      {packet.size() == 1;
                       packet[0] == 8'b00001111;
                       })
    join_none
    while(1) begin
      rgm.IC_STATUS.mirror(status);
      if(rgm.IC_STATUS.RFNE.get() == 1) begin
        rgm.IC_ENABLE.ENABLE.set(0);
        rgm.IC_ENABLE.update(status);
        rgm.IC_STATUS.mirror(status);
        break;
      end
    end
    #1us;
    //after disable change to write
    rgm.IC_ENABLE.ENABLE.set(1);
    rgm.IC_ENABLE.update(status);
    #10us;
    fork
      `uvm_do_on_with(apb_write_packet_seq, 
                      p_sequencer.apb_mst_sqr,
                      {packet.size() == 1;
                      packet[0] == 8'b11110001;
                       })
     `uvm_do_on(i2c_slv_write_resp_seq,p_sequencer.i2c_slv_sqr)   
    join_any
    rgm.IC_STATUS.mirror(status);
    `uvm_do_on(apb_wait_empty_seq, p_sequencer.apb_mst_sqr)   
    #1us;
    `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
  endtask
endclass
`endif // RKV_I2C_ENABLED_CG_VIRT_SEQ_SV
