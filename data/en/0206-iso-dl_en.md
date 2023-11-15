% siduction ISO download

## Downloading the ISO

Please use the closest mirror. Mirror servers listed below, with details for the entry in  
`/etc/apt/sources.list.d/siduction.list`, are updated in a timely manner.

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
https://ftp.halifax.rwth-aachen.de/siduction/  
rsync://ftp.halifax.rwth-aachen.de/siduction/  
ftp://ftp.halifax.rwth-aachen.de/siduction/  
http://ftp.halifax.rwth-aachen.de/siduction/

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
SHA256SUM  
SOURCES  


The `xxx.manifest` file lists all packages of the respective ISO.  
`xxx.iso` is the image file provided for download.  
The `xxx.md5` and `xxx.sha256` files are used to verify the integrity of the ISO.  
`xxx.sources` contains the download links to the source code files of the packages used.

Download links and mirrors can be found at [siduction.org](https://siduction.org/mirror/).

The tar archive with the sources is interesting for those who want to redistribute siduction. Here, the source code must be published to comply with the license. More information can be found in the tar archive.

If someone can provide an FTP server with appropriate traffic, we are always available in the [siduction forums](https://siduction.org) or in IRC [irc.oftc.net #siduction-en](https://webchat.oftc.net/?nick=siducer007&channels=siduction-en). 

### Integrity check

**md5sum**

An md5sum is the checksum of a file and is used to check the integrity of the associated file. The siduction ISO file and its respective m5sum files can be downloaded from the same directory. For example:

~~~
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso.md5
~~~

During the integrity check, a md5sum is created for the downloaded ISO file and then compared to a sum in the file with the `.md5` extension that we have created in advance. If the check sums deviate, the has been changed or damaged. This test protects you from using a manipulated ISO file and saves you a lot of time for debugging in case of a non functioning DVD.

On Linux, use the terminal and navigate to the directory containing both the ISO file and the `.md5` file. Then you can get the ISO file's checksum by entering **`md5sum siduction-*.iso`** and the the `.md5` file's content with **`cat siduction-*.iso.md5`**. If you combine the two commands, the output is given one upon the other and is thus easy to compare.

~~~
$ md5sum siduction-*.iso && cat siduction-*.iso.md5
358369ebc617613e3c58afc1af716827  siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
358369ebc617613e3c58afc1af716827 *siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
~~~

The check is made even easier on Linux with the **`md5sum -c`**. Note that you need to specify the .md5 file in this command.

~~~
    (command and output in case of success)
$ md5sum -c siduction-21.3.0-wintersky-kde-amd64-202112231751.iso.md5
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso: OK

    (command and output in case of error)
$ md5sum -c siduction-21.3.0-wintersky-kde-amd64-202112231751.iso.md5
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso: FEHLSCHLAG
md5sum: WARNUNG: 1 berechnete Prüfsumme passte NICHT
~~~

**sha256sum**

A check using the sha256sum works exactly like the one with md5sum. The major difference is the increased security due to a 256 Bit check sum (md5sum: 128 Bit).

**Windows**

If you have downloaded the siduction ISO file on Windows 7 or later, the Powershell provides the preinstalled `CertUtil` helper program to create check sums. You can call it like this:

~~~
CertUtil -hashfile C:\TEMP\<my_ISO_file.img> MD5
    or
CertUtil -hashfile C:\TEMP\<my_ISO_file.img> SHA256
~~~

On older Windows versions you can use the `md5summer` program (486 kB) published under the General Public License.

<div id="rev">Last edited: 2022/04/12</div>
