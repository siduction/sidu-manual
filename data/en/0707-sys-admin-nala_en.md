% Nala for package management

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

+ Translated with DeepL  
+ Need review

ENDE   INFOBEREICH FÜR DIE AUTOREN

## Nala package management

**More user-friendly and powerful than APT**

Nala is a command line frontend for the APT package manager. It uses the `python-apt` API instead of the APT libraries to manage packages. The goal of Nala is to provide a clearer and more user-friendly display of both the current package inventory and the requested actions and their execution. It is also intended to speed up the download of packages.


Nala uses many of the same commands from APT, such as `install`, `remove`, `purge`, `update`, `show` and `search`. It also implements the `history` command to see past transactions and allow the user to undo them, and the `fetch` command that displays a list of the fastest mirror servers to choose from. By default, Nala speeds up downloads by fetching three packets at a time from a server. The limit of three connections per mirror exists to minimize the load on the mirrors.

### Use Nala

As of siduction 2022.12.0, Nala is installed automatically and can be used immediately. A look at the manpage **`man nala`** should be mandatory. Before use we strongly recommend to make a change in the configuration file `/etc/nala/nala.conf`.  

We change the value for the `auto_remove` configuration option to `false` as shown in the following listing:

~~~
# Set to false to disable auto auto-removing
auto_remove = false
~~~

The reason for this is the use of *debian sid* as the basis for siduction. When upgrading sid, occasionally a situation may arise where significant parts of the system are to be removed. With the option `auto_remove = true` we have no way to research, check and decide for ourselves if or which packages to remove. Even in normal operation packages should not be removed with `auto_remove`, but only after a visual check.

### Commands analogous to APT

Many of the commands known from APT are identical in Nala. By default, Nala always expects confirmation before performing a requested action that changes the system.

+ **`nala update`**  
  Updates the package information of the configured package sources.
  
+ **`nala install <package>`**  
  Installs the named package into our system.
  
+ **`nala remove <package>`**  
  Removes the named package from our system.
  
+ **`nala purge <package>`** or **`nala remove --purge <package>`**  
  Removes the named package with its configuration files from our system.
  
+ **`nala upgrade`**  
  Runs `update` followed by `dist-upgrade`.

The user-friendly formatting of the output in the terminal facilitates the overview, as the example shows.  
(To gain root privileges, *"doas "* was used in the command).

~~~
user1@pc1:~$ doas nala install yapf3
============================================================
 Installing
============================================================
  Package:            Version:                       Size:
  python3-yapf        0.32.0-1                      133 KB
  yapf3               0.32.0-1                       30 KB

============================================================
 Summary
============================================================
 Install 2 Packages

 Disk space required  892 KB

Do you want to continue? [Y/n] y
╭─ Installing packages ────────────────────────────────────╮
│Unpacking:  python3-yapf (0.32.0-1)                       │
│Unpacking:  yapf3 (0.32.0-1)                              │
│Setting up: python3-yapf (0.32.0-1)                       │
│Setting up: yapf3 (0.32.0-1)                              │
│Processing: triggers for runit (2.1.2-50)                 │
│Processing: triggers for man-db (2.11.0-1+b1)             │
│Running kernel seems to be up-to-date.                    │
│No services need to be restarted.                         │
│No containers need to be restarted.                       │
│No user sessions are running outdated binaries.           │
│No VM guests are running outdated hypervisor (qemu)       │
│binaries on this host.                                    │
│╭────────────────────────────────────────────────────────╮│
││✔ Running von dpkg … ━━━━━━━━━━━━ 100.0% • 0:00:00 • 5/5││
│╰────────────────────────────────────────────────────────╯│
╰──────────────────────────────────────────────────────────╯
Finished Successfully
~~~

In the first part of the output we get a list of the packages to be installed with the indication of their versions and size. After confirmation, the second part lists the actions performed.

### Commands that APT does not include

**"fetch" command**

The command **`nala fetch`**, run without any other options, automatically determines the distribution and release of our installation, searches for the fastest mirror servers, lists them for interactive selection and, after selecting one or more servers, creates the file `/etc/apt/sources.list.d/nala-sources.list`.

The `-c, --country` option limits the search using the ISO country code. Multiple specification of the option is allowed.  
The `--non-free` option adds contrib and non-free components to the file.

During a download, up to three packages are fetched from the server simultaneously.

**"history" command**

The **`nala history`** command, called without a subcommand, shows a summary of all actions performed with Nala. Each line corresponds to an action and contains the ID, the command, the timestamp, the number of packages changed and the user who requested the action. Actions that took place with other programs are not recorded.

~~~
user1@pc1:~$ nala history
 ID  Command                      Date and Time            Altered  Requested-By
  [...]
 66  upgrade libsmbclient samba…  2022-10-23 15:49:40 CET        5  root (0)
 67  upgrade apt apt-transport-…  2022-11-02 11:38:41 CET      308  root (0)
 68  install yapf3                2022-11-04 12:56:25 CET        2  user1 (1000)
~~~

Details about an action from the history are shown by the same command with the attached subcommand `info <ID>`.

~~~
user1@pc1:~$ nala history info 68
============================================================
 Installed
============================================================
  Package:            Version:                       Size:
  python3-yapf        0.32.0-1                      133 KB
  yapf3               0.32.0-1                       30 KB

============================================================
 Summary
============================================================
 Installed 2 Packages
~~~

If we now want to undo the installation of *"yapf3"* with the dependencies, in our case *"python3-yapf "*, we use the subcommand `undo <ID>` for this.  
(Again, **user1** gains root privileges by using *"doas "*).

~~~
user1@pc1:~$ doas nala history undo 68
============================================================
 Removing
============================================================
  Package:            Version:                       Size:
  python3-yapf        0.32.0-1                      849 KB
  yapf3               0.32.0-1                       43 KB

============================================================
 Summary
============================================================
 Remove 2 Packages

 Disk space to free  892 KB

Do you want to continue? [Y/n] y
╭─ History Undo 68 ────────────────────────────────────────╮
│Removing:   yapf3 (0.32.0-1)                              │
│Removing:   python3-yapf (0.32.0-1)                       │
│Processing: triggers for runit (2.1.2-50)                 │
│Processing: triggers for man-db (2.11.0-1+b1)             │
│╭────────────────────────────────────────────────────────╮│
││✔ Running dpkg … ━━━━━━━━━━━━━━━━ 100.0% • 0:00:00 • 5/5││
│╰────────────────────────────────────────────────────────╯│
╰──────────────────────────────────────────────────────────╯
Finished Successfully
~~~

In the first part of the output we see the packages to be removed with the indication of their versions and size. After confirmation, the second part lists the actions performed.  
If we change our mind and want to use the packages again, the `nala history redo <ID>` command will help us to perform the action again. The command `nala history clear <ID>` can be used to remove entries from the history, `nala history clear --all` removes all entries.

In the Nala version 0.11.1 described here, the subcommands `undo <ID>` and `redo <ID>` currently only support the actions Install or Remove. In a future version, which will then be based on the Rust programming language, it should be possible to roll back complete dist upgrades.

<div id="rev">Last edited: November 07, 2022</div>
