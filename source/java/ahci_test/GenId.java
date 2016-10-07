/** Copyright (C) 2016 e-trees.Japan, Inc. All Rights Reserved. **/

package ahci_test;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import synthesijer.hdl.HDLPort;

public class GenId {


    private int pack(char a, char b, char c, char d){
	return (((int)a&0xFF) << 24) + (((int)b&0xFF) << 16) + (((int)c&0xFF) << 8) + ((int)d&0xFF);
    }
	
    private String pad(int n){
	String s = "";
	for(int i = 0; i < n; i++) s += " ";
	return s;
    }
	
    private int[] genHeaderArray(){
	int[] result = new int[]{
	    0x3fff0040,
	    0x0010c837,
	    0x00000000,
	    0x0000003f,
	    0x00000000,
	    0x4d504356,
	    0x32303330,
	    0x43563030,
	    0x30413036,
	    0x2020474e,
	    0x00000000,
	    0x33300000, // 30
	    0x20203069, // __0i
	    0x652d2020, // IN__ e-__
	    0x65657472, // L_TE eetr
	    0x20467320, // DSSS _Fs_ 
	    0x41205047, // CTC2 A_PG
	    0x30413030, // 0A06 0A00
	    0x20203320, // __3_
	    0x20202020, // ____
	    0x20202020, // ____
	    0x20202020, // ____
	    0x20202020,
	    0x80102020,
	    0x2f004000,
	    0x00004000,
	    0x00070000,
	    0x00103fff,
	    0xfc10003f,
	    0x011000fb,
	    0x06fccf30,
	    0x00070000,
	    0x00780003,
	    0x00780078,
	    0x40000078,
	    0x00000000,
	    0x00000000,
	    0x001f0000,
	    0x00044706,
	    0x0044004c,
	    0x011003fc,
	    0x7469746b,
	    0x74296163,
	    0x6163b449,
	    0x0002407f,
	    0x00fe0001,
	    0x0000fffe,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x06fccf30,
	    0x00000000,
	    0x00010000,
	    0x00004000,
	    0x51785001,
	    0x4baf03d8,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x401c0000,
	    0x0000401c,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000029,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00010000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000021,
	    0x40000000,
	    0x00000000,
	    0x00000100,
	    0x00000000,
	    0x00010000,
	    0x00000000,
	    0x00000000,
	    0x0000103f,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x00000000,
	    0x5ea50000 
	    };
	return result;
    }

    public static void main(String... args){
	AHCI_ID t = new AHCI_ID();
	GenId m = new GenId();
	int[] contents = m.genHeaderArray();
	int depth = (int)(Math.ceil(Math.log(contents.length)/Math.log(2)));
		
	File file = new File(t.getName() + ".vhd");
	String NL = System.getProperty("line.separator");
		
	try(PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(file)))){

		out.println("library IEEE;");
		out.println("use IEEE.std_logic_1164.all;");
		out.println("use IEEE.numeric_std.all;");
		out.println();
		out.println("entity " + t.getName() + " is");
		out.println("port(");
		String sep = "";
		for(HDLPort p: t.getPorts()){
		    out.print(sep + p.getName() + " : " + p.getDir().getVHDL() + " " + p.getType().getVHDL());
		    sep = ";" + NL;
		}
		out.println(");");
		out.println("end " + t.getName() + ";");
		out.println("architecture RTL of " + t.getName() + " is");
		out.println("subtype MEM is signed(31 downto 0);");
		out.println("type ROM is array ( 0 to " + (contents.length-1) + " ) of MEM;");
		out.println("constant data : ROM := (");
		sep = "";
		for(int d: contents){
		    out.printf("%sX\"%08x\"", sep, d);
		    sep = "," + NL;
		}
		out.println(");");
		out.println("begin");
		out.println("data_length <= to_signed(" + contents.length + ", 32);");
		out.println("length <= to_signed(" + contents.length + ", 32);");
		out.println("process(clk)");
		out.println("begin");
		out.println("if (clk'event and clk = '1') then");
		out.println("data_dout <= data(to_integer(unsigned(data_address)));");
		out.println("end if;");
		out.println("end process;");
		out.println("end RTL;");
	       
	    }catch(IOException e){
			
	}
    }
	
}

