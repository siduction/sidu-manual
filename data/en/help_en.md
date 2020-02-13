<div id="main-page"></div>
<div class="divider" id="help-gen"></div>
## Where to Get Help

Getting timely help can mean the difference between ending in tears and getting on with whats important in your world. This topic is broken down to give you a means of where and how to get the help that siduction provides as a distribution.

+  [Forums and Wiki](help-en.htm#for-wiki)   
+  [IRC](help-en.htm#irc)    
+  [Tools to know in init 3 and text mode (tty)](help-en.htm#init3-tools)    
+  [Using IRC in text mode and/or init 3](help-en.htm#irc-init3)    
+  [Web browsing in text mode and/or init 3](help-en.htm#init3-web)    
+  [inxi](help-en.htm#inxi)   

<div class="divider" id="for-wiki"></div>
## The siduction forums

The siduction forums offer a place to post questions, and receive answers to those questions, please do search the forums before you post, as others may have already asked the very same question. [The forums](http://siduction.org)  are in German and English.

## The siduction Wiki

The siduction Wiki is free to use and edit by and for all siduction users.

We hope for contributions from Linux users of all knowledge levels, since this wiki is intended to help users of all levels. The few minutes you donate to our wiki can save other users (and maybe yourself) in need of solutions, hours of trouble and searching.  [The Wiki](http://wiki.siduction.de/index.php?title=Hauptseite) .

<div class="divider" id="irc"></div>
## IRC interactive live help 

### IRC Behaviour Protocols

**`Never IRC as 'root" .. you are welcome to IRC chat as user, never as root: if you are in trouble, say so immediately.`**

### Getting on to #siduction 

<!--There are 2 methods of getting live on line help -->  
Click the `siduction-irc icon`  on the desktop, or using another chat client  
<!-- 2) Clicking on `Meet the Team`  in the menu of  [siduction.org](http://siduction.org) 

 -->
#### Konversation

The easiest way is to click the `siduction-irc icon`  on the desktop or use the Kmenu as konverstion preconfigured.

Should you prefer another chat client, you need to set the server choice to:

~~~  
irc.oftc.net  
port 6667  
~~~

<!--#### siduction.org site activated irc

Go to  [siduction.org](http://siduction.org)  and click the`Meet the Team`  in the menu list. This will give you options to use a Chat (cgi) or Chat (java) web based irc chat client.

Enter your chosen nick into the nickname box and #siduction into the channel box and click 'login' and/or follow the prompts.

 -->
<div class="divider" id="paste"></div>
## !paste

### siduction-paste

siduction-paste will allow you to paste the output of files from the terminal and tty, therefore it is ideal if you are in trouble in init 3. siduction-paste uses http://paste.siduction.org as the link 

You can be either user or root to enable siduction paste, however note that some requests for output requires root access.

~~~  
siduction-paste FILE|COMMAND  
or  
COMMAND | siduction-paste  
~~~

###### Example of siduction-paste &lt;file&gt;

~~~  
siduction-paste /etc/fstab  
Your paste can be seen here: http://paste.siduction.org/xyz.html  
~~~

The link `http://paste.siduction.org/n8miQp85.html`  is what you need to provide to #siduction on IRC

###### Example of command | siduction-paste

~~~  
fdisk -l | siduction-paste  
Your paste can be seen here:http://paste.siduction.org/xyz.html  
~~~

The link `http://paste.siduction.org/xyz.html`  is what you need to provide to #siduction on IRC

You can also take screenshots and paste them in one run.

~~~  
siduction-paste -s  
~~~

You have a few seconds to move to the object to be screenshooted. Please mind that scrot has to be installed for this feature to work

<div class="divider" id="init3-tools"></div>
## Tools to know in text mode (tty) and init 3 

Usually you are in text mode/init 3 because you are going to do a dist-upgrade (or something terrible has gone wrong with your system) 

#### gpm

A good tool to have whilst in text mode is `gpm` . This will allow you to use your mouse to copy and paste between terminals/konsoles.

`gpm`  is preconfigured in siduction, otherwise do:

~~~  
gpm -t imps2 -m /dev/input/mice  
~~~

Ensure that /etc/gpm.conf is present

~~~  
/etc/init.d/gpm restart  
~~~

Now you are able to have a mouse in text mode (tty)

#### File browsing and text editing

Midnight Commander is a text-mode (tty) full-screen file manager and text editor installed by default and is not complex to use.

Apart from the normal keyboard commands it also responds to mouse clicks for navigation because of gpm.

`mc`  brings up the file system while `mcedit`  brings up a blank file or you can go directly to a file.

Example to go directly to a file:

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

You can now edit the file to change parameters and save the alteration to have immediate effect.

Read:

~~~  
man mc  
~~~

<div class="divider" id="irc-init3"></div>
### Accessing irc #siduction support while in text mode

#### IRC Behaviour Protocols

**`Never IRC as 'root" .. you are welcome to IRC chat as user, never as root: if you are in trouble, say so immediately.`**

#### IRC in text mode and/or init 3

The default in siduction is weechat.

When in init 3, you can switch to another terminal/konsole by:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <username> <password> (not as root user)    
then type    
$ siduction-irc (this brings up weechat)    
~~~
  
or if you have installed another client like weechat:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <username> <password> (not as root user)    
then type    
$ weechat-curses    
~~~
  
Now connect to irc.oftc.net on port 6667. Once connected, change your nickname:

~~~  
/nick username_of_choice  
~~~

To join the siduction channel:

~~~  
/join #siduction  
~~~

If you wish to connect to another server:

~~~  
/server server.name  
~~~

In the bottom bar, you will see numbers appear if there is activity in the channels, to switch to that channel, ALT-1 ALT-2 ALT-3 ALT-4 etc....

To leave,

~~~  
/exit  
~~~

If you are doing a dist-upgrade, for example, to check on the progress

~~~  
to return to the d-u for example  
$ CTRL-ALT-F1  
then to return back to irc  
# CTRL-ALT-F2  
~~~

 [WeeChat documentation](http://www.weechat.org/) 

<div class="divider" id="init3-web"></div>
#### Web browsing in text mode and/or init 3

wm3 and/or elinks will allow you to web browse in terminal/konsole or text mode and/or init 3

Check that w3m or elinks is installed, otherwise do:

~~~  
apt-get update  
apt-get install w3m elinks  
~~~

As an example, to access w3m open a terminal/konsole:

~~~  
$w3m URL  
or  
w3m ?  
or  
w3m siduction.org  
~~~

If you have a black looking screen with instructions at the bottom,, `do not panic,`  use this key combination

~~~  
SHIFT+U  
~~~

You will then see that it opens to your local disk something like Goto URL: file:///home/username/$ , just backspace till at GOTO URL and type in. for example:

~~~  
http://siduction.org  
~~~

You can now surf to  [siduction.org](http://siduction.org)  or any other site of your choosing

Or when in init 3:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <username> <password> (not as root user)    
then type    
$ w3m siduction.org    
To go back to the d-u for example    
$ CTRL-ALT-F1    
~~~
  
To go straight to the manual

~~~  
$w3m manual.siduction.org  
~~~

 [w3m home page](http://w3m.sourceforge.net/) 

###### `It is advisable to familiarise yourself with using elinks/w3m, weechat/weechat and midnight commander before an emergency happens, if one should occur. This would be a good page to print out as a reference on how to get online help in such emergencies.` 

<div class="divider" id="inxi"></div>
## inxi

inxi is a system information script, that is independent of a particular IRC (Internet Relay Chat) client. The system information script can display all kinds of things about your hardware and software to people in the channel, so they can help you diagnose problems, ... or just marvel at your system specs and kernel version, in your own time via the konsole. 

To use the inxi script in Konversation type into the chat box:

~~~  
/cmd inxi -v1  
~~~

To use the inxi script in other clients type into the chat box:

~~~  
/exec -o inxi -v1  
or  
/inxi -v1  
or  
/shell -o inxi -v1 (weechat)  
~~~

In a konsole type:

~~~  
inxi -v1  
~~~

inxi help:

~~~  
inxi --help  
~~~

<div class="divider" id="links"></div>
## Useful Links

###### General Linux Documentation

 [debian.org/doc/user-manuals](http://www.debian.org/doc/user-manuals#apt-howto) 

 [Debian Reference Card - to print on a single page](http://www.debian.org/doc/user-manuals#refcard) 

 [debian.org/doc/#howtos](http://www.debian.org/doc/#howtos) 

 [Debian basics, installation and system administration](http://qref.sourceforge.net/index.en.php)  document available in HTML, text, PDF or PS in many different languages

 [Linux Basics](http://linuxbasics.org/) 

The KDE Help Centre has an internal Help for Printing/CUPS , otherwise refer to  [Common Unix Printing System CUPS](http://www.cups.org/) 

 [LibreOffice](http://www.libreoffice.org/) 

<div id="rev">Content last revised 08/01/2012 1800 UTC</div>
