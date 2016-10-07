/** Copyright (C) 2016 e-trees.Japan, Inc. All Rights Reserved. **/

package ahci_test;

import synthesijer.lib.OUTPUT1;

public class AHCI_Test {
	
	public final AHCI_REGISTER reg = new AHCI_REGISTER();
	private final AXIMemIface32RTL_Dual axi = new AXIMemIface32RTL_Dual();
	
	public final OUTPUT1 interrupt = new OUTPUT1();
	
	public final AHCI_ID identify = new AHCI_ID();

	public int dw0, dw1, dw2, dw3, dw4;
	
	public int status;
	
	private static final int IS = 2; // 08h
	private static final int EM_CTL = 8; // 20h
	
	private static final int P0CLB  = 64; // 100h + 00h
	private static final int P0FB   = 66; // 100h + 08h
	private static final int P0IS   = 68; // 100h + 10h
	private static final int P0IE   = 69; // 100h + 14h
	private static final int P0CMD  = 70; // 100h + 18h
	private static final int P0SACT = 77; // 100h + 34h (/ (+ #x100 #x34) 4)
	private static final int P0CI   = 78; // 100h + 38h
	
	public int fpdma_sectors;
	public int fpdma_lba;
	public int fpdma_lba_exp;
	public int ncq_tag;
	
	public int debug_fpdma_src;
	public int debug_fpdma_dest;
	public int debug_fpdma_rest;
	
	private int get_port_id(int value){
		int v = value;
		int i = 0;
		while(i < 32){
			if((v & 0x00000001) == 0x00000001){
				return i;
			}else{
				v = v >> 1;
				i++;
			}
		}
		return 0;
	}
	
	private int one_hot_bits(int d){
		int d0 = d & 0x0000001F;
		switch(d0){
		case 0:  return 0x00000001;
		case 1:  return 0x00000002;
		case 2:  return 0x00000004;
		case 3:  return 0x00000008;
		case 4:  return 0x00000010;
		case 5:  return 0x00000020;
		case 6:  return 0x00000040;
		case 7:  return 0x00000080;
		case 8:  return 0x00000100;
		case 9:  return 0x00000200;
		case 10: return 0x00000400;
		case 11: return 0x00000800;
		case 12: return 0x00001000;
		case 13: return 0x00002000;
		case 14: return 0x00004000;
		case 15: return 0x00008000;
		case 16: return 0x00010000;
		case 17: return 0x00020000;
		case 18: return 0x00040000;
		case 19: return 0x00080000;
		case 20: return 0x00100000;
		case 21: return 0x00200000;
		case 22: return 0x00400000;
		case 23: return 0x00800000;
		case 24: return 0x01000000;
		case 25: return 0x02000000;
		case 26: return 0x04000000;
		case 27: return 0x08000000;
		case 28: return 0x10000000;
		case 29: return 0x20000000;
		case 30: return 0x40000000;
		case 31: return 0x80000000;
		}
		return 0;
	}

	private int one_hot_bits_value(int d){
		if((d & 0x00000001) != 0) return 0;
		else if((d & 0x00000002) != 0) return 1;
		else if((d & 0x00000004) != 0) return 2;
		else if((d & 0x00000008) != 0) return 3;
		else if((d & 0x00000010) != 0) return 4;
		else if((d & 0x00000020) != 0) return 5;
		else if((d & 0x00000040) != 0) return 6;
		else if((d & 0x00000080) != 0) return 7;
		else if((d & 0x00000100) != 0) return 8;
		else if((d & 0x00000200) != 0) return 9;
		else if((d & 0x00000400) != 0) return 10;
		else if((d & 0x00000800) != 0) return 11;
		else if((d & 0x00001000) != 0) return 12;
		else if((d & 0x00002000) != 0) return 13;
		else if((d & 0x00004000) != 0) return 14;
		else if((d & 0x00008000) != 0) return 15;
		else if((d & 0x00010000) != 0) return 16;
		else if((d & 0x00020000) != 0) return 17;
		else if((d & 0x00040000) != 0) return 18;
		else if((d & 0x00080000) != 0) return 19;
		else if((d & 0x00100000) != 0) return 20;
		else if((d & 0x00200000) != 0) return 21;
		else if((d & 0x00400000) != 0) return 22;
		else if((d & 0x00800000) != 0) return 23;
		else if((d & 0x01000000) != 0) return 24;
		else if((d & 0x02000000) != 0) return 25;
		else if((d & 0x04000000) != 0) return 26;
		else if((d & 0x08000000) != 0) return 27;
		else if((d & 0x10000000) != 0) return 28;
		else if((d & 0x20000000) != 0) return 29;
		else if((d & 0x40000000) != 0) return 30;
		else if((d & 0x80000000) != 0) return 31;
		return 0;
	}

