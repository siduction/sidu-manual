<div id="main-page"></div>
<div class="divider" id="term-kon"></div>
## Definition of terminal/konsole

A terminal, also called bash, console and in KDE konsole, is a program that makes it possible to interact directly with the Linux operating system by issuing various commands which are then executed immediately. Also often referred to as a `'shell' or 'command line'` , the terminal is a very powerful tool and it's well worth the effort to gain some basic understanding of its use.

In siduction you can find the terminal/konsole close to the K-menu symbolised by a PC monitor. Depending on your theme it may or may not also contain the image of a shell. You will also find the same icon in the K-menu under "System".

When you open a terminal window you will be presented with the terminal prompt which will have the format of:

~~~  
username@hostname:~$  
~~~

You should recognise the username as your own login name. The `~ (tilde)`  indicates that you are in your home directory and `$`  indicates that you are logged in with user privilege. At the end you will have your cursor. This is your command line where you will enter the commands you want to execute.

A lot of commands need to be run with root privileges. To achieve this you type:`suxterm`  at the prompt and press enter. You will then be asked for your root password. Type your password and hit enter again (note that when you type your password, nothing will show on the screen).

If your password is correct the prompt will change to:

~~~  
root@hostname:/home/username#  
~~~

**`WARNING: While you are logged in as root, the system will not stop you from doing potentially dangerous things like deleting important files etc., you have to be absolutely sure about what you are doing, because it's very possible to seriously harm your system.`**

Note that the `$`  sign has changed into a `#`  (hash). In a terminal/konsole the `#`  always indicates that you are logged in with root privileges. `Throughout this manual we will omit everything in front of the $ or the #. So a command like:` 

~~~  
# apt-get install something  
~~~

Means: Open a terminal, become root (suxterm) and enter the command at the # prompt. `(Don't type the #)` 

Sometimes a konsole and/or terminal may become corrupted, type:

~~~  
reset  
~~~

and hit enter key.

If a konsole and/or terminal's output appears distorted. You can often cure this problem by pressing `ctrl+l,`  which redraws the terminal window. This distortion happens mostly when working with programs that use the ncurses interface, such as irssi.

A konsole and/or terminal on occasion may appear to be frozen, however, it is not, and anything you type will still be processed. This can be caused by pressing `ctrl+s`  accidentally. In this case, try `ctrl+q`  to unlock the terminal.

<div class="divider" id="colours"></div>
### `Coloured terminal`  `user:~` `$`  and **`root:`** `#`  `prompts:` 

Coloured terminal prompts could save you from making an embarrassing and a possibly catastrophic mistake while as **`root #`**  when you really wanted to be as `user~$` , or to use prompt colours as a marker to commands you executed a few 100 lines ago.

By default, both user~$ and root# prompts are the same colour and it is really easy to change the colours for both accounts.

The basic colours are:

~~~  
(the syntax is 00;XX)  
[00;30] Black  
[00;31] Red  
[00;32] Green  
[00;33] Yellow  
[00;34] Blue  
[00;35] Magenta  
[00;36] Cyan  
[00;37] White  
[Replace [00;XX] with [01;XX] to get a colour variation].  
~~~

###### To change your username ~$ prompt colour:

As $ user, with your favourite text editor:

~~~  
$ <editor> ~/.bashrc  
~~~

Go to line 39 and uncomment it, thus:

~~~  
force_color_prompt=yes  
~~~

Go to line 53 and where it has 01;32m, (for example), change it to a colour that suits you.

