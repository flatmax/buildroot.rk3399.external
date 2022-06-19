snd-soc-dummy-soundcard-objs := dummy-soundcard.o
obj-$(CONFIG_SND_SOC_DUMMY_SOUNDCARD)  += snd-soc-dummy-soundcard.o
dtbo-y += dummy-soundcard.dtbo

%.dtbo: %.dts
	dtc -o dtb -o $@ -b 0 -@ $<

targets += $(dtbo-y)
always-y  := $(dtbo-y)
