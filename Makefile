# Some sort of codes

KICKASS_JAR=$(KICK_HOME)/KickAss.jar
C1541=$(VICE_HOME)/tools/c1541
PROG=bird

.PHONY: deploy clean

deploy:$(PROG).d64
	x64 -autoload $(PROG).d64

$(PROG).d64:$(PROG).prg
	$(C1541) -format $(PROG),1 d64 $(PROG).d64 -attach $(PROG).d64 -write $(PROG).prg $(PROG)

cbm-map.txt: usa-map.seq trans.py
	python3 trans.py

$(PROG).prg:$(PROG).asm *.asm cbm-map.txt 
	java -jar $(KICKASS_JAR) $(PROG).asm

usa-map.seq: usa-map.txt
	petcat -text -w2 -o usa-map.seq -- usa-map.txt

ussr-map.seq: ussr-map.txt
	petcat -text -w2 -o ussr-map.seq -- ussr-map.txt

clean:
	rm -f *.prg
	rm -f *.d64
	rm -f *.sym
