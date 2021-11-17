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


`ifndef LVC_I2C_SEQUENCER_SVH
`define LVC_I2C_SEQUENCER_SVH

class lvc_i2c_sequencer #(type REQ=lvc_i2c_transaction,
                         type RSP=REQ) extends uvm_sequencer #(REQ,RSP);

  bit  manage_objection = 1;

  uvm_report_object reporter = this;

  protected bit is_running;

  local string xact_type;


  //////////////////////////////////////////////////////////////////////////////
  //
  //  Public interface (Component users may manipulate these fields/methods)
  //
  //////////////////////////////////////////////////////////////////////////////
  //lvc_i2c_configuration cfg;

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(lvc_i2c_sequencer)
  `uvm_component_utils_end

  // new - constructor
  extern function new (string name="lvc_i2c_sequencer",uvm_component parent=null);

  //////////////////////////////////////////////////////////////////////////////
  //
  //  Implementation (private) interface
  //
  //////////////////////////////////////////////////////////////////////////////

endclass : lvc_i2c_sequencer

function lvc_i2c_sequencer::new(string name="lvc_i2c_sequencer",uvm_component parent=null);
  super.new(name,parent);
endfunction : new

`endif // LVC_I2C_MASTER_SEQUENCER_SVH


