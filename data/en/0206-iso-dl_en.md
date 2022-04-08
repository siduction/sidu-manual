% Download and integrity check of ISOs

## Downloading the ISO

### siduction ISO download

Please use the closest mirror. Mirror servers listed below, with details for the entry in /etc/apt/sources.list.d/siduction.list, are updated in a timely manner.  

**Europe**  

+ Office Vienna, Vienna, Austria  
https://siduction.office-vienna.at/

+ Freie Universität Berlin/spline (Student Project LInux NEtwork), Germany  
http://ftp.spline.de/pub/siduction/  
https://ftp.spline.de/pub/siduction/  
ftp://ftp.spline.de/pub/siduction/

+ University of Stuttgart, Germany  
https://ftp.uni-stuttgart.de/siduction/  
ftp://ftp.uni-stuttgart.de/siduction/

+ Academic Computer Club, Umeå University, Sweden  
http://ftp.acc.umu.se/mirror/siduction.org/  
https://ftp.acc.umu.se/mirror/siduction.org/  
rsync://ftp.acc.umu.se/mirror/siduction.org/

+ Dotsrc.org, Aalborg University, Denmark  
http://mirrors.dotsrc.org/siduction/  
https://mirrors.dotsrc.org/siduction/  
ftp://mirrors.dotsrc.org/siduction/  
rsync://mirrors.dotsrc.org/siduction/

+ Yandex, Moscow, Russia  
https://mirror.yandex.ru/mirrors/siduction/  
http://mirror.yandex.ru/mirrors/siduction/  
ftp://mirror.yandex.ru/mirrors/siduction/  
rsync://mirror.yandex.ru/mirrors/siduction/

+ GARR Consortium, Italy  
http://siduction.mirror.garr.it/  
https://siduction.mirror.garr.it/

+ Quantum Mirror, Hungary  
http://quantum-mirror.hu/mirrors/pub/siduction/  
https://quantum-mirror.hu/mirrors/pub/siduction/  
rsync://quantum-mirror.hu/siduction/

+ Belnet, Brussels, Belgium  
http://ftp.belnet.be/mirror/siduction/  
https://ftp.belnet.be/mirror/siduction/  
ftp://ftp.belnet.be/mirror/siduction/  
rsync://ftp.belnet.be/siduction/

+ Gesellschaft für wissenschaftliche Datenverarbeitung mbH Göttingen, Germany  
https://ftp.gwdg.de/pub/linux/siduction/  
ftp://ftp.gwdg.de/pub/linux/siduction/  
rsync://ftp.gwdg.de/pub/linux/siduction/

+ RWTH Aachen, Germany  
http://ftp.halifax.rwth-aachen.de/siduction/
https://ftp.halifax.rwth-aachen.de/siduction/  
ftp://ftp.halifax.rwth-aachen.de/siduction/  
rsync://ftp.halifax.rwth-aachen.de/siduction/  

+ Studenten Net Twente, Netherlands  
http://ftp.snt.utwente.nl/pub/linux/siduction/  
https://ftp.snt.utwente.nl/pub/linux/siduction/  
ftp://ftp.snt.utwente.nl/pub/linux/siduction/  
rsync://ftp.snt.utwente.nl/siduction/

**Asia**

+ KoDDOS, Amarutu Technology, Hong Kong  
https://mirror-hk.koddos.net/siduction/  
http://mirror-hk.koddos.net/siduction/  
rsync://mirror-hk.koddos.net/siduction/

**South America**

+ Corporación Ecuatoriana para el Desarrollo de la Investigación y la Academia, Cuenca  
https://mirror.cedia.org.ec/siduction/  
http://mirror.cedia.org.ec/siduction/  
rsync://mirror.cedia.org.ec/siduction/

**North America**

+ Department of Mathematics, Princeton University, United States  
http://mirror.math.princeton.edu/pub/siduction/  
https://mirror.math.princeton.edu/pub/siduction/

+ Georgia Tech Software Library (GTlib), Atlanta, United States  
http://www.gtlib.gatech.edu/pub/siduction/  
ftp://ftp.gtlib.gatech.edu/pub/siduction/  
rsync://rsync.gtlib.gatech.edu/siduction/

+ Liquorix.net, United States  
https://liquorix.net/siduction/

### Files on the siduction mirrors

Each mirror includes the following files:

siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.arch.manifest  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.iso  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
SOURCES  

`xxx.manifest` The file lists all packages of the respective ISO.  
`xxx.iso` is the image file provided for download.  
`xxx.md5` and `xxx.sha256` contain the checksums of the image file and are used to verify the integrity of the ISO.  
`xxx.gpg` files are the signature files used to check checksum files (.md5 .sha256) for changes.  
`xxx.sources` contains the download links to the source code files of the packages used.

Download links and mirrors can be found at [siduction.org](https://forum.siduction.org/index.php?page=7).

The tar archive with the sources is interesting for those who want to redistribute siduction. Here, the source code must be published to comply with the license. More information can be found in the tar archive.

If someone can provide an FTP server with appropriate traffic, we are always available in the [siduction forums](https://siduction.org) or in IRC [irc.oftc.net #siduction-en](https://webchat.oftc.net/?nick=siducer007&channels=siduction-en). 

### Integrity check

**md5sum**

An md5sum is the checksum of a file. This checksum is used to check the integrity of the associated ISO image file. The siduction ISO image files and their corresponding md5sum files are always offered for download in the same directory. For example:

~~~
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso.md5
~~~

The integrity check creates an md5sum for the downloaded ISO image file and compares it to a sum we created earlier in the file with the `.md5` extension. If the checksums differ, the ISO image file has been modified or corrupted. This test protects against the use of manipulated ISO image files and it may save a lot of time troubleshooting a DVD that is not working.

Under Linux one changes in the terminal into the directory, in which both the ISO image file and the `.md5` file are. Then you get the md5sum of the ISO image file with **`md5sum siduction-*.iso`** and the content of the `.md5` file with **`cat siduction-*.iso.md5`**. If you connect the two commands together, the output is directly one below the other for easy comparison.

~~~
$ md5sum siduction-*.iso && cat siduction-*.iso.md5
358369ebc617613e3c58afc1af716827  siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
358369ebc617613e3c58afc1af716827 *siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
~~~

The check is even easier under Linux with the command **`md5sum -c`**. Attention, the call must be accompanied by the .md5 file.

~~~
    (Command and output on success)
$ md5sum -c siduction-21.3.0-wintersky-kde-amd64-202112231751.iso.md5
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso: OK

    (Command and output in case of an error)
$ md5sum -c siduction-21.3.0-wintersky-kde-amd64-202112231751.iso.md5
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso: ERROR
md5sum: WARNUNG: 1 calculated checksum did NOT fit
~~~

**sha256sum**

The check using sha256sum is identical to md5sum in terms of handling. The main difference is the security due to a 256 bit checksum (md5sum 128 bit).

**Windows**

With a download of the siduction ISO image file in Windows there is from Windows 7 within the Powershell the possibility with the preinstalled auxiliary program `CertUtil` to create checksums. The call is there:

~~~
CertUtil -hashfile C:\TEMP\<my_ISO_image.img> MD5
    or
CertUtil -hashfile C:\TEMP\<my_ISO_image.img> SHA256
~~~

For older Windows versions the program `md5summer` (486 KB) released under the General Public License is available.

<div id="rev">Last edited: 2022/04/07</div>