	public void init(){
		status = 0;
		interrupt.flag = false;  
		reg.values[P0CI] = 0;
		reg.values[P0SACT] = 0;

		for(int i = 0; i < 128; i++){
			reg.values[i] = 0x00000000;
		}
	
		reg.values[0] = 0x40240000; // NCQ, SATA Gen2, SAM = '1'
		reg.values[1] = 0x80000000;
		reg.values[3] = 0x00000001; // PORT #0 available
		reg.values[4] = 0x00010000; // AHCI 1.0
		reg.values[5] = 0x00010100;
		
		reg.values[70] = 0x00110006; // 100h + 18h
		reg.values[72] = 0x00000058; // 100h + 20h
		reg.values[74] = 0x00000123; // 100h + 28h
		reg.values[75] = 0x00000320; // 100h + 2Ch
		status = 1;
	}
	
	private int p0_clb;
	private int p0_fb;
	private int ctba;
	private int dba;
	private int prdtl;
	
	private void wait_host_ready(){
		status = 2;
		while(reg.values[P0CLB] == 0) ;
		p0_clb = reg.values[P0CLB];
		while(reg.values[P0FB] == 0) ;
		p0_fb = reg.values[P0FB];
		status = 3;
	}

	private void wait_for_command(){
		status = 4;
		while(reg.values[P0CI] == 0) ;
		status = 5;

		reg.values[P0CMD] = 0x10110007; // start to treat the command
		int id = get_port_id(reg.values[P0CI]);
		
		status = 0x40000005;
		axi.fetch(p0_clb + (id << 5), 4); // read command header
		dw0 = axi.read(0); // PRDTL, PMP, RCBRPWA, CFL
		dw1 = axi.read(1); // PRD Byte Count
		dw2 = axi.read(2); // CTBA0
		dw3 = axi.read(3);
		
		prdtl = (dw0 >> 16) & 0x0000FFFF;
		ctba = dw2;
		status = 0x40000006;
		axi.fetch(ctba, 5); // read CFIS in command table

		dw0 = axi.read(0); // Features, Command, CRPR, PM Port, FIS Type
		dw1 = axi.read(1); // Device, LBA
		dw2 = axi.read(2); // Features, LBA	
		dw3 = axi.read(3);
		dw4 = axi.read(4);
		
		status = 6;
	}
	
	private void return_identify(){
		status = 7;
		// get PRDT entry
		axi.fetch(ctba + 0x80, 4);
		dw0 = axi.read(0); // DBA
		dw1 = axi.read(1);
		dw2 = axi.read(2);
		dw3 = axi.read(3); // I, DBC
		
		dba = dw0;

		status = 0x30000007;
		for(int i = 0; i < 128; i++){
			axi.write(i, identify.data[i]);
		}
		status = 0x40000007;
		axi.flush(dba, 128);
		
		// reply fis
		axi.write(0, 0x0058605f);
		axi.write(1, 0xe0000000);
		axi.write(2, 0x00000000);
		axi.write(3, 0x500000ff);
		axi.write(4, 0x00000200);
		
		status = 0x40000008;
		axi.flush(p0_fb + 0x20, 5);
		status = 8;
	}
	
	private void do_notify(int ci){
		status = 9;
		reg.values[P0CMD] = 0x00110016;
		reg.values[P0IS] = 0x00000022;
		//reg.values[P0CI] = 0x00000000;
		int sact0 = reg.values[P0SACT]; 
		reg.values[P0SACT] = ci & sact0;
		int ci0 = reg.values[P0CI]; 
		reg.values[P0CI] = ci & ci0;
		reg.values[EM_CTL] = 0x00000001;
		reg.values[IS] = 0x00000001;
		interrupt.flag = true; interrupt.flag = false;
		status = 10;
	}
	
	private void wait_for_clean(){
		status = 11;
		while((reg.values[IS] & 0x00000001) == 0x00000001) ;
		status = 12;
	}
	
	private void set_dma_setup_fis(int aid, int tag, int count){
		status = 13;
		axi.write(0, 0x00000041 | ((aid & 0x7) << 13));
		axi.write(1, tag);
		axi.write(2, 0x00000000);
		axi.write(3, 0x00000000); // reserved 
		axi.write(4, 0x00000000); // DMA buffer offset
		axi.write(5, fpdma_sectors << 9); // DMA transfer count (bytes)
		axi.write(6, 0x00000000); // reserved
		
		axi.flush(p0_fb, 6);
		status = 14;
	}
	
	private void set_device_bits_fis(int data){
		status = 15;
		axi.write(0, 0x005860A1);
		axi.write(1, data);
		
		axi.flush(p0_fb + 0x58, 2);
		status = 16;
	}
	
	private int return_fpdma_read(){
		status = 17;
		set_dma_setup_fis(3, ncq_tag, fpdma_sectors << 9);
		int d = one_hot_bits(ncq_tag);
		set_device_bits_fis(d);
		status = 18;
		return d;
	}
	private int return_fpdma_write(){
		status = 19;
		set_dma_setup_fis(2, ncq_tag, fpdma_sectors << 9);
		int d = one_hot_bits(ncq_tag);
		set_device_bits_fis(d);
		status = 20;
		return d;
	}
	
