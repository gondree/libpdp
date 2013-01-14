
SRC_DIR=./src
LIB_DIR=./lib

MACPDP_DIR=$(SRC_DIR)/macpdp
CPOR_DIR=$(SRC_DIR)/cpor
APDP_DIR=$(SRC_DIR)/apdp
SEPDP_DIR=$(SRC_DIR)/sepdp
TIMEIT_DIR=$(LIB_DIR)/time_it
LIBS3_DIR=$(LIB_DIR)/libs3-2.0

.PHONY: all timeit libs3 cpor macpdp apdp sepdp clean rebuild install uninstall

all: timeit libs3 cpor macpdp apdp sepdp

cpor:
	$(MAKE) -C $(CPOR_DIR) cpor-s3 ; $(MAKE) -C $(CPOR_DIR) cpor-cpu

macpdp:
	$(MAKE) -C $(MACPDP_DIR) por-s3 ; $(MAKE) -C $(MACPDP_DIR) por-cpu

sepdp: 
	$(MAKE) -C $(SEPDP_DIR) sepdp-s3 ; $(MAKE) -C $(SEPDP_DIR) sepdp-cpu

apdp:
	$(MAKE) -C $(APDP_DIR) pdp-s3 ; $(MAKE) -C $(APDP_DIR) pdp-cpu

libs3:
	$(MAKE) -C $(LIBS3_DIR)

timeit:
	$(MAKE) -C $(TIMEIT_DIR)

rebuild: clean all uninstall install 

install:
	sudo $(MAKE) -C $(LIBS3_DIR) install

uninstall:
	sudo $(MAKE) -C $(LIBS3_DIR) uninstall
	 
clean:
	$(MAKE) -C $(MACPDP_DIR) clean; $(MAKE) -C $(SEPDP_DIR) clean; $(MAKE) -C $(APDP_DIR) clean; $(MAKE) -C $(CPOR_DIR) clean; $(MAKE) -C $(TIMEIT_DIR) clean; $(MAKE) -C $(LIBS3_DIR) clean; $(RM) $(SRC_DIR)/*/times-* $(SRC_DIR)/*/callgrind.out* $(SRC_DIR)/*/gmon.out

