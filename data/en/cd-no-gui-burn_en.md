<div id="main-page"></div>
<div class="divider" id="burning-no-gui"></div>
## Burning CD/DVD without a GUI

###### **`THIS IS VERY IMPORTANT:`** `siduction, as a Linux LIVE-CD, is based on high compression technology, and because of that, special care is needed when burning the ISO image. Only use high quality CD-media [or DVD+RW] and burn in **`DAO-mode (disk-at-once)`**  and not faster than x8.` 


---

## burniso

`You do not need a GUI to burn an ISO to a CD or DVD.`

Problems with burning mostly happen with the frontend (k3b), not so much with the backends (growisofs, wodim or cdrdao).

`siduction provides a ready made script to burn an siduction ISO called 'burniso'.` 

burniso burns ISO images on media, using Disk-At-Once mode and a hard coded speed of 8x, using wodim. 

~~~  
apt-get install siduction-scripts  
~~~

`As $User:` 

~~~  
$ cd /dir/containing/your/ISO  
~~~

~~~  
$ burniso  
~~~

All ISO images in the current directory are presented and will start burning right after your selection of an ISO, so be sure you have your media inserted.

<div class="divider" id="burn-no-gui-gen"></div>
## What devices to use, as $user:

To check the cd/dvd drive options and capabilities for ATAPI devices:

~~~  
$ wodim --devices  
wodim: Overview of accessible drives (2 found) :  
---------------------------------------------------------  
0 dev='/dev/scd0' rwrw-- : 'AOPEN' 'CD-RW CRW2440'  
1 dev='/dev/scd1' rwrw-- : '_NEC' 'DVD_RW ND-3540A'  
---------------------------------------------------------  
~~~

Other alternatives are:

~~~  
$ wodim dev=/dev/scd0 driveropts=help -checkdrive  
~~~

and

~~~  
$ wodim -prcap  
~~~

#### Here are some useful examples using 'scd0':

##### Information about a blank CD/DVD:

~~~  
$ wodim dev=/dev/scd0 -atip  
~~~

or

~~~  
$ cdrdao disk-info --device ATA:1,0,0  
~~~

##### Delete a rewritable disk:

~~~  
$ wodim -blank=fast -v dev=/dev/scd0  
~~~

or

~~~  
$ cdrdao blank --device ATA:1,0,0 --blank-mode minimal  
~~~

##### Clone a cd:

~~~  
$ cdrdao copy --fast-toc --device ATA:1,0,0 --buffers 256 -v2  
~~~

##### Clone a cd on the fly:

~~~  
$ cdrdao copy --fast-toc --source-device ATA:1,1,0 --device ATA:1,0,0 --on-the-fly --buffers 256 --eject -v2  
~~~

##### Create an audio cd from wav files with 12x speed:

~~~  
$ wodim -v -eject -pad -dao speed=12 dev=/dev/scd0 defpregap=0 -audio *.wav  
~~~

##### Burn a cd from bin/cue files:

~~~  
$ cdrdao write --speed 24 --device ATA:1,0,0 --eject filenam.cue  
~~~

##### Burn an ISO image:

~~~  
$ wodim dev=/dev/scd0 driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso  
~~~

If you get a `driveropts`  error, it is because `burnfree`  is deprecated for some devices, therefore:

~~~  
$ wodim dev=/dev/scd0 driveropts=noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso  
~~~

or

~~~  
$ wodim dev=/dev/scd0 fs=14M speed=8 -dao -eject -overburn -v siduction.iso  
~~~

##### Create an ISO image with all files (and subdirs) of a directory.

This can be burned with the command above (burn ISO image):

~~~  
$ genisoimage -o myImage.iso -r -J -l directory  
~~~

If you have a DVD burner, you can also use growisofs for burning to DVD, like burning an ISO image to DVD:

~~~  
$ growisofs -dvd-compat -Z /dev/dvd=image.iso  
~~~

##### Burn multiple files to DVD:

~~~  
$ growisofs -Z /dev/dvd -R -J file-1 file-2 file-3 ...  
~~~

##### If there is space left on the DVD, you can append more files:

~~~  
$ growisofs -M /dev/dvd -R -J file-1 file-2 file-3...  
~~~

##### To finalise the session, you use:

~~~  
$ growisofs -M /dev/dvd=/dev/zero  
~~~

<div id="rev">Page last revised 08/01/2012 1800 UTC</div>
