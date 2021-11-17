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
`ifndef LVC_APB_MASTER_AGENT_SVH
`define LVC_APB_MASTER_AGENT_SVH

class lvc_apb_master_agent extends uvm_agent;

  //////////////////////////////////////////////////////////////////////////////
  //
  //  Public interface (Component users may manipulate these fields/methods)
  //
  //////////////////////////////////////////////////////////////////////////////
  lvc_apb_config cfg;

  // The following are the verification components that make up
  // this agent
  lvc_apb_master_driver driver;
  lvc_apb_master_sequencer sequencer;
  lvc_apb_master_monitor monitor;
  virtual lvc_apb_if vif;

  // USER: Add your fields here

  // This macro performs UVM object creation, type control manipulation, and 
  // factory registration
  `uvm_component_utils_begin(lvc_apb_master_agent)
    // USER: Register your fields here
  `uvm_component_utils_end

  // new - constructor
  extern function new (string name, uvm_component parent);

  // uvm build phase
  extern function void build();

  // uvm connection phase
  extern function void connect();
  
  // This method assigns the virtual interfaces to the agent's children
  extern function void assign_vi(virtual lvc_apb_if vif);

  //////////////////////////////////////////////////////////////////////////////
  //
  //  Implementation (private) interface
  //
  //////////////////////////////////////////////////////////////////////////////


endclass : lvc_apb_master_agent

`endif // LVC_APB_MASTER_AGENT_SVH

