BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC1**

Necessary work:

+ check intern links  
+ check extern links  
+ check layout  
+ check spelling  

Work done


END   INFO AREA FOR THE AUTHORS  
% Burn DVD without GUI

## Burn DVD without GUI

> **IMPORTANT INFORMATION:**  
> siduction, as a Linux LIVE DVD/CD, is very heavily compressed. For this reason, special attention must be paid to the burning method of the ISO image. We recommend high quality CD media (or DVD+R), burning in DAO mode (disk-at-once) and not faster than eight times (8x).


### burniso

You don't necessarily need a graphical user interface (GUI) to burn a CD/DVD.

Problems that occur during burning are usually caused by frontends like K3b, not so often by backends like growisofs, wodim or cdrdao.

siduction provides a script called "burniso" to burn the siduction ISO.

burniso burns ISO image files using wodim in disk-at-once mode with a fixed burning speed of 8x.

~~~sh
# apt-get install siduction-scripts
~~~

As $user:

~~~sh
$ cd /path/to/ISO
$ burniso
~~~

All ISO image files in the current directory will be offered for selection, and the burning process will start immediately after an ISO file is selected. Therefore, you should make sure that the media to be burned to is already inserted before starting the script.  

### Available devices

For ATAPI devices:

wodim:

~~~sh
$ wodim --devices
wodim: Overview of accessible drives (2 found) :
---------------------------------------------------------
0 dev='/dev/scd0' rwrw-- : 'AOPEN' 'CD-RW CRW2440'
1 dev='/dev/scd1' rwrw-- : '_NEC' 'DVD_RW ND-3540A'
---------------------------------------------------------
~~~

Other alternatives are:

~~~sh
$ wodim dev=/dev/scd0 driveropts=help -checkdrive
~~~

and

~~~sh
$ wodim -prcap
~~~

cdrdao device check:

~~~sh
$ cdrdao scanbus
Cdrdao version 1.2.1 - (C) Andreas Mueller
ATA:1,0,0 AOPEN , CD-RW CRW2440 , 2.02
ATA:1,1,0 _NEC , DVD_RW ND-3540A , 1.01
~~~

### Useful examples

**Information about blank CDs/DVDs:**

~~sh
$ wodim dev=/dev/scd0 -atip
~~~

or

~~~sh
$ cdrdao disk-info --device ATA:1,0,0
~~~

**Erase a rewritable blank disk:**

~~~sh
$ wodim -blank=fast -v dev=/dev/scd0
~~~

or

~~~sh
$ cdrdao blank --device ATA:1,0,0 --blank-mode minimal
~~~

**Copy a CD:**

~~~sh
$ cdrdao copy --fast-toc --device ATA:1,0,0 --buffers 256 -v2
~~~

**Copy a CD "on the fly":**

~~~sh
$ cdrdao copy --fast-toc --source-device ATA:1,1,0 --device ATA:1,0,0 --on-the-fly --buffers 256 --eject -v2
~~~

**Burn an audio CD with wav files at 12x speed:**

~~~sh
$ wodim -v -eject -pad -dao speed=12 dev=/dev/scd0 defpregap=0 -audio *.wav
~~~

**Burn a CD using a bin/cue image:**

~~~sh
$ cdrdao write --speed 24 --device ATA:1,0,0 --eject filenam.cue
~~~

**Burn CD from an ISO image:**

~~~sh
$ wodim dev=/dev/scd0 driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso
~~~

If you get an error message about driveropts, it is because burnfree is not possible on some burners. This is solved like this:

~~~sh
$ wodim dev=/dev/scd0 driveropts=noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso
~~~

or like this:

~~~sh
$ wodim dev=/dev/scd0 fs=14M speed=8 -dao -eject -overburn -v siduction.iso
~~~

**Create an ISO image file from a folder and all subfolders:**

~~~sh
$ genisoimage -o siduction.iso -r -J -l directory
~~~

**You can use growisofs to burn a DVD, in the example an ISO file:**

~~~sh
$ growisofs -dvd-compat -Z /dev/dvd=siduction.iso
~~~

**Burn multiple files to DVD:**

~~~sh
$ growisofs -Z /dev/dvd -R -J file1 file2 file3 ...
~~~

**If there is still space on the DVD, you can add files:**

~~sh
$ growisofs -M /dev/dvd -R -J still_one_file and_still_one_file
~~~

**To close a session:**

~~~sh
$ growisofs -M /dev/dvd=/dev/zero $
~~~~

<div id="rev">Last edited: 2021-13-08</div>

