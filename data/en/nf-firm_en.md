<div id="main-page"></div>
<div class="divider" id="non-free-firmware"></div>
## Sources list and firmware drivers: non-free

### Sources list

As the siduction iso contains only dfsg free software, you will probably want to add `contrib non-free`  to your `/etc/apt/sources.list.d/debian.list`  :

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

Your lines should now look something like this, depending on your choice of mirror (refer to  [List of Debian Servers and mirrors and current status](http://www.debian.org/mirrors/)):

~~~  
# Debian  
deb http://ftp.de.debian.org/debian unstable main contrib non-free  
# deb-src http://ftp.de.debian.org/debian unstable main contrib non-free  
~~~

After altering your sources you need to `apt-get update`  before searching for or installing new packages, (apt-get update is good practice before installing any package).

<div class="divider" id="fw-detect"></div>
## Firmware detection - non-free

To install non-free firmware, (assumes `contrib non-free`  has been added to sources):

~~~  
apt-get update  
apt-get install firmware-linux firmware-linux-free firmware-linux-nonfree  
~~~

The required firmware can be determined with the following device/ firmware enumeration or by using the fw-detect script (packaged in siduction-scripts).

~~~  
$ fw-detect  
~~~

The output of fw-detect describes the commands needed to install and activate the firmware:

Example:

~~~  
#Detected driver that requires firmware to operate  
#Follow these instructions to obtain the correct firmware  
# and activate the zd1211rw driver:  
apt-get update  
apt-get install zd1211-firmware  
modprobe -r zd1211rw  
modprobe zd1211rw  
~~~

To install firmware from git repos, you need to:

~~~  
apt-get install git  
~~~

### non-free firmware debs on a stick

Should you need to prefetch firmware .debs, to put on a usb-key to transfer the files to another computer, you can download them as either a zip or tar.gz file from  [http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/sid/current/](http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/sid/current/)  and extract it to a folder called firmware, you should see a number of .deb files.

Next download  [http://packages.debian.org/sid/firmware-linux-free*.deb](http://packages.debian.org/sid/firmware-linux-free)  and add it to all the other debs in the folder you extracted the non-free firmware to. Then transfer them with the stick to the computer that needs the non-free firmware and:

~~~  
dpkg -i firmware-linux-nonfree.deb  
~~~

We try to provide packages for legally redistributable firmware from our non-free repositories, but not all vendors allow this.

<div class="divider" id="fircat"></div>
### Firmware Categories

+ ####  [WiFi 802.11](#ieee802.11)   
+ ####  [Bluetooth](#bluetooth)   
+ ####  [Ethernet](#eth)   
+ ####  [Modem](#modem)   
+ ####  [Serial/USB](#serial)   

+ ####  [Audio](#audio)   
+ ####  [Radio](#radio)   
+ ####  [TV](#tv)   
+ ####  [CPU](#cpu)   
+ ####  [Video](#video)   
+ ####  [VGA](#vga)   

<strong><a name="audio">audio</a></strong>
+  **`audio`**   
    + **`Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x `**  
        snd-cs46xx  
        /lib/firmware/cs46xx/cs46xx-old.fw   
    + **`EMI 2|6 `**  
        emi26  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=emi26;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=emi26;hb=HEAD)  /lib/firmware/emi26/   
        /lib/firmware/emi26/bitstream.bin /lib/firmware/emi26/firmware.fw /lib/firmware/emi26/loader.fw   
    + **`EMI 6|2m `**  
        emi62  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=emi62;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=emi62;hb=HEAD)  /lib/firmware/emi62   
        /lib/firmware/emi62/bitstream.bin /lib/firmware/emi62/loader.fw /lib/firmware/emi62/midi.fw /lib/firmware/emi62/spdif.fw   
    + **`Sound Blaster 16/AWE CSP `**  
        sb16  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=sb16;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=sb16;hb=HEAD)  /lib/firmware/sb16   
    + **`Korg 1212 IO `**  
        snd-korg1212  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=korg;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=korg;hb=HEAD)  /lib/firmware/korg   
        /lib/firmware/smctr/k1212.dsp   
    + **`ESS Allegro Maestro3 `**  
        snd-maestro3  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=ess;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=ess;hb=HEAD)  /lib/firmware/ess   
        /lib/firmware/ess/maestro3_assp_kernel.fw /lib/firmware/ess/maestro3_assp_minisrc.fw   
    + **`Yamaha YMF724/740/744/754 `**  
        snd-ymfpci  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=yamaha;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=yamaha;hb=HEAD)  /lib/firmware/yamaha   
        /lib/firmware/yamaha/ds1_ctrl.fw /lib/firmware/yamaha/ds1_dsp.fw /lib/firmware/yamaha/ds1e_ctrl.fw   
