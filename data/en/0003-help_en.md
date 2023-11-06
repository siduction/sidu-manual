% The siduction help

## siduction help

Quick help can save you a lot of tears and gives you the opportunity to work on the important things in life. This section is organized by areas where the siduction distribution offers help.

### The siduction forum

The siduction forum offers the possibility to ask questions and get answers to them. Before creating a new post, use the forum search, as there is a good chance that this or a similar question
has been asked before. [The forum](https://forum.siduction.org/) is available in English and German.

### IRC - interactive live support. 

**The IRC should never be entered as "root" but only as a normal user.**  
If you are unsure, please announce this immediately in the IRC channel so that help can be given.

**Rules of conduct in IRC**

* A friendly tone is obligatory because we all do the support on a voluntary basis.
* It is helpful to make a request that is accurate to the best of your knowledge and to search for solutions in the siduction wiki beforehand if possible.
* Please never post a request in IRC and the forum at the same time. At best, we rub our eyes in amazement.

**Reach siduction**

+ Just click on the **"IRC Chat #siduction" icon** on the desktop or use the *kmenu* entry of `konversation`.  
If you prefer another chat client, you need to enter these server details:

  ~~~
  irc.oftc.net
  port 6667
  ~~~

+ [With this link you can start the IRC immediately in your browser](https://webchat.oftc.net/?nick=siducer007&channels=siduction-en): Enter a free nickname and join the channel #siduction-en.

### Useful helpers in text mode

Normally, you should use text mode runlevel 3 (**`init 3`** or **`journalctl isolate multi-user.target`**) if you want to perform a dist-upgrade or if you are forced to beceause of a serious system error.

**gpm**

 is a useful program in text mode. It allows you to use the mouse for copying and pasting in the terminal.

gpm is preconfigured in siduction. In case it is not:

~~~
$ gpm -t imps2 -m /dev/input/mice
~~~

After that, you should check if the service is active:

~~~
$ systemctl status gpm.service
~~~

If successful, you will also find a line similar to the following in the output:

~~~
  Active: active (running) since Thu 2020-04-09 12:17:14 CEST; 5min ago
~~~

Now you should be able to use your mouse in text mode (tty).

**File manager and text editing**

Midnight Commander is an easy to use text mode (tty) file manager and text editor preinstalled in siduction.  
Apart from normal keyboard input, the mouse can also be used due to gpm.  
`mc` shows the file system, and with `mcedit` you can edit an existing file or create a new one.  
This is how to open an existing file (a backup copy is created first):

~~~
$ cp /etc/apt/sources.list.d/debian.list /etc/apt/sources.list.d/debian.list_$(date +%F)

then

$ mcedit /etc/apt/sources.list.d/debian.list
~~~

Now the file can be edited and saved. The changes will take effect immediately.

See the man page for more information:

~~~
$ man mc
~~~

### siduction IRC support in text mode

**Rules of conduct in IRC**

 **The IRC should never be entered as "root" but only as a normal user.**  
 If you are unsure, please announce this immediately in the IRC channel so that help can be given.

**IRC in text mode**

The program **irssi** provides an IRC client in text mode or console and is activated in siduction.  
With the key combination **`ALT`**+**`F2`** or **`F3`** etc., you can switch from one terminal/TTY to another and log in with your user account:

~~~
$ siductionbox login: <username> <password> (not as root)
~~~

After that you enter

~~~
$ siduction-irc
~~~

to start irssi.

Instructions for using a different client (weechat in the example):  
First, make sure that weechat is installed by looking for the weechat entry in the menu. If this is not available:

~~~
# apt update
# apt install weechat-curses

  and then start the program

$ weechat-curses
~~~

Now you can connect to irc.oftc.net on port 6667. After successful connection, the pseudonym (the "nickname") will be changed:

**/nick 'Your_new_nick'**.

You can enter the siduction channel with the following input:

**/join #siduction-en**

If you want to change the server, enter a command with the following syntax:

**/server server.name**

In the bottom menu, you can see numbers if the channels are active. In order to connect to a channel, you can use **`ALT`**+**`1`**, **`ALT`**+**`2`**, **`ALT`**+**`3`**, **`ALT`**+**`4`**, and so on.

To exit a channel use

**/exit**

If a dist-upgrade is performed at the same time, you can switch to the terminal to monitor the upgrade progress as follows:

key combination **`ALT`**+**`F3`**  
To return to the IRC, you can use the  
key combination **`ALT`**+**`F2`**.

The following links provide more information:  
[Documentation page of irssi](https://irssi.org/documentation)  
[Documentation page of WeeChat](https://www.weechat.org/) 

### Surfing the Internet in text mode

The command line browser **w3m** allows you to surf the internet in a terminal, console, or in text mode.  
If neither w3m nor elinks are installed, proceed as follows:

~~~
# apt update
# apt install w3m
# apt install elinks
~~~

Now you can use the command line browser `w3m`. For this purpose, it is useful to switch to another terminal and log in with your user account:

key combination **`ALT`**+**`F2`**

~~~
$ siductionbox login: <username> <password> (not root!)
~~~

The program call is **`w3m URL`** or **`w3m ?`**.  
Example: https://siduction.org is called like this (https:// is omitted):

~~~
$ w3m siduction.org
~~~

A new URL is called using the key combination **`Shift`**+**`U`**.

After that, you will see a line like `Goto URL: https://siduction.org`. With the backspace key you delete the last selected URL and enter the desired one.  
Exit w3m with:

**`SHIFT`**+**`Q`**

More information can be found on the [documentation page of w3m](http://w3m.sourceforge.net/). 

It is advisable to familiarize yourself with **elinks/w3m, irssi/weechat, midnight commander**. Print this file to have the information handy in case of an emergency.

### inxi

**inxi** is a system information script that works independently of individual IRC clients. This script outputs various information about the hardware and software being used, so that other users in #siduction can better help with troubleshooting. Alternatively, run it in a console to get information about your own system yourself.

To use inxi in `konversation`, type this into the chat box:

**/cmd inxi -v2**

To use inxi in `weechat`, enter this into the chat box:

**/shell -o inxi -v2**

This requires the shell extension to be installed.

See: [https://www.weechat.org/scripts/](https://www.weechat.org/scripts/) 

To use inxi in other clients, type this into the chat box:

**/exec -o inxi -v2**  
or  
**/inxi -v2**

Type the following command into a console:

~~~
$ inxi -v2
~~~

Help for inxi:

~~~
$ inxi --help
~~~

### Useful links

[Debian reference card - to print on a single sheet](https://www.debian.org/doc/manuals/refcard/refcard.en.pdf)  
[HOWTOs from the Debian site](https://www.debian.org/doc/#howtos) (automatically in your language if browser is localized)  
[Debian Reference: Basics and System Administration](http://qref.sourceforge.net/index.en.php) (documents available as HTML, text, PDF, and PS)  
[Common Unix Printing System CUPS](https://www.cups.org/) (In KDE, the KDE Help Center provides information about CUPS.)  
[LibreOffice](https://libreoffice.org/) (There is a wide choice in the "Help" menu.)

<div id="rev">Last edited: 2022/03/29</div>
