
`ifndef RKV_I2C_SLAVE_READ_RESPONSE_SEQ_SV
`define RKV_I2C_SLAVE_READ_RESPONSE_SEQ_SV

class rkv_i2c_slave_read_response_seq extends rkv_i2c_slave_base_sequence;

  `uvm_object_utils(rkv_i2c_slave_read_response_seq)

  constraint def_cstr {
    soft packet.size() == 1;
    soft nack_addr == 0;
    soft nack_data == 0;
    soft nack_addr_count == 0;
  }

  function new (string name = "rkv_apb_config_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entering...", UVM_HIGH)
    super.body();

    `uvm_do_with(req,  
                {local::nack_addr >= 0 -> nack_addr == local::nack_addr;
                 local::nack_data >= 0 -> nack_data == local::nack_data;
                 local::nack_addr_count >= 0-> nack_addr_count == local::nack_addr_count;
                 data.size() == local::packet.size();
                 foreach(data[i]) if(local::packet[i] >= 0) data[i] == packet[i];
                })

    if(cfg.enable_put_response == 1) get_response(rsp);

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask

endclass

`endif // RKV_I2C_SLAVE_READ_RESPONSE_SEQ_SV
