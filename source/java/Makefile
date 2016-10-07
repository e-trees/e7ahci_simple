SYNTHESIJER ?= $(HOME)/synthesijer/synthesijer_20160511.jar
SYNTHESIJER_EXTRA_LIB ?= $(HOME)/synthesijer/synthesijer_extra-libs_20160511/bin
SYNTHESIJER_EXTRA_LIB_SRC ?= $(HOME)/synthesijer/synthesijer_extra-libs_20160511/src

all:
	java -cp $(SYNTHESIJER):$(SYNTHESIJER_EXTRA_LIB):. \
		synthesijer.Main \
		ahci_test/AHCI_Test.java \
		ahci_test/AHCI_REGISTER.java \
		ahci_test/AHCI_ID.java \
		ahci_test/AXIMemIface32RTL_Dual.java \
		$(SYNTHESIJER_EXTRA_LIB_SRC)/synthesijer/lib/axi/AXIMemIface128RTL_BRAM_Ext_Ctrl.java \
		$(SYNTHESIJER_EXTRA_LIB_SRC)/synthesijer/lib/axi/AXIMemIface512RTL_BRAM_Ext_Ctrl.java \
		$(SYNTHESIJER_EXTRA_LIB_SRC)/synthesijer/lib/axi/AXIMemIface32RTLTest.java \
		$(SYNTHESIJER_EXTRA_LIB_SRC)/synthesijer/lib/axi/AXIMemIface32RTL.java
	javac -cp .:$(SYNTHESIJER) ahci_test/GenId.java
	java -cp .:$(SYNTHESIJER) ahci_test.GenId
