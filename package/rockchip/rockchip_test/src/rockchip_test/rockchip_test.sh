#!/bin/sh
### file: rockchip_test.sh
### author: yhx@rock-chips.com
### function: ddr cpu gpio audio usb player ehernet sdio/pcie(wifi) 
### date: 20180327

moudle_env()
{
   export  MODULE_CHOICE
}

module_choice()
{  
    echo "*****************************************************"
    echo "***                                               ***"
    echo "***        ********************                   ***"
    echo "***       *ROCKCHIPS TEST TOOLS*                  ***"
    echo "***        *                  *                   ***"
    echo "***        ********************                   ***"
    echo "***                                               ***"
    echo "*****************************************************"

    
    echo "*****************************************************"
    echo "ddr test :            1 (memtester & stressapptest)"
    echo "cpu_dvfs_test:        2 (dvfs stresstest)"
    echo "flash stress test:    3"
    echo "bluetooth test:       4 (bluetooth on&off test)"
    echo "audio test:           5"
    echo "recovery test:        6 (default wipe all)"
    echo "player test:          7 "
    echo "suspend_resume test:  8 (suspend & resume)"
    echo "wifi test:            9"
    echo "ethernet test:        10"
    echo "IR test:              11"
    echo "QT test:              12"
    echo "auto reboot test:     13"
    echo "ddr freq scaling test 14"
    echo "*****************************************************"

    echo  "please input your test moudle: "
    read -t 30  MODULE_CHOICE
}

ddr_test()
{
    sh /rockchip_test/ddr/ddr_test.sh
}

cpu_dvfs_test()
{
    sh /rockchip_test/dvfs/dvfs_test.sh
}

flash_stress_test()
{
   bash /rockchip_test/flash_test/flash_stress_test.sh 5 20000&
}

recovery_test()
{
    sh /rockchip_test/recovery_test/auto_reboot.sh
}

player_test()
{
    sh /test_plan/player/test.sh
}

suspend_resume_test()
{
   sh /rockchip_test/suspend_resume/suspend_resume.sh
}

wifi_test()
{
    sh /rockchip_test/wifi/wifi_test.sh
}

ethernet_test()
{
   sh /test_plan/ethernet/eth_test.sh 
}

bluetooth_test()
{
    sh /rockchip_test/bluetooth/bt_onoff.sh &
}

audio_test()
{
    sh /rockchip_test/audio/audio_functions_test.sh
}

ir_test()
{
    sh /test_plan/ir/ir_test.sh
}

qt_test()
{
	sh /test_plan/qt/mipi_test.sh
}

auto_reboot_test()
{
	fcnt=/data/config/rockchip_test/reboot_cnt;
	if [ -e "$fcnt" ]; then
		rm -f $fcnt;
	fi
	sh /rockchip_test/auto_reboot/auto_reboot.sh
}

ddr_freq_scaling_test()
{
	bash /rockchip_test/ddr/ddr_freq_scaling.sh
}

module_test()
{
    case ${MODULE_CHOICE} in
        1)
            ddr_test
            ;;
        2)
            cpu_dvfs_test
            ;;
        3)
            flash_stress_test
            ;;
        4)
            bluetooth_test
            ;;
        5)
            audio_test
            ;;
        6)
            recovery_test
            ;;
        7)
            player_test
            ;;
        8)
            suspend_resume_test
            ;;
        9)
            wifi_test
            ;;
        10)
            ethernet_test
            ;;
        11)
            ir_test
            ;;
        12)
            qt_test
            ;;
	13)
            auto_reboot_test
            ;;
	14)
	   ddr_freq_scaling_test
	    ;;
    esac
}

module_choice
module_test



