BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC2**

Necessary work:

+ check spelling  

Work done

+ check intern links  
+ check extern links (there was'nt any)  
+ check layout  

END   INFO AREA FOR THE AUTHORS  
% Use Live DVD

## Use Live DVD

### Users set up on the live medium

The users '**siducer**' and '**root**' (the system administrator) are set up on the live medium.

For the user '**siducer**', the password '**live**' is set.  
No password is set for the user '**root**' (system administrator).

The live session will be locked after some time without any input. To unlock, please enter the user '**siducer**' with the password '**live**'.

### With root privileges on the live DVD

We describe below several ways to run a program with root privileges.

> **Caution**  
> Whenever you work with root privileges, you should know exactly what you are doing. For web browsing and similar actions, root privileges are not necessary.

1. The easiest way is to open a terminal and get root rights by typing "**su**".  
   To start a program that works with a graphical user interface, just enter the program name. 

   ~~~
   root@siduction:~# parsed &
   ~~~

   Now Gparted is executed with root privileges. The "&" at the end of the command puts the process into the background and the terminal remains usable.

2. Open a command prompt window:  
   Use the key combination `Alt` + `F2` to get a program startup line and enter in it the command

   ~~~
   sudo <application>  
   ~~~

   in it.  
   A terminal window will open asking for the root password. Now simply press the `Enter` key, unless a temporary root password has been set as described below, which must be entered.

3. In a terminal without root privileges enter the command

   ~~~
   sudo <application> &
   ~~~

   enter.  

   Please note:  
   *sudo* is not preconfigured on hard disk installations. We recommend using the real root account directly.  
See [why sudo is not configured](0701-term-konsole_en.md#work-as-root)

### Set a new password

In case you are locked out on a siduction-*.iso, switch to the first virtual console by pressing `Alt` + `Ctrl` + `F1` and enter the command **su** followed by **passwd siducer**.

~~~
siducer@siduction:~$ passwd
Enter a new password:
Re-enter the new password:
passwd: Password successfully changed
siducer@siduction:~$
~~~

This new password for **siducer** can be used for the rest of the live session.  
With the key combination `Alt` + `F7` you get back to the graphical user interface and log in with the new password.

The same procedure can be used to set a password for root in any terminal, but you have to become root via su first. 
Afterwards a login on a virtual console as 'root' is possible.

### Software installation during live session

The command sequence for installing software during a live session is similar to that for a hard disk installation.
The prerequisite is a root terminal, 

~~~
apt update
apt install <the-package-you-want>
~~~

or a preceding sudo before the commands.

~~~
sudo apt update
sudo apt install <the-package-you-want>
~~~

However, if you shut down the live DVD, no changes will be kept.

<div id="rev">Last edited: 2021/26/08</div>