<strong><a name="bluetooth">bluetooth</a></strong>
+  **`bluetooth`**   
    + **`Atheros AR30xx Bluetooth chipset `**  
        ath3k  
        apt-get install firmware-atheros  
        /lib/firmware/ath3k-1.fw   
    + **`Broadcom Blutonium Bluetooth chipset (BCM203x) `**  
        bcm203x  
        apt-get install bluez-firmware  
<strong><a name="cpu">cpu</a></strong>
+  **`cpu`**   
    + **`Intel `**  
        apt-get install intel-microcode  
<strong><a name="eth">eth</a></strong>
+  **`eth`**   
    + **`Broadcom NetXtremeII (BCM5706/5708/5709/5716, bnx) `**  
        bnx2  
        apt-get install firmware-bnx2  
    + **`Broadcom NetXtremeII 10Gb (BCM57710/57711/57711E, bnx2x) `**  
        bnx2x  
        apt-get install firmware-bnx2x  
    + **`Chelsio Communications T3 10Gb Ethernet `**  
        cxgb3  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=cxgb3](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=cxgb3)  /lib/firmware/cxgb3/   
        /lib/firmware/cxgb3/*.bin   
    + **`Intel e100 (82559 D101M/ D101M, 82551-F, 82551-10), 100 MBit/s `**  
        e100  
        apt-get install firmware-linux-nonfree  
    + **`KLSI KL5USB101-based `**  
        klsi  
        apt-get install firmware-linux-nonfree  
    + **`Realtek RTL8111D(L), 1 GBit/s ethernet `**  
        r8169  
        apt-get install firmware-realtek  
        /lib/firmware/rtl_nic/rtl8168d-1.fw /lib/firmware/rtl_nic/rtl8168d-2.fw   
    + **`SMC ISA/MCA Token Ring `**  
        smctr  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob_plain;f=tr_smctr.bin;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob_plain;f=tr_smctr.bin;hb=HEAD)  
        /lib/firmware/smctr/tr_smctr.bin   
    + **`SUN Cassini GBit/s `**  
        sun  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=sun;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=sun;hb=HEAD)  /lib/firmware/sun   
    + **`Broadcom Tigon3 (tg3) `**  
        tg3  
        apt-get install firmware-linux-nonfree  
        /lib/firmware/tigon/tg3.bin /lib/firmware/tigon/tg3_tso5.bin /lib/firmware/tigon/tg3_tso.bin   
<strong><a name="ieee802.11">ieee802.11</a></strong>
+  **`ieee802.11`**   
    + **`Atmel AT76c50x 11 MBit/s `**  
        atmel* at76_usb  
        apt-get install atmel-firmware  
        /lib/firmware/atmel_at76c5   
    + **`b43 `**  
        b43  
        apt-get install firmware-b43-lpphy-installer  
        /lib/firmware/b43/b0g0bsinitvals5.fw /lib/firmware/b43/b0g0initvals5.fw /lib/firmware/b43/ucode5.fw   
        1. You should not need the proprietary firmware for most b43 802.11b/g wlan cards anymore. 2. The non-free firmware will be used in preference to the free firmware if both are installed.  
    + **`Broadcom b43legacy `**  
        b43legacy  
        apt-get install firmware-b43legacy-installer  
        /lib/firmware/b43legacy/ucode2.fw /lib/firmware/b43legacy/ucode4.fw /lib/firmware/b43legacy/pcm4.fw /lib/firmware/b43legacy/a0g0bsinitvals2.fw /lib/firmware/b43legacy/a0g0initvals2.fw /lib/firmware/b43legacy/b0g0bsinitvals2.fw /lib/firmware/b43legacy/b0g0initvals2.fw   
    + **`Broadcom b43legacy `**  
        b43legacy  
        apt-get install firmware-brcm80211  
        /lib/firmware/brcm/bcm43xx-0.fw /lib/firmware/brcm/bcm43xx_hdr-0.fw   
    + **`Intel ipw2100 (11 MBit/s) and Intel ipw2200 (54 MBit/s) `**  
        ipw2100 ipw2200  
        apt-get install firmware-ipw2x00  
        /lib/firmware/ipw2100   
    + **`Intel ipw3945/ iwlwifi, 54 Mbit/s and Intel ipw4965, iwl1000/ iwl5xxx, iwl6000, iwl6050/ iwlagn, draft-n `**  
        iwl4965 iwl3945 iwlwifi-* iwlagn  
        apt-get install firmware-iwlwifi  
        /lib/firmware/iwlwifi-3945-1.ucode /lib/firmware/iwlwifi-3945-2.ucode /lib/firmware/iwlwifi-4965-1.ucode /lib/firmware/iwlwifi-4965-2.ucode /lib/firmware/iwlwifi-5000-1.ucode /lib/firmware/iwlwifi-5000-2.ucode /lib/firmware/iwlwifi-5150-2.ucode   
    + **`Intersil prism54 (p54pci/ p54usb), 54 MBit/s `**  
        p54pci p54usb prism54  
         [http://jbnote.free.fr/prism54usb/](http://jbnote.free.fr/prism54usb/)  
    + **`Realtek RTL8188S 150/ RTL8191S/ RTL8192S 300 MBit/s USB WiFi cards `**  
        r8712u  
        apt-get install firmware-realtek  
        /lib/firmware/rtlwifi/rtl8712u.bin   
    + **`RaLink rt61, rt73, rt2860 and rt2870 54 MBit/s `**  
        rt73* rt61* rt28*  
        apt-get install firmware-ralink  
        /lib/firmware/rt73   
    + **`Realtek RTL8192E 150/ 300 MBit/s PCI WiFi cards `**  
        r8192e_pci  
        apt-get install firmware-realtek  
        /lib/firmware/RTL8192E/data.img /lib/firmware/RTL8192E/main.img /lib/firmware/RTL8192E/boot.img   
    + **`Realtek RTL8188S 150/ RTL8191S 300 MBit/s USB WiFi cards `**  
        r8192s_usb  
        apt-get install firmware-realtek  
        /lib/firmware/RTL8192SU/rtl8192sfw.bin   
    + **`ZyDAS zd1201 11 MBit/s `**  
        zd1201  
         [http://surfnet.dl.sourceforge.net/sourceforge/linux-lc100020/zd1201-0.14-fw.tar.gz](http://surfnet.dl.sourceforge.net/sourceforge/linux-lc100020/zd1201-0.14-fw.tar.gz)  
        /lib/firmware/zd1201   
    + **`ZyDAS zd1211 54 MBit/s `**  
        zd1211*  
        apt-get install zd1211-firmware  
        /lib/firmware/zd1211/zd1211   
<strong><a name="modem">modem</a></strong>
+  **`modem`**   
    + **`Atari DSP56k `**  
        dsp56k  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=dsp56k;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=dsp56k;hb=HEAD)  /lib/firmware/dsp56k   
    + **`Eagle ADSL `**  
        eagle  
         [http://eagle-usb.org/ueagle-atm/non-free/](http://eagle-usb.org/ueagle-atm/non-free/)  
<strong><a name="radio">radio</a></strong>
+  **`radio`**   
    + **`Digital Audio Broadcasting (DAB) Receiver `**  
        dabusb  
        apt-get install firmware-linux-nonfree  
        /lib/firmware/dabusb/bitstream.bin /lib/firmware/dabusb/firmware.fw   
<strong><a name="serial">serial</a></strong>
+  **`serial`**   
    + **`Computone IntelliPort Plus `**  
        computone  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob_plain;f=intelliport2.bin;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob_plain;f=intelliport2.bin;hb=HEAD)  
    + **`Inside Out Edgeport `**  
        edgeport  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=edgeport;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=edgeport;hb=HEAD)  /lib/firmware/edgeport/   
    + **`Keyspan USA-xxx `**  
        keyspan  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=keyspan;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=keyspan;hb=HEAD)  /lib/firmware/keyspan   
        /lib/firmware/keyspan/mpr.fw /lib/firmware/keyspan/usa18x.fw /lib/firmware/keyspan/usa19.fw /lib/firmware/keyspan/usq19qi.fw /lib/firmware/keyspan/usa19qw.fw /lib/firmware/keyspan/usa19w.fw /lib/firmware/keyspan/usa28.fw /lib/firmware/keyspan/usa28x.fw /lib/firmware/keyspan/usa28xa.fw /lib/firmware/keyspan/usa28xb.fw /lib/firmware/keyspan/usa49w.fw /lib/firmware/keyspan/usa19qw.fw /lib/firmware/keyspan/usa49wlc.fw   
    + **`Keyspan PDA single-port `**  
        keyspanda  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=keyspan_pda;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=keyspan_pda;hb=HEAD)  /lib/firmware/keyspan_pda   
    + **`TI 3410/5052 `**  
        ti_usb_3410_5052  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob_plain;f=ti_3410.fw;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob_plain;f=ti_3410.fw;hb=HEAD)  [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob;f=ti_5052.fw;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob;f=ti_5052.fw;hb=HEAD)   
        /lib/firmware/ti_usb_3410_5052/ti_3410.fw /lib/firmware/ti_usb_3410_5052/ti_5052.fw   
    + **`ConnectTech WhiteHEAT `**  
        whiteheat  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob_plain;f=whiteheat.fw;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob_plain;f=whiteheat.fw;hb=HEAD)  [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob;f=whiteheat_loader.fw;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=blob;f=whiteheat_loader.fw;hb=HEAD)   
        /lib/firmware/whiteheat/whiteheat.fw /lib/firmware/whiteheat/whiteheat_loader.fw   
<strong><a name="tv">tv</a></strong>
+  **`tv`**   
    + **`Afatech AF9005 DVB-T USB1.1 `**  
        dvb-usb-af9005  
        /lib/firmware/AF05BDA.sys   
    + **`Afatech AF9015 DVB-T `**  
        dvb-usb-af9015  
         [http://palosaari.fi/linux/v4l-dvb/firmware/af9015/5.1.0.0/dvb-usb-af9015.fw](http://palosaari.fi/linux/v4l-dvb/firmware/af9015/5.1.0.0/dvb-usb-af9015.fw)  
        /lib/firmware/dvb-usb-af9015.fw   
    + **`av7110 dvb `**  
        av7110  
        get_dvb_firmware av7110  
        /lib/firmware/dvb-ttpci-01.fw   
    + **`bluebird dvb `**  
        bluebird  
        get_dvb_firmware bluebird  
        /lib/firmware/dvb-usb-bluebird-01.fw   
    + **`dec2000t dvb `**  
        dec2000t  
        get_dvb_firmware dec2000t  
        /lib/firmware/dvb-ttusb-dec-dec2000t.fw   
    + **`dec2500t dvb `**  
        dec2500t  
        get_dvb_firmware dec2500t  
        /lib/firmware/dvb-ttusb-dec-dec20500t.fw   
    + **`dec3000t dvb `**  
        dec3000t  
        get_dvb_firmware dec3000t  
        /lib/firmware/dvb-ttusb-dec-dec3000t.fw   
    + **`diusb dvb `**  
        diusb  
        get_dvb_firmware diusb  
        /lib/firmware/dvb-diusb-5.0.0.11.fw   
    + **`various full featured DVB `**  
        dvb  
         [http://www.linuxtv.org/downloads/firmware/](http://www.linuxtv.org/downloads/firmware/)  
        most budget cards won't need this  
    + **`IVTV `**  
         [http://dl.ivtvdriver.org/ivtv/firmware/](http://dl.ivtvdriver.org/ivtv/firmware/)  
    + **`Technotrend/Hauppauge Nova `**  
        nova  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=ttusb-budget;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=ttusb-budget;hb=HEAD)  /lib/firmware/ttusb-budget/   
    + **`or51132_qam `**  
        or51132_qam  
        get_dvb_firmware or51132_qam  
        /lib/firmware/dvb-fe-or51132_qam.fw   
    + **`or51132_vsb dvb `**  
        or51132_vsb  
        get_dvb_firmware or51132_vsb  
        /lib/firmware/dvb-fe-or51132_vsb.fw   
    + **`or51211 dvb `**  
        or51211  
        get_dvb_firmware or51211  
        /lib/firmware/dvb-fe-or51211.fw   
    + **`sp8870 dvb `**  
        sp8870  
        get_dvb_firmware sp8870  
        /lib/firmware/dvb-fe-sp8870   
    + **`sp887x dvb `**  
        sp887x  
        get_dvb_firmware sp887x  
        /lib/firmware/dvb-fe-sp887x   
    + **`tda1004x dvb `**  
        tda1004x  
        get_dvb_firmware tda10046  
        /lib/firmware/dvb-fe-tda10046.fw   
<strong><a name="vga">vga</a></strong>
+  **`vga`**   
    + **`ATi r128 and Radeon r100-r780 `**  
        radeon  
        apt-get install firmware-linux-nonfree  
    + **`Matrox MGA 100-450 `**  
        matrox  
        apt-get install firmware-linux-nonfree  
    + **`nVidia `**  
        nv  
        3d acceleration isn't possible with free drivers yet  
<strong><a name="video">video</a></strong>
+  **`video`**   
    + **`cameras based on Vision's CPiA2 `**  
        cpia2  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=cpia2;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=cpia2;hb=HEAD)  /lib/firmware/cpia2/   
        /lib/firmware/cpia2/stv0672_vp4.bin   
    + **`3com HomeConnect (aka vicam) `**  
        vicam  
         [http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=vicam;hb=HEAD](http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=vicam;hb=HEAD)  /lib/firmware/vicam/   
        /lib/firmware/vicam/firmware.fw   

<div id="rev">Page last revised 14/01/2012 1800 UTC</div>
