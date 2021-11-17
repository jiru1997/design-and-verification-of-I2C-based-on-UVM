//=======================================================================
// COPYRIGHT (C) 2018-2020 RockerIC, Ltd.
// This software and the associated documentation are confidential and
// proprietary to RockerIC, Ltd. Your use or disclosure of this software
// is subject to the terms and conditions of a consulting agreement
// between you, or your company, and RockerIC, Ltd. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
// VisitUs  : www.rockeric.com
// Support  : support@rockeric.com
// WeChat   : eva_bill 
//-----------------------------------------------------------------------

`ifndef LVC_I2C_MASTER_DRIVER_CALLBACK_SV
`define LVC_I2C_MASTER_DRIVER_CALLBACK_SV

typedef lvc_i2c_master_driver;

class lvc_i2c_master_driver_callback extends uvm_callback;
  `uvm_object_utils(lvc_i2c_master_driver_callback)
  function new(string name = "lvc_i2c_master_driver_callback");
    super.new(name);
  endfunction
  //------------------------------------------------------------------
  // define virtual methods below which later to be executed in
  // lvc_i2c_master_driver
  //------------------------------------------------------------------
  virtual function void post_seq_item_get(lvc_i2c_master_driver driver,lvc_i2c_master_transaction xact, ref bit drop);
  endfunction
endclass


`endif // LVC_I2C_MASTER_DRIVER_CALLBACK_SV
