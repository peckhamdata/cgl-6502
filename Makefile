# Some sort of codes

KICKASS_JAR=$(KICK_HOME)/KickAss.jar
C1541=$(VICE_HOME)/tools/c1541
PROG=bird

$(PROG).d64:$(PROG).prg
	$(C1541) -format $(PROG),1 d64 $(PROG).d64 -attach $(PROG).d64 -write $(PROG).prg $(PROG)

$(PROG).prg:$(PROG).asm test-left-shift.asm
	java -jar $(KICKASS_JAR) $(PROG).asm

clean:
	rm -f *.prg
	rm -f *.d64
	rm -f *.sym