As an example, for a `cyan`  coloured user~:$ prompt, [01;36m\], you will need to change the code [01;XXm\] in 3 places within the syntax:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[01;36m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '  
~~~

The new look will only appear in new terminal sessions.

###### To change your root# prompt colour:

~~~  
suxterm  
<editor> /root/.bashrc  
~~~

Go to line 39 and uncomment it, thus:

~~~  
force_color_prompt=yes  
~~~

Go to line 53 and where it has 01;32m, (for example), change it to a colour that suits you.

As an example, for a **`red`**  coloured root:# prompt, [01;31m\], you will need to change the code [01;XXm\] in 3 places within the syntax:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[01;31m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '  
~~~

The new look will only appear in new terminal sessions.

###### Terminal background colours

To change the background colour and font options of the terminal, look at the menu options of the terminal. 

![Terminal colours](../images-common/images-terminal/terminal-colour-0.1.png "Terminal colours") 

There are a plethora of options available for changing colours, however the recommendation is to keep it simple.

<div class="divider" id="suxterm"></div>
## About suxterm

Numerous commands need to be run with root privileges. To achieve this you type in a terminal:

~~~  
sux  
~~~

While the common command for becoming root is 'su', using `suxterm`  instead will allow you run GUI / X11 applications from the command line and allow root to start graphical applications, as `suxterm`  is a wrapper around the standard su command which will transfer your X credentials to the target user. (See also  [sudo](#sudo) ).

An example of running an X11 app via suxterm is to use a text editor to edit a root file with kwrite or kate, or to do partitioning with gparted or use an Xapp file manager like dolphin or thunar. 

###### KDE keyboard options

To start krunner in KDE:

~~~  
Alt+F2  
~~~

or right-click on the desktop and choose:

~~~  
Run Command  
~~~

then:

~~~  
kdesu <Application>  
~~~

###### Xfce keyboard options

To start Run Command in Xfce:

~~~  
Alt+F2  
~~~

or right-click on the desktop and choose:

~~~  
Run Command  
~~~

then:

~~~  
gksu <Application>  
~~~

###### Other Desktop WIndow Manager options

Another keyboard option also generic to all major Desktop Managers is:

~~~  
Alt+F2  
~~~

then:

~~~  
su-to-root -X -c <Application>  
~~~

`All of the above keyboard options can be run in a terminal.` 

<div class="divider" id="sudo"></div>
## sudo is not supported

sudo is not enabled by default on installation to hard disk. It is available for use on a live-ISO since no root password is preset. The reasoning behind this is so that if an attacker gets hold of the users password, they do not immediately get full super-user priviledges and make potentially damaging changes to your system.

Another issue with sudo is that it leads to running a root application with a users configuration, which may override or change permissions. In some cases, this can subsequently make an application unusable for the user. Use `[suxterm](#suxterm) , kdesu, gksu or su-to-root -X -c`  as recommended!

## Being in root

**`WARNING: While you are logged in as root, the system will not stop you from doing potentially dangerous things like deleting important files etc., you have to be absolutely sure about what you are doing, because it's very possible to seriously harm your system. `**

**`Under no circumstances should you be as root in the console/terminal to run applications that a standard user uses to go about being productive on a day to day basis, like sending emails, creating spreadsheets or surfing the internet and so forth. `**

<div class="divider" id="cli-help"></div>
## Command Line Help

Yes there is. Most Linux commands/programs comes with its own manual called a "man page" or "manual page" accessible from the command line. The syntax is:

~~~  
$ man command-name  
~~~

or

~~~  
$ man -k <keyword>  
~~~

This will bring up the manual page for that command. Navigate up and down with the cursor keys. As an example try:

~~~  
$ man apt-get  
~~~

To escape from the man pages type `q`  to quit

Another useful utility is the "apropos" command. Apropos basically enables you to search the man pages for a command if you e.g. don't remember the complete syntax. As an example you can try:

~~~  
$ apropos apt-  
~~~

This will list all commands for the package manager 'apt'. The 'apropos' utility is a quite powerful tool, but describing it in detail is way beyond the scope of this manual. For details of its use, see it's man page.

<div class="divider" id="term-cmds"></div>
## Linux Terminal Commands List (excerpt)

This is an excellent primer on using BASH  [from linuxcommand.org](http://linuxcommand.org/) 

`A very comprehensive list of 687 commands in alphabetical order from Linux in a Nutshell, 5th Edition: O'Reilly Publications can be found  [here](http://www.linuxdevcenter.com/linux/cmd/#a)  and is a 'must bookmark'`

There are numerous tutorials on the Internet. A very good one aimed at the beginner is:  [A Beginner's Bash](http://linux.org.mt/article/terminal) 

Or use your favourite search engine to find more.

<div class="divider" id="shell-scripts"></div>
## A script and how to use them

A shell script is a convenient way to group multiple commands together in a file, By entering the filename of the script every command will be executed in turn. siduction.orges with several useful scripts in order to make life easier for the users. 

If the shell-script is in your current working directory

~~~  
./name_of_shell-script  
~~~

`Some scripts require root access (suxterm) in a terminal and others do not, it depends entirely on the purpose of the script.`

##### Script Installation and execution procedure

Use wget to download the script file, placing it wherever it has been recommended to place it `(for example it may ask you to place it in /usr/local/bin)` , you can use your mouse copy and paste file name directly into your konsole window, after logging in as `suxterm` 

###### Example of using wget that requires `root access (suxterm)` 

~~~  
suxterm  
cd /usr/local/bin  
wget script-name  
~~~

You then need to make the file executable

~~~  
chmod +x script-name  
~~~

You can also use a browser to download a script file then place it where it has been recommended to place it, however you will still need to make it executable.

<!--###### Example of using wget as a user

To place a file in your `$HOME as a user '$'` :

~~~  
$ wget http://manual.siduction.org/shell-script-test/test-script.sh  
~~~

~~~  
$ chmod +x test-script.sh  
~~~

To run a script, open a terminal/konsole, and run the script name:

~~~  
$ ./test-script.sh  
~~~

You should then see this:

~~~  
Congratulations user  
You successfully downloaded and executed a bash script!  
Welcome to siduction-manuals http://manual.siduction.org  
 -->  
~~~

<div id="rev">Page last revised 26/11/2014 2000 UTC</div>
