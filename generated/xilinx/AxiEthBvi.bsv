
/*
   ../scripts/importbvi.py
   -o
   AxiEthBvi.bsv
   -P
   AxiEthBvi
   -I
   AxiEthBvi
   ../../out/vc709/axi_ethernet_0/axi_ethernet_0_stub.v
*/

import Clocks::*;
import DefaultValue::*;
import XilinxCells::*;
import GetPut::*;
import AxiBits::*;

(* always_ready, always_enabled *)
interface AxiethbviAxi;
    method Action      rxd_arstn(Bit#(1) v);
    method Action      rxs_arstn(Bit#(1) v);
    method Action      txc_arstn(Bit#(1) v);
    method Action      txd_arstn(Bit#(1) v);
endinterface
(* always_ready, always_enabled *)
interface AxiethbviAxis;
    method Action      clk(Bit#(1) v);
endinterface
(* always_ready, always_enabled *)
interface AxiethbviGt;
    method Bit#(1)     qplloutclk_out();
    method Bit#(1)     qplloutrefclk_out();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviGtref;
    method Bit#(1)     clk_buf_out();
    method Bit#(1)     clk_out();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviM_axis_rxd;
    method Bit#(32)     tdata();
    method Bit#(4)     tkeep();
    method Bit#(1)     tlast();
    method Action      tready(Bit#(1) v);
    method Bit#(1)     tvalid();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviM_axis_rxs;
    method Bit#(32)     tdata();
    method Bit#(4)     tkeep();
    method Bit#(1)     tlast();
    method Action      tready(Bit#(1) v);
    method Bit#(1)     tvalid();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviMac;
    method Bit#(1)     irq();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviMdio;
    method Bit#(1)     mdc();
    method Action      mdio_i(Bit#(1) v);
    method Bit#(1)     mdio_o();
    method Bit#(1)     mdio_t();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviMgt;
    method Action      clk_clk_n(Bit#(1) v);
    method Action      clk_clk_p(Bit#(1) v);
endinterface
(* always_ready, always_enabled *)
interface AxiethbviMmcm;
    method Bit#(1)     locked_out();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviPhy;
    method Bit#(1)     rst_n();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviPma;
    method Bit#(1)     reset_out();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviRef;
    method Action      clk(Bit#(1) v);
endinterface
(* always_ready, always_enabled *)
interface AxiethbviRxuserclk;
    method Bit#(1)     out();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviS_axi;
    method Action      araddr(Bit#(18) v);
    method Bit#(1)     arready();
    method Action      arvalid(Bit#(1) v);
    method Action      awaddr(Bit#(18) v);
    method Bit#(1)     awready();
    method Action      awvalid(Bit#(1) v);
    method Action      bready(Bit#(1) v);
    method Bit#(2)     bresp();
    method Bit#(1)     bvalid();
    method Bit#(32)     rdata();
    method Action      rready(Bit#(1) v);
    method Bit#(2)     rresp();
    method Bit#(1)     rvalid();
    method Action      wdata(Bit#(32) v);
    method Bit#(1)     wready();
    method Action      wstrb(Bit#(4) v);
    method Action      wvalid(Bit#(1) v);
endinterface
(* always_ready, always_enabled *)
interface AxiethbviS_axi_lite;
    method Action      clk(Bit#(1) v);
    method Action      resetn(Bit#(1) v);
endinterface
(* always_ready, always_enabled *)
interface AxiethbviS_axis_txc;
    method Action      tdata(Bit#(32) v);
    method Action      tkeep(Bit#(4) v);
    method Action      tlast(Bit#(1) v);
    method Bit#(1)     tready();
    method Action      tvalid(Bit#(1) v);
endinterface
(* always_ready, always_enabled *)
interface AxiethbviS_axis_txd;
    method Action      tdata(Bit#(32) v);
    method Action      tkeep(Bit#(4) v);
    method Action      tlast(Bit#(1) v);
    method Bit#(1)     tready();
    method Action      tvalid(Bit#(1) v);
endinterface
(* always_ready, always_enabled *)
interface AxiethbviSgmii;
    method Action      rxn(Bit#(1) v);
    method Action      rxp(Bit#(1) v);
    method Bit#(1)     txn();
    method Bit#(1)     txp();
endinterface
(* always_ready, always_enabled *)
interface AxiethbviSignal;
    method Action      detect(Bit#(1) v);
endinterface
(* always_ready, always_enabled *)
interface AxiethbviUserclk;
    method Bit#(1)     out();
endinterface
(* always_ready, always_enabled *)
interface AxiEthBvi;
    interface AxiethbviAxi     axi;
    interface AxiethbviAxis     axis;
    interface AxiethbviGt     gt0;
    interface AxiethbviGtref     gtref;
    method Bit#(1)     interrupt();
    interface AxiethbviM_axis_rxd     m_axis_rxd;
    interface AxiethbviM_axis_rxs     m_axis_rxs;
    interface AxiethbviMac     mac;
    interface AxiethbviMdio     mdio;
    interface AxiethbviMgt     mgt;
    interface AxiethbviMmcm     mmcm;
    interface AxiethbviPhy     phy;
    interface AxiethbviPma     pma;
    interface AxiethbviRef     reff;
    interface AxiethbviRxuserclk     rxuserclk2;
    interface AxiethbviRxuserclk     rxuserclk;
    interface AxiethbviS_axi     s_axi;
    interface AxiethbviS_axi_lite     s_axi_lite;
    interface AxiethbviS_axis_txc     s_axis_txc;
    interface AxiethbviS_axis_txd     s_axis_txd;
    interface AxiethbviSgmii     sgmii;
    interface AxiethbviSignal     signal;
    interface AxiethbviUserclk     userclk2;
    interface AxiethbviUserclk     userclk;
endinterface
import "BVI" axi_ethernet_0 =
module mkAxiEthBvi(AxiEthBvi);
    default_clock clk();
    default_reset rst();
    interface AxiethbviAxi     axi;
        method rxd_arstn(axi_rxd_arstn) enable((*inhigh*) EN_axi_rxd_arstn);
        method rxs_arstn(axi_rxs_arstn) enable((*inhigh*) EN_axi_rxs_arstn);
        method txc_arstn(axi_txc_arstn) enable((*inhigh*) EN_axi_txc_arstn);
        method txd_arstn(axi_txd_arstn) enable((*inhigh*) EN_axi_txd_arstn);
    endinterface
    interface AxiethbviAxis     axis;
        method clk(axis_clk) enable((*inhigh*) EN_axis_clk);
    endinterface
    interface AxiethbviGt     gt0;
        method gt0_qplloutclk_out qplloutclk_out();
        method gt0_qplloutrefclk_out qplloutrefclk_out();
    endinterface
    interface AxiethbviGtref     gtref;
        method gtref_clk_buf_out clk_buf_out();
        method gtref_clk_out clk_out();
    endinterface
    method interrupt interrupt();
    interface AxiethbviM_axis_rxd     m_axis_rxd;
        method m_axis_rxd_tdata tdata();
        method m_axis_rxd_tkeep tkeep();
        method m_axis_rxd_tlast tlast();
        method tready(m_axis_rxd_tready) enable((*inhigh*) EN_m_axis_rxd_tready);
        method m_axis_rxd_tvalid tvalid();
    endinterface
    interface AxiethbviM_axis_rxs     m_axis_rxs;
        method m_axis_rxs_tdata tdata();
        method m_axis_rxs_tkeep tkeep();
        method m_axis_rxs_tlast tlast();
        method tready(m_axis_rxs_tready) enable((*inhigh*) EN_m_axis_rxs_tready);
        method m_axis_rxs_tvalid tvalid();
    endinterface
    interface AxiethbviMac     mac;
        method mac_irq irq();
    endinterface
    interface AxiethbviMdio     mdio;
        method mdio_mdc mdc();
        method mdio_i(mdio_mdio_i) enable((*inhigh*) EN_mdio_mdio_i);
        method mdio_mdio_o mdio_o();
        method mdio_mdio_t mdio_t();
    endinterface
    interface AxiethbviMgt     mgt;
        method clk_clk_n(mgt_clk_clk_n) enable((*inhigh*) EN_mgt_clk_clk_n);
        method clk_clk_p(mgt_clk_clk_p) enable((*inhigh*) EN_mgt_clk_clk_p);
    endinterface
    interface AxiethbviMmcm     mmcm;
        method mmcm_locked_out locked_out();
    endinterface
    interface AxiethbviPhy     phy;
        method phy_rst_n rst_n();
    endinterface
    interface AxiethbviPma     pma;
        method pma_reset_out reset_out();
    endinterface
    interface AxiethbviRef     reff;
        method clk(ref_clk) enable((*inhigh*) EN_ref_clk);
    endinterface
    interface AxiethbviRxuserclk     rxuserclk2;
        method rxuserclk2_out out();
    endinterface
    interface AxiethbviRxuserclk     rxuserclk;
        method rxuserclk_out out();
    endinterface
    interface AxiethbviS_axi     s_axi;
        method araddr(s_axi_araddr) enable((*inhigh*) EN_s_axi_araddr);
        method s_axi_arready arready();
        method arvalid(s_axi_arvalid) enable((*inhigh*) EN_s_axi_arvalid);
        method awaddr(s_axi_awaddr) enable((*inhigh*) EN_s_axi_awaddr);
        method s_axi_awready awready();
        method awvalid(s_axi_awvalid) enable((*inhigh*) EN_s_axi_awvalid);
        method bready(s_axi_bready) enable((*inhigh*) EN_s_axi_bready);
        method s_axi_bresp bresp();
        method s_axi_bvalid bvalid();
        method s_axi_rdata rdata();
        method rready(s_axi_rready) enable((*inhigh*) EN_s_axi_rready);
        method s_axi_rresp rresp();
        method s_axi_rvalid rvalid();
        method wdata(s_axi_wdata) enable((*inhigh*) EN_s_axi_wdata);
        method s_axi_wready wready();
        method wstrb(s_axi_wstrb) enable((*inhigh*) EN_s_axi_wstrb);
        method wvalid(s_axi_wvalid) enable((*inhigh*) EN_s_axi_wvalid);
    endinterface
    interface AxiethbviS_axi_lite     s_axi_lite;
        method clk(s_axi_lite_clk) enable((*inhigh*) EN_s_axi_lite_clk);
        method resetn(s_axi_lite_resetn) enable((*inhigh*) EN_s_axi_lite_resetn);
    endinterface
    interface AxiethbviS_axis_txc     s_axis_txc;
        method tdata(s_axis_txc_tdata) enable((*inhigh*) EN_s_axis_txc_tdata);
        method tkeep(s_axis_txc_tkeep) enable((*inhigh*) EN_s_axis_txc_tkeep);
        method tlast(s_axis_txc_tlast) enable((*inhigh*) EN_s_axis_txc_tlast);
        method s_axis_txc_tready tready();
        method tvalid(s_axis_txc_tvalid) enable((*inhigh*) EN_s_axis_txc_tvalid);
    endinterface
    interface AxiethbviS_axis_txd     s_axis_txd;
        method tdata(s_axis_txd_tdata) enable((*inhigh*) EN_s_axis_txd_tdata);
        method tkeep(s_axis_txd_tkeep) enable((*inhigh*) EN_s_axis_txd_tkeep);
        method tlast(s_axis_txd_tlast) enable((*inhigh*) EN_s_axis_txd_tlast);
        method s_axis_txd_tready tready();
        method tvalid(s_axis_txd_tvalid) enable((*inhigh*) EN_s_axis_txd_tvalid);
    endinterface
    interface AxiethbviSgmii     sgmii;
        method rxn(sgmii_rxn) enable((*inhigh*) EN_sgmii_rxn);
        method rxp(sgmii_rxp) enable((*inhigh*) EN_sgmii_rxp);
        method sgmii_txn txn();
        method sgmii_txp txp();
    endinterface
    interface AxiethbviSignal     signal;
        method detect(signal_detect) enable((*inhigh*) EN_signal_detect);
    endinterface
    interface AxiethbviUserclk     userclk2;
        method userclk2_out out();
    endinterface
    interface AxiethbviUserclk     userclk;
        method userclk_out out();
    endinterface
    schedule (axi.rxd_arstn, axi.rxs_arstn, axi.txc_arstn, axi.txd_arstn, axis.clk, gt0.qplloutclk_out, gt0.qplloutrefclk_out, gtref.clk_buf_out, gtref.clk_out, interrupt, m_axis_rxd.tdata, m_axis_rxd.tkeep, m_axis_rxd.tlast, m_axis_rxd.tready, m_axis_rxd.tvalid, m_axis_rxs.tdata, m_axis_rxs.tkeep, m_axis_rxs.tlast, m_axis_rxs.tready, m_axis_rxs.tvalid, mac.irq, mdio.mdc, mdio.mdio_i, mdio.mdio_o, mdio.mdio_t, mgt.clk_clk_n, mgt.clk_clk_p, mmcm.locked_out, phy.rst_n, pma.reset_out, reff.clk, rxuserclk2.out, rxuserclk.out, s_axi.araddr, s_axi.arready, s_axi.arvalid, s_axi.awaddr, s_axi.awready, s_axi.awvalid, s_axi.bready, s_axi.bresp, s_axi.bvalid, s_axi.rdata, s_axi.rready, s_axi.rresp, s_axi.rvalid, s_axi.wdata, s_axi.wready, s_axi.wstrb, s_axi.wvalid, s_axi_lite.clk, s_axi_lite.resetn, s_axis_txc.tdata, s_axis_txc.tkeep, s_axis_txc.tlast, s_axis_txc.tready, s_axis_txc.tvalid, s_axis_txd.tdata, s_axis_txd.tkeep, s_axis_txd.tlast, s_axis_txd.tready, s_axis_txd.tvalid, sgmii.rxn, sgmii.rxp, sgmii.txn, sgmii.txp, signal.detect, userclk2.out, userclk.out) CF (axi.rxd_arstn, axi.rxs_arstn, axi.txc_arstn, axi.txd_arstn, axis.clk, gt0.qplloutclk_out, gt0.qplloutrefclk_out, gtref.clk_buf_out, gtref.clk_out, interrupt, m_axis_rxd.tdata, m_axis_rxd.tkeep, m_axis_rxd.tlast, m_axis_rxd.tready, m_axis_rxd.tvalid, m_axis_rxs.tdata, m_axis_rxs.tkeep, m_axis_rxs.tlast, m_axis_rxs.tready, m_axis_rxs.tvalid, mac.irq, mdio.mdc, mdio.mdio_i, mdio.mdio_o, mdio.mdio_t, mgt.clk_clk_n, mgt.clk_clk_p, mmcm.locked_out, phy.rst_n, pma.reset_out, reff.clk, rxuserclk2.out, rxuserclk.out, s_axi.araddr, s_axi.arready, s_axi.arvalid, s_axi.awaddr, s_axi.awready, s_axi.awvalid, s_axi.bready, s_axi.bresp, s_axi.bvalid, s_axi.rdata, s_axi.rready, s_axi.rresp, s_axi.rvalid, s_axi.wdata, s_axi.wready, s_axi.wstrb, s_axi.wvalid, s_axi_lite.clk, s_axi_lite.resetn, s_axis_txc.tdata, s_axis_txc.tkeep, s_axis_txc.tlast, s_axis_txc.tready, s_axis_txc.tvalid, s_axis_txd.tdata, s_axis_txd.tkeep, s_axis_txd.tlast, s_axis_txd.tready, s_axis_txd.tvalid, sgmii.rxn, sgmii.rxp, sgmii.txn, sgmii.txp, signal.detect, userclk2.out, userclk.out);
endmodule
