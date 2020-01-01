# Some sort of codes

KICKASS_JAR=$(KICK_HOME)/KickAss.jar
C1541=$(VICE_HOME)/tools/c1541
PROG=bird
EMU=xpet

.PHONY: deploy clean

deploy:$(PROG).d64
	$(EMU) -autoload $(PROG).d64

$(PROG).d64:$(PROG).prg
# 	$(C1541) -format $(PROG),1 d64 $(PROG).d64 -attach $(PROG).d64 -write dist/petemuboot.prg petemuboot -write dist/emulator.prg emulator -write $(PROG).prg $(PROG) -write bkj.prg 
	$(C1541) -format $(PROG),1 d64 $(PROG).d64 -attach $(PROG).d64 -write $(PROG).prg $(PROG) 

$(PROG).prg:$(PROG).asm *.asm test/*.asm
	java -jar $(KICKASS_JAR) $(PROG).asm

clean:
	rm -f *.prg
	rm -f *.d64
	rm -f *.sym
