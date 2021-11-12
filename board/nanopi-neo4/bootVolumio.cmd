setenv load_addr "0x6000000"
echo importing vars.txt
load mmc ${devnum} ${load_addr} vars.txt
env import -t ${load_addr} ${filesize}

echo setting bootargs then loading the fdt and kernel
setenv bootargs "root=/dev/mmcblk1p2 earlyprintk console=ttyS2,115200n8 rw rootwait"
fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} ${fdt_name}
fatload mmc ${devnum}:${distro_bootpart} ${kernel_addr_r} ${kernel_name}

echo setting up fdt for overlays
# append overlays as required
setenv overlay_error "false"
fdt addr ${fdt_addr_r}
fdt resize 65536
for overlay_file in ${overlays}; do
  echo "loading overlay ${overlay_file}"
	if fatload mmc ${devnum}:${distro_bootpart} ${load_addr} rockchip/overlays/${overlay_file}.dtbo; then
		echo "Applying kernel provided DT overlay ${overlay_file}.dtbo"
		fdt apply ${load_addr} || setenv overlay_error "true"
	fi
done
if test "${overlay_error}" = "true"; then
	echo "Error applying DT overlays, restoring original DT"
  fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} ${fdtfile}
fi

echo importing varsVolumio.txt
load mmc ${devnum} ${load_addr} varsVolumio.txt
env import -t ${load_addr} ${filesize}

echo loading the ramdisk
setenv volumioenv "/dev/mmcblk1p2"
setenv bootargs "consoleblank=0 scandelay root=${volumioenv} rw console=${console} rootfstype=ext4 loglevel=${verbosity} rootwait ${extraargs} imgpart=${volumioenv} imgfile=/volumio_current.sqsh"
#setenv bootargs "root=${volumioenv} earlyprintk console=ttyS2,115200n8 rootfstype=ext4 loglevel=${verbosity} rw rootwait ${extraargs} "
#fatload mmc ${devnum}:${distro_bootpart} ${ramdisk_addr_r} uInitrd
fatload mmc ${devnum}:${distro_bootpart} 0x0a200000 uInitrd
echo booting the kernel
#booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
booti ${kernel_addr_r} 0x0a200000 ${fdt_addr_r}
