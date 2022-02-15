echo "Setting defaults"
setenv load_addr "0x6000000"
echo Set the load address to ${load_addr}

echo Importing vars.txt
load mmc ${devnum} ${load_addr} vars.txt
env import -t ${load_addr} ${filesize}

echo Loading the fdt and kernel
fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} ${fdt_name}
fatload mmc ${devnum}:${distro_bootpart} ${kernel_addr_r} ${kernel_name}

echo "Setting up fdt for overlays"
# append overlays as required

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

echo Importing varsVolumio.txt
load mmc ${devnum} ${load_addr} varsVolumio.txt
env import -t ${load_addr} ${filesize}

echo Setting volumioargs
setenv volumioargs "imgpart=${imgpart} imgfile=${imgfile} bootpart=${bootpart} datapart=${datapart} bootconfig=${bootconfig} hwdevice=${hwver}"
echo image partition: ${imgpart}
echo image file:      ${imgfile}
echo boot partition:  ${bootpart}
echo data partition:  ${datapart}
echo bootconfig:      ${bootconfig}
echo hwdevice:        ${hwver}
echo Setting bootargs
setenv bootargs "${volumioargs} loglevel=${verbosity} ${extraargs} consoleblank=0 scandelay earlyprintk console=ttyS2,1500000n8 rw rootwait"
echo "bootargs:" ${bootargs}

echo Loading the ramdisk
fatload mmc ${devnum}:${distro_bootpart} ${ramdisk_addr_r} uInitrd
echo Booting the kernel
booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}

#setenv devnum 1; setenv distro_bootpart 1; echo $devnum; echo $distro_bootpart

#setenv ramdisk_addr_r 0x04000000
