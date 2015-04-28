# Copyright (c) 2014 Quanta Research Cambridge, Inc
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#

include Makefile.version

export UDEV_RULES_DIR=/etc/udev/rules.d
UDEV_RULES=$(shell ls etc/udev/rules.d)
MODULES_LOAD_D_DIR=/etc/modules-load.d

all: pciedrivers scripts/syntax/parsetab.py
	echo version "$(VERSION)"

pciedrivers:
	(cd drivers/pcieportal; make DRIVER_VERSION=$(VERSION))
	make -C pcie

pciedrivers-clean:
	(cd drivers/pcieportal; make clean)
	make -C pcie clean

ifneq ("$(DESTDIR)", "")
INSTALL_SHARED = install-shared
endif

install: $(INSTALL_SHARED)
	install -d -m755 $(DESTDIR)/$(UDEV_RULES_DIR)
	if [ -d $(DESTDIR)/$(MODULES_LOAD_D_DIR) ]; then \
	    for fname in ./$(MODULES_LOAD_D_DIR)/* ; do \
		install -m644 $$fname $(DESTDIR)$(MODULES_LOAD_D_DIR) ; \
	    done; \
	fi
	(cd drivers/pcieportal; make install)
	make -C pcie install
	install -d -m755 $(DESTDIR)$(UDEV_RULES_DIR)
	for fname in $(UDEV_RULES) ; do \
	    install -m644 etc/udev/rules.d/$$fname $(DESTDIR)$(UDEV_RULES_DIR) ; \
	done
ifeq ( _$(DESTDIR), _)
	service udev restart;
	rmmod portalmem;
	rmmod pcieportal;
	modprobe portalmem;
	modprobe pcieportal;
endif

INSTALL_DIRS = $(shell ls | grep -v debian)

install-shared:
	find $(INSTALL_DIRS) -type d -exec install -d -m755 $(DESTDIR)/usr/share/connectal/{} \; -print
	find $(INSTALL_DIRS) -type f -exec install -m644 {} $(DESTDIR)/usr/share/connectal/{} \; -print
	chmod agu+rx $(DESTDIR)/usr/share/connectal/scripts/*

uninstall:
	for fname in ./$(MODULES_LOAD_D_DIR)/* ; do \
	    rm -vf $(MODULES_LOAD_D_DIR)/`basename $$fname` ; \
	done;
	(cd drivers/pcieportal; make uninstall)
	make -C pcie/connectalutil uninstall
	for fname in $(UDEV_RULES) ; do \
	    rm -f $(UDEV_RULES_DIR)/$$fname ; \
	done
	service udev restart

docs:
	doxygen scripts/Doxyfile

dpkg:
	git archive --format=tar -o dpkg.tar --prefix=connectal-$(VERSION)/ HEAD
	tar -xf dpkg.tar
	rm -f connectal_*
	(cd connectal-$(VERSION); pwd; dh_make --createorig --email jamey.hicks@gmail.com --multi -c bsd; dpkg-buildpackage)

## PLY's home is http://www.dabeaz.com/ply/
install-dependences:
ifeq ($(shell uname), Darwin)
	port install asciidoc
	easy_install ply
else
	apt-get install asciidoc python-dev python-setuptools python-ply
	apt-get install libgmp3c2
endif
	easy_install blockdiag seqdiag actdiag nwdiag libusb1
        wget https://asciidoc-diag-filter.googlecode.com/files/diag_filter.zip
	asciidoc --filter install diag_filter.zip
	wget http://laurent-laville.org/asciidoc/bootstrap/bootstrap-3.3.0.zip
	asciidoc --backend install bootstrap-3.3.0.zip

BOARD=zedboard

scripts/syntax/parsetab.py: scripts/syntax.py
	[ -e out ] || mkdir out
	python scripts/syntax.py

allarchlist = ac701 zedboard zc702 zc706 kc705 vc707 zynq100 v2000t bluesim miniitx100 de5 htg4 vsim parallella xsim zybo

#################################################################################################
# gdb

#%.gdb:
#	make CONNECTAL_DEBUG=1 $*

# For the parallella build to work, the cross compilers need to be in your path
# and the parallella kernel needs to be parallel to connectal and built
parallelladrivers:
	(cd drivers/zynqportal/; DRIVER_VERSION=$(VERSION) CROSS_COMPILE=arm-linux-gnueabihf- DEVICE_XILINX_KERNEL=`pwd`/../../../parallella-linux/ make parallellazynqportal.ko)
	(cd drivers/portalmem/; DRIVER_VERSION=$(VERSION) CROSS_COMPILE=arm-linux-gnueabihf- DEVICE_XILINX_KERNEL=`pwd`/../../../parallella-linux/ make parallellaportalmem.ko)

parallelladrivers-clean:
	(cd drivers/zynqportal/;  CROSS_COMPILE=arm-linux-gnueabihf- DEVICE_XILINX_KERNEL=`pwd`/../../../linux-xlnx/ make clean)
	(cd drivers/portalmem/;   CROSS_COMPILE=arm-linux-gnueabihf- DEVICE_XILINX_KERNEL=`pwd`/../../../linux-xlnx/ make clean)

zynqdrivers:
	(cd drivers/zynqportal/; DRIVER_VERSION=$(VERSION) DEVICE_XILINX_KERNEL=`pwd`/../../../linux-xlnx/ make zynqportal.ko)
	(cd drivers/portalmem/;  DRIVER_VERSION=$(VERSION) DEVICE_XILINX_KERNEL=`pwd`/../../../linux-xlnx/ make portalmem.ko)

zynqdrivers-clean:
	(cd drivers/zynqportal/; DEVICE_XILINX_KERNEL=`pwd`/../../../linux-xlnx/ make clean)
	(cd drivers/portalmem/;  DEVICE_XILINX_KERNEL=`pwd`/../../../linux-xlnx/ make clean)

zynqdrivers-install:
	cp drivers/zynqportal/zynqportal.ko drivers/portalmem/portalmem.ko ../zynq-boot/imagefiles/

RUNPARAMTEMP=$(subst :, ,$(RUNPARAM):5555)
RUNIP=$(wordlist 1,1,$(RUNPARAMTEMP))
RUNPORT=$(wordlist 2,2,$(RUNPARAMTEMP))

zynqdrivers-adb:
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) shell pwd || true
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) root || true
	sleep 1
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) push drivers/zynqportal/zynqportal.ko /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) push drivers/portalmem/portalmem.ko /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) shell rmmod zynqportal
	adb -s $(RUNIP):$(RUNPORT) shell rmmod portalmem
	adb -s $(RUNIP):$(RUNPORT) shell insmod /mnt/sdcard/zynqportal.ko
	adb -s $(RUNIP):$(RUNPORT) shell insmod /mnt/sdcard/portalmem.ko

connectalspi-clean:
	(cd drivers/connectalspi/; DEVICE_XILINX_KERNEL=`pwd`/../../../linux-xlnx/ make clean)

connectalspi:
	(cd drivers/connectalspi/; DRIVER_VERSION=$(VERSION) DEVICE_XILINX_KERNEL=`pwd`/../../../linux-xlnx/ make connectalspi.ko)

foo:
	cd tests/test_spi0/ && make run.zedboard || true

connectalspi-adb: 
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) shell pwd || true
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) root || true
	sleep 1
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) push drivers/connectalspi/connectalspi.ko /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) shell rmmod connectalspi
	adb -s $(RUNIP):$(RUNPORT) shell insmod /mnt/sdcard/connectalspi.ko
	adb -s $(RUNIP):$(RUNPORT) shell chmod 777 /dev/spi*

distclean:
	for archname in $(allarchlist) ; do  \
	   rm -rf examples/*/"$$archname" tests/*/"$$archname"; \
	done
	rm -rf drivers/*/.tmp_versions tests/memread_manual/kernel/.tmp_versions/
	rm -rf pcie/connectalutil/connectalutil tests/memread_manual/kernel/bsim_relay
	rm -rf out/ exit.status cpp/*.o scripts/*.pyc
	rm -rf tests/*/train-images-idx3-ubyte examples/*/train-images-idx3-ubyte
	rm -f drivers/pcieportal/.*.o.cmd drivers/pcieportal/.*.ko.cmd
	rm -f drivers/portalmem/.*.o.cmd drivers/portalmem/.*.ko.cmd
	rm -f drivers/zynqportal/.*.o.cmd drivers/zynqportal/.*.ko.cmd
	rm -rf doc/library/build/ examples/rbm/datasets/
	rm -f doc/library/source/devguide/connectalbuild-1.png
	rm -f drivers/*/driver_signature_file.h
