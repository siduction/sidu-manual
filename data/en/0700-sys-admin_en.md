% System administration

# System Administration

This section contains informations and notes on

+ [Terminal - command line](0701-term-konsole_en.md#terminal---command-line), a basic introduction, working as root, configuring colors in a terminal, getting help in a terminal, and using scripts.

+ [Doas - Alternative to Sudo](0703-sys-admin-doas_en.md#doas---alternative-to-sudo), our recommendation for all those who miss *sudo*.

+ [System administration in general](0702-sys-admin-gen_en.md#system-administration-in-general). Short and sweet, we provide a stiff through system administration, boot options, managing systemd services, terminating processes, managing passwords, fonts in siduction, the printing system CUPS, and sound in siduction.

+ [APT package management](0705-sys-admin-apt_en.md#apt-package-management), package sources, managing packages, updating the system, searching program packages, and why to use apt exclusively. 

+ [Local APT mirror](0706-sys-admin-apt-localmirr_en.md#local-apt-mirror), apt-cacher, the proxy server for Debian packages, and how to install server as well as client configuration.

+ [Nala for package management](0707-sys-admin-nala_en.md#nala-package-management), a front-end that optimizes and accelerates APT for the user.

+ [Installing new kernels](0708-sys-admin-kern-upg_en.md#kernel-upgrade), upgrading the kernel  without a system upgrade, and removing 3rd party modules as well as old kernels.

+ [systemd - the system and services manager](0710-systemd-start_en.md#systemd---the-system-and-services-manager), the concept of systemd, unit types, systemd in the file system, and handling services.

    + [The systemd unit file](0711-systemd-unit-datei_en.md#systemd-unit-file), directories and hirarchies of unit files, the incorporation in systemd, the structure of unit files with a description of numerous options, the function of unit files on the example of CUPS, and the tools that systemd provides.

    + [systemd-service unit](0712-systemd-service_en.md#systemd-service), creating a service unit, and the description of all essential options.

    + [systemd-mount unit](0713-systemd-mount_en.md#systemd-mount), contents of the mount unit, contents of the automount unit, naming conventions, areas of use, and some examples.

    + [systemd-target - target unit](0714-systemd-target_en.md#systemd-target---target-unit), from runlevel to systemd-target, special features to consider. 

    + [systemd-path unit](0715-systemd-path_en.md#systemd-path), the required files, the options of path-unit, creating and including path-unit, and the example "Monitoring DocumentRoot of Apache web server".

    + [systemd-timer unit](0716-systemd-timer_en.md#systemd-timer), the required files, the options of the timer unit, creating as well as including timer units, and timer units as cron replacement.

+ [systemd-journal](0717-systemd-journald_en.md#system-journal), using journald locally and over a network, configuring journald, querying the systemd journal with journalctl, filtering and controlling the output, examples to master journalctl.

<div id="rev">Last edited: 2022-11-07</div>
