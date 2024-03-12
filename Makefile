# SPDX-License-Identifier: GPL-2.0-only
#
# Makefile for the Ethernet Bonding driver
#

obj-$(CONFIG_BONDING) += bonding.o

bonding-objs := bond_main.o bond_3ad.o bond_alb.o bond_sysfs.o bond_sysfs_slave.o bond_debugfs.o bond_netlink.o bond_options.o

proc-$(CONFIG_PROC_FS) += bond_procfs.o
bonding-objs += $(proc-y)

kernel="6.6.14-1-bonding"

default: bond_main.c bond_3ad.c bond_alb.c bond_sysfs.c bond_sysfs_slave.c bond_debugfs.c bond_netlink.c bond_options.c
	make -C /usr/lib/modules/$(kernel)/build M=$(PWD) modules

clean:
	make -C /usr/lib/modules/$(kernel)/build M=$(PWD) clean

install:
	rm /usr/lib/modules/$(kernel)/kernel/drivers/net/bonding/*.ko
	cp ./bonding.ko /usr/lib/modules/$(kernel)/kernel/drivers/net/bonding/