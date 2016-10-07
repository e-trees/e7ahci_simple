/** Copyright (C) 2016 e-trees.Japan, Inc. All Rights Reserved. **/

package ahci_test;

import synthesijer.lib.INPUT1;
import synthesijer.lib.OUTPUT1;
import synthesijer.lib.OUTPUT32;
import synthesijer.lib.axi.AXIMemIface32RTL;
import synthesijer.lib.axi.AXIMemIface512RTL_BRAM_Ext_Ctrl;

public class AXIMemIface32RTL_Dual{
	
	private final AXIMemIface32RTL ctrl = new AXIMemIface32RTL();
	
//	private final AXIMemIface128RTL_BRAM_Ext_Ctrl obj0 = new AXIMemIface128RTL_BRAM_Ext_Ctrl();
//	private final AXIMemIface128RTL_BRAM_Ext_Ctrl obj1 = new AXIMemIface128RTL_BRAM_Ext_Ctrl();
	private final AXIMemIface512RTL_BRAM_Ext_Ctrl obj0 = new AXIMemIface512RTL_BRAM_Ext_Ctrl();
	private final AXIMemIface512RTL_BRAM_Ext_Ctrl obj1 = new AXIMemIface512RTL_BRAM_Ext_Ctrl();
	
	private final OUTPUT1 memcpy_kick = new OUTPUT1();
	private final INPUT1 memcpy_busy = new INPUT1();
	private final OUTPUT1 memcpy_0to1 = new OUTPUT1();
	private final OUTPUT1 memcpy_1to0 = new OUTPUT1();
	private final OUTPUT32 memcpy_num = new OUTPUT32();
	
	public void flush(int addr, int burst){
		while(ctrl.busy == true){ ; }
		ctrl.axi_addr = addr;
		ctrl.burst_size = burst;
		ctrl.write_kick = true;
		ctrl.write_kick = false;
	}
	
	public void fetch(int addr, int burst){
		while(ctrl.busy == true){ ; }
		ctrl.axi_addr = addr;
		ctrl.burst_size = burst;
		ctrl.read_kick = true;
		ctrl.read_kick = false;
		while(ctrl.busy == true){ ; }
	}
	
	public int read(int offset){
		return ctrl.data[offset];
	}
	
	public void write(int offset, int data){
		ctrl.data[offset] = data;
	}

	private void flush0(int addr, int burst){
		while(obj0.busy == true){ ; }
		obj0.axi_addr = addr;
		obj0.burst_size = burst;
		obj0.write_kick = true;
		obj0.write_kick = false;
	}
	
	private void fetch0(int addr, int burst){
		while(obj0.busy == true){ ; }
		obj0.axi_addr = addr;
		obj0.burst_size = burst;
		obj0.read_kick = true;
		obj0.read_kick = false;
		while(obj0.busy == true){ ; }
	}
	
	private void flush1(int addr, int burst){
		while(obj1.busy == true){ ; }
		obj1.axi_addr = addr;
		obj1.burst_size = burst;
		obj1.write_kick = true;
		obj1.write_kick = false;
	}
	
	private void fetch1(int addr, int burst){
		while(obj1.busy == true){ ; }
		obj1.axi_addr = addr;
		obj1.burst_size = burst;
		obj1.read_kick = true;
		obj1.read_kick = false;
		while(obj1.busy == true){ ; }
	}
	
	public void copy_obj0_to_obj1(int src, int dest, int num){
		fetch0(src, num);
		memcpy_0to1.flag = true;
		memcpy_1to0.flag = false;
		memcpy_num.value = num;
		
		memcpy_kick.flag = false;
		while(obj1.busy == true){ ; } // wait for done of before flush
		memcpy_kick.flag = true; // start to memcpy
		memcpy_kick.flag = false;
		while(memcpy_busy.flag == true){ ; }
		flush1(dest, num);
		/*
		for(int i = 0; i < num; i++){
			obj1.data[i] = obj0.data[i];
		}
		*/
	}
	
	public void copy_obj1_to_obj0(int src, int dest, int num){
		fetch1(src, num);
		memcpy_0to1.flag = false;
		memcpy_1to0.flag = true;
		memcpy_num.value = num;
		
		memcpy_kick.flag = false;
		while(obj0.busy == true){ ; } // wait for done of before flush
		memcpy_kick.flag = true; // start to memcpy
		memcpy_kick.flag = false;
		while(memcpy_busy.flag == true){ ; }
		flush0(dest, num);
		/*
		for(int i = 0; i < num; i++){
			obj0.data[i] = obj1.data[i];
		}
		*/
	}

}
