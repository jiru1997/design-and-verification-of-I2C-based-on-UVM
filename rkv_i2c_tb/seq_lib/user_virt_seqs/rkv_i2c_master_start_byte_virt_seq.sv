
`ifndef RKV_I2C_USER_MASTER_START_BYTE_VIRT_SEQ_SV
`define RKV_I2C_USER_MASTER_START_BYTE_VIRT_SEQ_SV

class rkv_i2c_master_start_byte_virt_seq extends rkv_i2c_base_virtual_sequence;

  `uvm_object_utils(rkv_i2c_master_start_byte_virt_seq)

  function new (string name = "rkv_i2c_master_start_byte_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "=====================STARTED=====================", UVM_LOW)
    super.body();
    vif.wait_rstn_release();
    vif.wait_apb(10);

    // Write some data and wait TX EMPTY interupt
    `uvm_do_on_with(apb_user_cfg_seq, 
                    p_sequencer.apb_mst_sqr,
                    {SPEED == 2;
                    IC_10BITADDR_MASTER == 0;
                    TX_EMPTY_CTRL == 1;
                    IC_TAR == `LVC_I2C_SLAVE0_ADDRESS;
                    SPECIAL == 1;
                    GC_OR_START == 1;
                    IC_FS_SCL_HCNT == 200;
                    IC_FS_SCL_LCNT == 200;
                    ENABLE == 1;
                  })

    fork
      `uvm_do_on(i2c_slv_write_resp_seq, p_sequencer.i2c_slv_sqr)
    join_none

    `uvm_do_on_with(apb_user_write_packet_seq, 
                    p_sequencer.apb_mst_sqr,
                   {packet.size() == 1; 
                    packet[0] == 8'b0101_0101;
                   })

    `uvm_do_on(apb_user_wait_empty_seq, p_sequencer.apb_mst_sqr)

    #10us;

    // Attach element sequences below
    `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
  endtask

endclass
`endif // RKV_I2C_USER_MASTER_START_BYTE_VIRT_SEQ_SV
