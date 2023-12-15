% siduction scripts

## Scripts for siduction

### User executable

siduction provides some scripts that support administrative tasks and help with troubleshooting.

- **chroothelper**  
  *Change to a chroot environment*

  *chroothelper* simplifies switching to a chroot environment on the live system. It searches the hard disks for installed Linux operating systems and offers to chroot to them.

- **sshactivate - sshdeactivate**  
  *Starts and enable sshd or stop and disable sshd*

  *sshactivate* generates sshd system keys, starts and enable the ssh daemon and asks for user password, to allow remote access to the (live-)system.  
  *sshdeactivate* stop and disable the ssh daemon.

- **fw-detect**  
  *Check system firmware status*

  *fw-detect* scans the loaded modules on your system, checks if they require firmware and checks if the firmware is present in the correct location.
By default it will only output information about any modules which appear to require firmware.

- **siduction-irc**  
  *Starts an IRC session to #siduction*

  *siduction-irc* starts an IRC session with following clients depends on the environment, HEXCHAT, IRSSI, KONVERSATION, KVIRC, WEECHAT, XCHAT and connects to our IRC-channel #siduction on [OFTC](https://www.oftc.net).

- **remove-nonfree**  
  *DFSG compliant installation*

  *remove-nonfree* makes the install DFSG compliant. Running it might on the other hand lead to a not working wifi or problems with your graphics card.

- **kernel-remover**  
  *removes siduction kernels*

  *kernel-remover* removes unused kernels from the running system. It offers a selection of kernels, removes the selected ones and updates the boot menu.

### Active in the background

- **siduction-btrfs**  
  *Checks and updates the boot menu*

  *siduction-btrfs* is a compilation of scripts and systemd units that become active on an installation in the Btrfs file system. After a snapshot or rollback, the boot menu is checked and updated if necessary. *siduction-btrfs* works in the background without user input.

<div id="rev">Last edited: 2023/12/08</div>
