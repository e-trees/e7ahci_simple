package ahci_test;

import java.util.EnumSet;

import synthesijer.hdl.HDLModule;
import synthesijer.hdl.HDLPort;
import synthesijer.hdl.HDLPort.DIR;
import synthesijer.hdl.HDLPrimitiveType;
import synthesijer.hdl.HDLUtils;

public class AHCI_REGISTER extends HDLModule{
	
	int[] values;

	public AHCI_REGISTER(String... args){
		super("ahci_reg", "clk", "reset");
		
		HDLUtils.genInputPort(this, "address", 32, EnumSet.of(HDLPort.OPTION.EXPORT));
		HDLUtils.genInputPort(this, "din", 32, EnumSet.of(HDLPort.OPTION.EXPORT));
		HDLUtils.genOutputPort(this, "dout", 32, EnumSet.of(HDLPort.OPTION.EXPORT));
		HDLUtils.genInputPort(this, "we", EnumSet.of(HDLPort.OPTION.EXPORT));
		HDLUtils.genInputPort(this, "en", EnumSet.of(HDLPort.OPTION.EXPORT));

		newPort("values_length",  DIR.OUT, HDLPrimitiveType.genSignedType(32));
		newPort("values_address", DIR.IN,  HDLPrimitiveType.genSignedType(32));
		newPort("values_din",     DIR.IN,  HDLPrimitiveType.genSignedType(32));
		newPort("values_dout",    DIR.OUT, HDLPrimitiveType.genSignedType(32));
		newPort("values_we",      DIR.IN,  HDLPrimitiveType.genBitType());
		newPort("values_oe",      DIR.IN,  HDLPrimitiveType.genBitType());
	}
	
}
