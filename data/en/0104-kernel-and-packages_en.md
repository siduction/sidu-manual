% Kernel

## Kernel and software packages

The Linux kernel of siduction is optimized to achieve the following goals: problem solving, enhanced and updated features, performance optimization, higher stability. The basis is always the latest kernel from [http://www.kernel.org/](https://www.kernel.org/).  
siduction is based on Debian Sid, which can lead to Debian packages containing errors in rare cases. Therefore, we may offer packages that temporarily replace faulty Debian packages.

### The management of software packages

siduction follows Debian rules regarding package structure and uses `apt` as well as `dpkg` for software package management. The Debian and siduction repositories are located in `/etc/sources.list.d/*`. 

Debian Sid contains more than 20,000 program packages, so the chances of finding a program suitable for a task are very good. Information on how to search for program packages can be found here:  
[Search program packages](0705-sys-admin-apt_en.md#searching-for-program-packages) .

A program package is installed with this command:

~~~
apt install <package_name>
~~~

See also: [Install new packages](0705-sys-admin-apt_en.md#install-packages).

New and updated software packages are pushed to Debian Sid Repositories four times a day. Quick package management is achieved by using a local database. The command

~~~
apt update
~~~

is necessary before each installation of a new software package to synchronize the local database with the repositories' software supply.

**The use of other Debian based repositories, sources, and RPMs**.  
Installations from source code are not supported. It is recommended to compile as user (not root) and to place the application in the home directory without installing it onto the system. The use of `checkinstall` to generate DEB packages should be limited to purely private use. Conversion programs for RPM packages like `alien` are not recommended either.

Other well-known (and lesser-known) Debian based distributions create new packages with a structure different from Debian. They often use other directories for programs, scripts, and files during installation, which can lead to unstable systems. Some packages cannot be installed at all because of unresolvable dependencies, different naming conventions, or different versioning. For example, a different version of glibc may result in the inability to execute any program at all.

For this reason, Debian's repositories should be used to install the required software packages. Other software sources may be difficult or impossible to support by siduction. This includes packages and PPAs from Ubuntu.

### Updating the system - upgrade

An upgrade can only be performed when X graphics server is stopped. To stop the graphics server, the following command can be entered into a console as **root**:

~~~
init 3
~~~

After that, system updates can be performed safely. First, refresh the local package database with

~~~
apt update
~~~

Then update the system with one of the two alternatives

~~~
apt upgrade
apt full-upgrade
~~~

Afterwards, start the graphical user interface with the following command:

~~~
init 5
~~~

**apt full-upgrade** is the recommended procedure to upgrade a siduction installation to the latest version. It is described in more detail here:  
[Updating an installed system - full-upgrade](0705-sys-admin-apt_en.md#updating-the-system).

<div id="rev">Last edited: 2023/11/15</div>