	private int prdtl_addr;
	private int prdtl_len;
	
	private void get_prdtl_info(int i){
		axi.fetch(ctba + 0x80 + (i << 4), 4);
		prdtl_addr = axi.read(0); // DBA
		prdtl_len = axi.read(3);
		prdtl_len = (prdtl_len & 0x003FFFFF) + 1; // [21:0] + 1
	}
		
	/**
	 * 
	 * @param src source address
	 * @param dest destination address
	 * @param num #. of DWORDs to copy
	 * @return copied #. of DWORDs
	 */
	private int copy_storage2pcie(int src, int dest, int num){
		status = 0x10000000;
		int n = num;
		if(n > 256){ n = 256; }
		axi.copy_obj1_to_obj0(src, dest, n);
		status = 0x10000003;
		return n;
	}
	
	/**
	 * 
	 * @param src source address
	 * @param dest destination address
	 * @param size #. of bytes to copy
	 */
	private void copy_storage2pcie_all(int src, int dest, int size){
		status = 0x10000004;
		int r = size;
		int s = src;
		int d = dest;
		r = r >> 6; // convert bytes -> 64Bytes
		while(r > 0){
			debug_fpdma_src = s;
			debug_fpdma_dest = d;
			debug_fpdma_rest = r << 6;
			int l;
			l = copy_storage2pcie(s, d, r);
			s = s + (l << 6); d = d + (l << 6); r = r - l;
		}
		status = 0x10000005;
	}

	/**
	 * 
	 * @param src source address
	 * @param dest destination address
	 * @param num #. of DWORDs to copy
	 * @return copied #. of DWORDs
	 */
	private int copy_pcie2storage(int src, int dest, int size){
		status = 0x20000000;
		int n = size;
		if(n > 256){ n = 256; }
		axi.copy_obj0_to_obj1(src, dest, n);
		status = 0x20000003;
		return n;
	}

	/**
	 * 
	 * @param src source address
	 * @param dest destination address
	 * @param size #. of bytes to copy
	 */
	private void copy_pcie2storage_all(int src, int dest, int size){
		status = 0x20000004;
		int r = size;
		int s = src;
		int d = dest;
		r = r >> 6; // convert bytes -> 64Bytes
		while(r > 0){
			debug_fpdma_src = s;
			debug_fpdma_dest = d;
			debug_fpdma_rest = r << 6;
			int l;
			l = copy_pcie2storage(s, d, r);
			s = s + (l << 6); d = d + (l << 6); r = r - l;
		}
		status = 0x20000005;
	}

	private void do_fpdma_read(){
		status = 21;
		int offset = fpdma_lba << 9; // fpdma_lba * 512
		for(int i = 0; i < prdtl; i++){
			get_prdtl_info(i);
			copy_storage2pcie_all(offset, prdtl_addr, prdtl_len);
			offset = offset + prdtl_len;
		}
		status = 22;
	}

	private void do_fpdma_write(){
		status = 23;
		int offset = fpdma_lba << 9; // fpmda_lba * 512
		for(int i = 0; i < prdtl; i++){
			get_prdtl_info(i);
			copy_pcie2storage_all(prdtl_addr, offset, prdtl_len);
			offset = offset + prdtl_len;
		}
		status = 24;
	}
	
	public int unknown_dw0, unknown_dw1, unknown_dw2, unknown_dw3;

	public void test(){

		init();
		
		wait_host_ready();
		
		while(true){
			wait_for_command(); // received command FIS is saved in dw0-dw4
			
			int cmd = (dw0 >> 16) & 0x000000FF;
			
			// for FPDMA
			ncq_tag = (dw3 >> 3) & 0x0000001F;
			
			fpdma_lba = (dw1 & 0x00FFFFFF);
			fpdma_lba_exp = (dw2 & 0x00FFFFFF);
			fpdma_sectors = ((dw0 >> 24) & 0x000000FF) + (((dw2 >> 24) & 0x000000FF) << 8);
			
			int ci;
			
			switch(cmd){
			case 0xec:
				return_identify();
				do_notify(0);
				break;
			case 0x27:
				return_identify();
				do_notify(0);
				break;
			case 0x60:
				do_fpdma_read();
				ci = return_fpdma_read();
				do_notify(~ci);
				break;
			case 0x61:
				do_fpdma_write();
				ci = return_fpdma_write();
				do_notify(~ci);
				break;
			default:{
				do_notify(0); // unsupported command
				unknown_dw0 = dw0;
				unknown_dw1 = dw1;
				unknown_dw2 = dw2;
				unknown_dw3 = dw3;
				break;
			}
			}
			
			//wait_for_clean();
		}
		
	}

}
