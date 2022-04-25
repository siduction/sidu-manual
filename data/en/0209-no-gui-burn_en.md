% Burn DVD without GUI

## Burn Live-DVD without GUI

> **IMPORTANT INFORMATION:**  
> siduction, as a Linux LIVE DVD/CD, is heavily compressed. For this reason, special attention must be paid to the burning method of the image. Please use high quality media, burning in DAO mode (Disk-At-Once), and not faster than eight times (8x).

You don't necessarily need a graphical user interface (GUI) to burn a CD/DVD.  
Problems that occur during burning are usually caused by frontends like K3b, not so often by backends like growisofs, wodim, or cdrdao.

Before burning the ISO image file to a DVD, you should always check it using the md5sum or sha256sum offered by siduction. This may save a lot of time troubleshooting a changed or corrupted file.  
Detailed instructions can be found in the manual chapter [ISO Download, Integrity Check](0206-iso-dl_en.md#integrity-check).

### burniso

siduction provides a script called `burniso`.  
It burns ISO image files, using wodim in Disk-At-Once mode with a fixed burning speed of 8x. First burniso tests if the necessary hardware is available and then lists all recognized ISO image files. 

As **user**, change to the directory with the ISO image files and call `burniso`:

~~~
$ cd /path/to/ISO
$ burniso
Using device /dev/sr0.
Choose an ISO to burn: 
1) siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
2) siduction-21.3.0-wintersky-lxqt-amd64-202112231805.iso
3) siduction-21.3.0-wintersky-xfce-amd64-202112231826.iso
#? _
~~~

After entering the number for the desired ISO image file, `burniso` checks the integrity if there is an associated `.md5` file in the same directory. If successful, the burning process starts immediately afterwards. Therefore you should make sure that the medium to be burned to is already inserted before starting the script.

Burniso perfects and simplifies one single function for the user, namely burning ISO images. In addition, the command line programs offer all the possibilities to create media with data of various types on CD, DVD, and BD. In the following chapter we show some examples that are often used.

### Burning with cdrdao wodim growisofs

The command line programs are the basis for the popular GUI programs like `K3b`, `Brasero`, or `Xfburn`. Those who prefer the full range of options offered by the programs `cdrdao`, `wodim`, `growisofs`, etc. use the command line. We present only a minimal part of the possibilities here. Studying the manpages should be self-evident and is a bit easier with the examples. In addition, tips for your own project can be found on the Internet with the search engine of choice.

### Available devices

If the available hardware for burning is not exactly known, the programs wodim and cdrdao analyze the device data and output the information. First `wodim` for an external DVD writer to USB:

~~~
$ wodim -checkdrive
Device was not specified. Trying to find an [...] drive...
Detected CD-R drive: /dev/sr0
[...]
Vendor_info    : 'HL-DT-ST'
Identification : 'DVDRAM GP50NB40 '
Revision       : 'RB00'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc DVD-R(W) driver (mmc_mdvd).
Driver flags   : SWABAUDIO BURNFREE 
Supported modes: PACKET SAO
~~~

The output for the same device with `cdrdao`:

~~~
$ cdrdao scanbus
Cdrdao version 1.2.4 - (C) Andreas Mueller
/dev/sr0 : HL-DT-ST, DVDRAM GP50NB40 , RB00
~~~

Another example with `wodim` on another PC with two IDE/ATAPI devices:

~~~
$ wodim --devices
wodim: Overview of accessible drives (2 found) :
---------------------------------------------------------
0 dev='/dev/scd0' rwrw-- : 'AOPEN' 'CD-RW CRW2440'
1 dev='/dev/scd1' rwrw-- : '_NEC' 'DVD_RW ND-3540A'
---------------------------------------------------------
~~~

To use the correct recorder, we first of all need the exact name for of the device file (*"/dev/sr0"* or *"/devscd1"*).

### Examples for CD DVD BD

In the examples, we do not provide extensive explanations of the options used. Please consult the man pages for detailed information.

**Burning a CD/DVD from an ISO image**

Wodim recognizes by the filename extension `*.iso` and the option `-dao` that an image is to be burned.

~~~
$ wodim dev=/dev/scd0 driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -v <image.iso>
~~~

If you get an error message concerning *"driveropts "*, this is because burnfree is not possible on some burners. This is solved by removing the driveropts from the command.

~~~
$ wodim dev=/dev/sr0 fs=14M speed=8 -dao -eject -v <image.iso>
~~~

With `genisoimage` and `growisofs` you can create an ISO image file from a folder and all subfolders and burn it afterwards.

~~~
    (create ISO)
$ genisoimage -o <my-image.iso> -r -J -l <directory>
    (burn ISO)
$ growisofs -dvd-compat -Z /dev/dvd=<my-image.iso>
~~~

Burn a CD using a bin/cue image:

~~~
$ cdrdao write --speed 24 --device ATA:1,0,0 --eject filename.cue
~~~

**Erase a rewritable blank disk**

In order to add new data to rewritable media, it must first be erased. The commands for deleting the tables of contents are:

~~~
$ wodim -blank=fast -v dev=/dev/scd0
   (or)
$ cdrdao blank --device ATA:1,0,0 --blank-mode minimal
~~~

If you want to overburn the entire data, use `-blank=all` for wodim and `-blank-mode full` for cdrdao.


**Copy CD/DVD**

It is possible to copy even if there is only one drive. After reading, the source media is ejected and you have to insert the blank blank media into the same drive to continue.

~~~
$ cdrdao copy --fast-toc --device ATA:1,0,0 --buffers 256 -v2
~~~

You can copy a CD on the fly if two drives are available.

~~~
$ cdrdao copy --fast-toc --source-device ATA:1,1,0 --device ATA:1,0,0 --on-the-fly --buffers 256 --eject -v2
~~~

**Burn an audio CD**

Burn all wav files in the current folder at 12x speed.

~~~
$ wodim -v -eject -pad -dao speed=12 dev=/dev/scd0 defpregap=0 -audio *.wav
~~~

**Burn files to DVD**

~~~
$ growisofs -Z /dev/dvd -R -J file1 file2 file3 ...
~~~

If there is still space on the DVD, you can add files using the `-M` option.

~~~
$ growisofs -M /dev/dvd -R -J file8 file9
~~~

This command fills the remaining free space on the DVD with zeros and closes the media.

~~~
$ growisofs -M /dev/dvd=/dev/zero
~~~~

<div id="rev">Last edited: 2022/04/11</div>

