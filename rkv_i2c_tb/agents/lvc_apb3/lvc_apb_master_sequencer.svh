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
`ifndef LVC_APB_MASTER_SEQUENCER_SVH
`define LVC_APB_MASTER_SEQUENCER_SVH

class lvc_apb_master_sequencer extends uvm_sequencer #(lvc_apb_transfer);

  //////////////////////////////////////////////////////////////////////////////
  //
  //  Public interface (Component users may manipulate these fields/methods)
  //
  //////////////////////////////////////////////////////////////////////////////
  lvc_apb_config cfg;

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(lvc_apb_master_sequencer)
     // USER: Register fields 
  `uvm_component_utils_end

  // new - constructor
  extern function new (string name, uvm_component parent);

  //////////////////////////////////////////////////////////////////////////////
  //
  //  Implementation (private) interface
  //
  //////////////////////////////////////////////////////////////////////////////

  // The virtual interface used to drive and view HDL signals.
  virtual lvc_apb_if vif;

endclass : lvc_apb_master_sequencer

`endif // LVC_APB_MASTER_SEQUENCER_SVH


