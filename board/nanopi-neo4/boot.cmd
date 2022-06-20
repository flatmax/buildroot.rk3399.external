setenv load_addr "0x6000000"
echo "loading boot vars"
load mmc ${devnum} ${load_addr} vars.txt
env import -t ${load_addr} ${filesize}

echo setting bootargs then loading the fdt and kernel
setenv bootargs "root=/dev/mmcblk0p2 earlyprintk console=ttyS2,115200n8 swiotlb=1 coherent_pool=1m rw rootwait"
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
  fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} ${fdt_name}
fi
echo booting
booti ${kernel_addr_r} - ${fdt_addr_r}
