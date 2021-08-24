BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC1**

Necessary work:

+ check spelling  

Work done

+ check intern links (there was'nt any)  
+ check extern links  
+ check layout  

END   INFO AREA FOR THE AUTHORS  
% The siduction help

## siduction help

Quick help can save you a lot of tears and gives you the opportunity to continue doing what is really important in life. This topic is organized by areas where the distribution siduction offers help:

### The siduction forum

The siduction forum offers the possibility to ask questions and get answers to them. Before making a new post, use the forum search, as there is a good chance that this or a similar question has been asked before. [The forum](https://forum.siduction.org/index.php?name=PNphpBB2) is available in English and German.

### The siduction wiki

The siduction wiki is freely usable and modifiable by all siduction users. In this way, we hope that the siduction documentation will grow with the project over time.

We hope for contributions from Linux users of all experience levels, as this wiki intends to help users of all skill levels. The few minutes "sacrificed" to the wiki and project can save other users (and perhaps oneself) hours of searching for solutions to problems. [Link to siduction wiki](https://wiki.siduction.org) .

### IRC - interactive live support. 

**The IRC should never be entered as "root", but only as a normal user.  
If you are unclear, please announce this immediately in the IRC channel so that help can be given.

**Rules of conduct in IRC**

* A friendly tone is obligatory, because we all do the support on a voluntary basis.
* It is helpful to make a request that is accurate to the best of your knowledge, and to search for solutions in the siduction wiki beforehand if possible.
* Please never post a request in IRC and Forum at the same time. At best, we rub our eyes in wonder.

**reach siduction

+ Just click on the **"IRC Chat #siduction" icon** on the desktop or use the kmenu entry of koversation.  
If you prefer another chat client, you need to enter these server details:

  ~~~
  irc.oftc.net
  port 6667
  ~~~

+ [With this link you can start the IRC immediately in your browser](https://webchat.oftc.net/?nick=siducer007&channels=siduction-en) : enter a free nickname and enter the channel #siduction-en.

### siduction-paste

siduction-paste allows you to paste files from the terminal or TTY. This is ideal if you are in runlevel 3 (without a graphics server) with problems. siduction-paste uses `http://paste.siduction.org` as a link, and the output is available for 24 hours.

You can use siduction-paste both as user and as root. However, some commands or system queries require root access.

~~~
$ siduction-paste command|file
or
$ command | siduction-paste
~~~

**example for siduction-paste \<file\>;**

~~~
$ siduction-paste /etc/fstab
Your paste can be seen here: http://paste.siduction.org/xyz.html
~~~

The link `http://paste.siduction.org/xyz.html` must be entered in the IRC channel #siduction-en afterwards.

**Example for command | siduction-paste**

~~~
$ fdisk -l | siduction-paste
Your paste can be seen here:http://siduction.paste.org/yzx.html
~~~

You can also use siduction-paste to take screenshots and upload them at the same time

~~~
$ siduction-paste -s
~~~

Now you have a few seconds to navigate to the object you want to capture. Please remember that this function requires *scrot* to be installed.  
Again, the link `http://siduction.paste.org/yzx.html` must be entered in the IRC channel #siduction-en afterwards.

### Useful helpers in text mode

Normally one uses the text mode runlevel 3 (init 3 or journalctl isolate multi-user.target) if one wants to perform a dist-upgrade, or forced if the system has a serious error.

**gpm**

 is a useful program in text mode. It allows you to use the mouse to copy and paste in the terminal.

*gpm* is preconfigured in siduction. In case it is not:

~~~
$ gpm -t imps2 -m /dev/input/mice
~~~

After that you should check if the service is active:

~~~
$ systemctl status gpm.service
~~~

If successful, you will also find a line similar to the following in the output.

~~~
  Active: active (running) since Thu 2020-04-09 12:17:14 CEST; 5min ago
~~~

Now you should be able to use your mouse in text mode (tty).

**File manager and text editing**

Midnight Commander is an easy to use text mode (tty) file manager and text editor. It comes with siduction.  
Apart from normal keyboard input, the mouse can also be used due to gpm.  
**mc** shows the file system and with **mcedit** an existing file can be edited or a new file can be created.  
This is how to open an existing file (first a backup copy is created):

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

**Rule of conduct in IRC**

 **The IRC should never be entered as "root", but only as a normal user.**  
 If you are unclear, please announce this immediately in the IRC channel, so that help can be given.

**IRC in text mode**

The program *irssi* provides an IRC client in text mode or console and is activated in siduction.  
With the key combination `CTRL`+`ALT`+`F2` or `F3` etc. you can switch from one terminal/TTY to another and log in with your user account:

~~~
$ siductionbox login: <username> <password> (not as root)
~~~

after that you enter

~~~
$ siduction-irc
~~~

to start *irssi*.

Instructions if you want to use a different client (weechat in the example):  
First make sure that WeeChat is installed by looking for the entry of weechat in the menu. If this is not available:

~~~
# apt update
# apt install weechat-curses

  and then start the program

$ weechat-curses
~~~

Now you can connect to irc.oftc.net on port 6667. After successful connection the pseudonym (the "nickname") will be changed:

**/nick 'Your_new_nick'**.

You can enter the siduction channel with the following input:

**/join #siduction-en**

If you want to change the server, enter a command with the following syntax:

**/server server.name**

In the bottom menu you can see numbers if the channels are active, and to connect to a channel you can use ALT-1, ALT-2, ALT-3, ALT-4 and so on.

To exit a channel use

**/exit**

If a dist-upgrade is performed at the same time, you can switch to the terminal to monitor the progress of the upgrade as follows:

key combination `CTRL`+`ALT`+`F1`  
and to return to the IRC you can use the  
key combination `CTRL`+`ALT`+`F2`

The following links provide more information.  
[Documentation page of irssi](https://irssi.org/documentation)  
[Documentation page of WeeChat](https://www.weechat.org/) 

### Surfing the Internet in text mode

The command line browser w3m allows to surf the internet in a terminal or console or in text mode.  
If w3m or elinks are not installed, proceed as follows:

~~~
# apt update
# apt install w3m
# apt install elinks
~~~

Now you can use the command line browser w3m. For this it is useful to switch to another terminal and log in with your user account:

key combination `CTRL`+`ALT`+`F2`

~~~
$ siductionbox login: <username> <password> (not root!)
~~~

The program call is "w3m URL" or "w3m ?".  
Example: `https://siduction.org` is called like this (https:// is omitted):

~~~
$ w3m siduction.org
~~~

A new URL is called using the key combination Shift+U:

`SHIFT`+`U`

After that you will see a line like `Goto URL: https://siduction.org`. With the backspace key one deletes the last selected URL and enters the desired one.  
Exit w3m with:

`SHIFT`+`Q`

More information can be found on the [documentation page of w3m](http://w3m.sourceforge.net/). 

It is advisable to familiarize yourself with **elinks/w3m, irssi/weechat, midnight commander** before an emergency. Print this file to have the information handy in case of an emergency.

### inxi

Inxi is a system information script that works independently of individual IRC clients. This script outputs various information about the hardware and software being used, so that other users in #siduction can better help with troubleshooting. Or run in a console, you can get information about your own system yourself.

To use inxi in conversation, type this in the chat box:

**/cmd inxi -v2**

To use inxi in weechat, enter this in the chat box:

**/shell -o inxi -v2**

Assuming you have the shell extension installed.

See: [https://www.weechat.org/scripts/](https://www.weechat.org/scripts/) 

To use inxi in other clients, type this in the chat box:

**/exec -o inxi -v2**  
or  
**/inxi -v2**

In a console, type the following command:

~~~
$ inxi -v2
~~~

Help for inxi

~~~
$ inxi --help
~~~

### Useful links

[Debian reference card - to print on a single sheet](https://www.debian.org/doc/manuals/refcard/refcard.en.pdf)  
[HOWTOs from the Debian site](https://www.debian.org/doc/#howtos) (is automatically in your language if browser is localized)  
[Debian Reference: Basics and System Administration](http://qref.sourceforge.net/index.en.php) documents available as HTML, text, PDF and PS  
[Common Unix Printing System CUPS](https://www.cups.org/) . In KDE, the KDE Help Center provides information about CUPS.  
[LibreOffice](https://libreoffice.org/) There are many offerings in the "Help" menu.

<div id="rev">Last edited: 2021/24/08</div>
