`ifndef RKV_I2C_MASTER_TIMEOUT_CG_VIRT_SEQ_SV
`define RKV_I2C_MASTER_TIMEOUT_CG_VIRT_SEQ_SV
class rkv_i2c_master_timeout_cg_virt_seq extends rkv_i2c_base_virtual_sequence;

  `uvm_object_utils(rkv_i2c_master_timeout_cg_virt_seq)
  
  bit [3:0] timeout[] = '{4'b0001,4'b0111,4'b1100};

  function new (string name = "rkv_i2c_master_timeout_cg_virt_seq");
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
   
    foreach(timeout[i]) begin
      rgm.REG_TIMEOUT_RST_REG_TIMEOUT_RST_rw.set(timeout[i]);
      rgm.REG_TIMEOUT_RST.update(status);
      rgm.IC_ENABLE_ENABLE.set(1);
      rgm.IC_ENABLE.update(status);
      `uvm_do_on_with(apb_write_nocheck_packet_seq, 
                    p_sequencer.apb_mst_sqr,
                   {packet.size() == 9; 
                    foreach(packet[j]) packet[j] == 8'b0000_0000 + j;
                   })
       
      `uvm_do_on(i2c_slv_write_resp_seq,p_sequencer.i2c_slv_sqr)
      rgm.IC_ENABLE_ENABLE.set(0);
      rgm.IC_ENABLE.update(status);
    end

    #10us;

    // Attach element sequences below
    `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
  endtask

endclass
`endif // RKV_I2C_TX_FULL_VIRT_SEQ_SV
