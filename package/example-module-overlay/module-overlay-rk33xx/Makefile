snd-soc-module-overlay-rk33xx-objs := module-overlay-rk33xx.o
obj-$(CONFIG_SND_SOC_MODULE_OVERLAY_RK33XX)  += snd-soc-module-overlay-rk33xx.o
dtbo-y += module-overlay-rk33xx.dtbo

%.dtbo: %.dts
	dtc -o dtb -o $@ -b 0 -@ $<

targets += $(dtbo-y)
always-y  := $(dtbo-y)
