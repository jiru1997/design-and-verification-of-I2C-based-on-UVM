
`ifndef RKV_I2C_ENV_SV
`define RKV_I2C_ENV_SV

class rkv_i2c_env extends uvm_env;

  // top configuration
  rkv_i2c_config cfg;

  virtual rkv_i2c_if vif;

  lvc_apb_master_agent apb_mst;

  lvc_i2c_master_agent i2c_mst;

  lvc_i2c_slave_agent i2c_slv;

  // top scoreboard
  rkv_i2c_master_scoreboard sbd_mst;

  // top virtual sequencer
  rkv_i2c_virtual_sequencer sqr;

  // top coverage model
  rkv_i2c_cgm cgm;

  // top register model and related components
  ral_block_rkv_i2c rgm;
  lvc_apb_reg_adapter adapter;
  uvm_reg_predictor #(lvc_apb_transfer) predictor;

  `uvm_component_utils(rkv_i2c_env)

  function new (string name = "rkv_i2c_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(rkv_i2c_config)::get(this, "", "cfg", cfg)) begin
      `uvm_error("build_phase", "Unable to get rkv_i2c_config from uvm_config_db")
    end

    if(!uvm_config_db#(virtual rkv_i2c_if)::get(this,"","vif", vif)) begin
      `uvm_error("GETVIF","cannot get rkv_i2c_if handle from config DB")
    end
    cfg.vif = vif;

    if(!uvm_config_db #(ral_block_rkv_i2c)::get(this, "", "rgm", rgm)) begin
      `uvm_info("build_phase", "Unable to get ral_block_rkv_i2c from uvm_config_db and create a RGM locally", UVM_LOW)
      rgm = ral_block_rkv_i2c::type_id::create("rgm", this);
      rgm.build();
      rgm.lock_model();
    end
    cfg.rgm = rgm;
    uvm_config_db#(ral_block_rkv_i2c)::set(this,"*","rgm", rgm);

    uvm_config_db#(lvc_apb_config)::set(this, "apb_mst*", "cfg", cfg.apb_cfg);
    //apb_mst = lvc_apb_master_agent::type_id::create("apb_mst", this);
    apb_mst = new("apb_mst", this);

    void'(uvm_config_db#(virtual lvc_i2c_if)::get(this, "", "i2c_vif", cfg.i2c_cfg.master_cfg[0].i2c_if));
    uvm_config_db#(lvc_i2c_agent_configuration)::set(this, "i2c_mst*", "cfg", cfg.i2c_cfg.master_cfg[0]);
    i2c_mst = lvc_i2c_master_agent::type_id::create("i2c_mst", this);

    void'(uvm_config_db#(virtual lvc_i2c_if)::get(this, "", "i2c_vif", cfg.i2c_cfg.slave_cfg[0].i2c_if));
    uvm_config_db#(lvc_i2c_agent_configuration)::set(this, "i2c_slv*", "cfg", cfg.i2c_cfg.slave_cfg[0]);
    i2c_slv = new("i2c_slv", this);

    uvm_config_db#(rkv_i2c_config)::set(this, "sbd_mst", "cfg", cfg);
    sbd_mst = new("sbd_mst", this);

    uvm_config_db#(rkv_i2c_config)::set(this, "sqr", "cfg", cfg);
    sqr = new("sqr", this);

    uvm_config_db#(rkv_i2c_config)::set(this, "cgm", "cfg", cfg);
    cgm = new("cgm", this);

    adapter = lvc_apb_reg_adapter::type_id::create("adapter", this);
    predictor = uvm_reg_predictor#(lvc_apb_transfer)::type_id::create("predictor", this);
  endfunction: build_phase


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // TODO
    // connect monitor analysis port to scoreboard
    apb_mst.monitor.item_collected_port.connect(sbd_mst.apb_trans_observed_imp);
    i2c_slv.monitor.xact_observed_port.connect(sbd_mst.i2c_trans_observed_imp);
      
    // TODO
    // connect monitor analysis port to coverage model
    apb_mst.monitor.item_collected_port.connect(cgm.apb_trans_observed_imp);
    i2c_slv.monitor.xact_observed_port.connect(cgm.i2c_trans_observed_imp);

    // virtual sequencer routing with sub-sequencers
    sqr.apb_mst_sqr = apb_mst.sequencer;
    sqr.i2c_mst_sqr = i2c_mst.sequencer;
    sqr.i2c_slv_sqr = i2c_slv.sequencer;

    // register model integration
    rgm.default_map.set_sequencer(apb_mst.sequencer, adapter);
    apb_mst.monitor.item_collected_port.connect(predictor.bus_in);
    predictor.map = rgm.default_map;
    predictor.adapter = adapter;
  endfunction: connect_phase

endclass


`endif
