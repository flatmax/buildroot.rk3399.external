# var.txt loading is throwing errors : "Synchronous Abort" handler, esr
# skipped for now
#echo "loading boot vars"
#setenv load_addr "0x9000000"
#load mmc ${devnum} ${load_addr} vars.txt
#echo importing vars of size ${filesize}
#env import -t ${load_addr} ${filesize}

echo setting bootargs
setenv bootargs "root=/dev/mmcblk1p2 earlyprintk console=ttyS2,115200n8 rw rootwait"
echo loading dtb
#fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} ${fdt_name}
fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} rockchip/rk3399-nanopi-m4.dtb
echo loading kernel
#fatload mmc ${devnum}:${distro_bootpart} ${kernel_addr_r} ${kernel_name}
fatload mmc ${devnum}:${distro_bootpart} ${kernel_addr_r} Image

echo loading overlays
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
echo booting
booti ${kernel_addr_r} - ${fdt_addr_r}
