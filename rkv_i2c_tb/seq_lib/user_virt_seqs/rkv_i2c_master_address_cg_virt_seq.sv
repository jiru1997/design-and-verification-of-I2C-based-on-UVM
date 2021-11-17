`ifndef RKV_I2C_ADDRESS_CG_VIRT_SEQ_SV
`define RKV_I2C_ADDRESS_CG_VIRT_SEQ_SV
class rkv_i2c_master_address_cg_virt_seq extends rkv_i2c_base_virtual_sequence;
  int i;
  bit [9:0] address[] = '{10'b1001110011,`LVC_I2C_SLAVE0_ADDRESS,10'b0001110011,10'b0110110011};
  `uvm_object_utils(rkv_i2c_master_address_cg_virt_seq)
  function new (string name = "rkv_i2c_address_virt_seq");
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
                    IC_FS_SCL_HCNT == 200;
                    IC_FS_SCL_LCNT == 200;
                  })

    for(i=0;i<2;i++) begin
      `uvm_do_on_with(apb_cfg_seq, 
                    p_sequencer.apb_mst_sqr,
                    {
                    IC_10BITADDR_MASTER == i;
                  })
      if(i == 1) cfg.i2c_cfg.slave_cfg[0].enable_10bit_addr = 1; 
      foreach(address[j]) begin
        cfg.i2c_cfg.slave_cfg[0].slave_address = address[j];
        env.i2c_slv.reconfigure_via_task(cfg.i2c_cfg.slave_cfg[0]);
        `uvm_do_on_with(apb_user_address_check_seq,p_sequencer.apb_mst_sqr,{ADDR == address[j];})
        
        `uvm_do_on_with(apb_write_packet_seq, 
                      p_sequencer.apb_mst_sqr,
                      {packet.size() == 1;
                      packet[0] == 8'b11110001;
                       })
        `uvm_do_on(i2c_slv_write_resp_seq,p_sequencer.i2c_slv_sqr)

        `uvm_do_on_with(apb_user_address_check_seq,p_sequencer.apb_mst_sqr,{ADDR == (address[j] + 1'b1);})

        `uvm_do_on_with(apb_write_packet_seq, 
                       p_sequencer.apb_mst_sqr,
                       {packet.size() == 1;
                         packet[0] == 8'b11110010;
                        })
        tx_abrt_check();

        rgm.IC_ENABLE.ENABLE.set(0);
        rgm.IC_ENABLE.update(status);
        #10us;
      end
   end
    foreach(address[j]) begin
      rgm.IC_ENABLE.ENABLE.set(0);
      rgm.IC_ENABLE.update(status);
      rgm.IC_SAR.IC_SAR.set(address[j]);
      rgm.IC_SAR.update(status);
      rgm.IC_ENABLE.ENABLE.set(1);
      rgm.IC_ENABLE.update(status);
    end


    // Attach element sequences below
    `uvm_info(get_type_name(), "=====================FINISHED=====================", UVM_LOW)
  endtask
  task tx_abrt_check();
    while(1) begin
      @(posedge vif.i2c_clk)
      if(vif.intr[3] == 1) begin
        rgm.IC_TX_ABRT_SOURCE.mirror(status); 
        `uvm_do_on_with(apb_intr_clear_seq,
                       p_sequencer.apb_mst_sqr,
                       {intr_id == IC_TX_ABRT_INTR_ID;
                       })

        break;
      end
    end
  endtask
endclass
`endif
