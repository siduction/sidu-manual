% Use Live Medium

## How to use the live medium

### Users set up on the live medium

The users **siducer** and **root** (the system administrator) are set up on the live medium.

The password for the user **siducer** is **live**.  
No password is set for **root** (system administrator).

The live session will be locked after some time without any input. To unlock, please enter the username **siducer** and the password **live**.

### chroot helper

A very helpful tool on the live medium is the *chroot helper*. Who can execute the commands to start a chroot off the cuff, most of us cannot. So the next time we need to repair our system, we use the *chroot helper* icon. A terminal window opens and we are asked to select a partition. After a security warning, the *chroot helper* redirects us to the corresponding installation.

### root privileges on the live medium

Several ways of how to run a program with root priviliges are described below.

> **Caution**  
> Whenever you work with root privileges, you should know exactly what you are doing. For web browsing and similar actions, root privileges are not necessary.

1. The easiest way is to open a terminal and get root privileges by typing **`su`**.  
   To start a program that works with a graphical user interface, just enter the program name. 

   ~~~
   root@siduction:~# gparted &
   ~~~

   Now Gparted will be executed with root privileges. The *"&"* at the end of the command puts the process into the background so that the terminal remains usable.

2. Open a command prompt window:  
   Use the key combination **`Alt`**+**`F2`** to get a program launcher and enter the following command:

   ~~~
   sudo <application>  
   ~~~

   A terminal window will open, asking you for the root password. Now simply press the **`Enter`** key, unless a temporary root password has been set as described below. In the latter case, the corresponding password must be entered.

3. Enter the following command into a terminal without root privileges:

   ~~~
   sudo <application> &
   ~~~


   Please note:  
   `sudo` is not preconfigured on hard disk installations. We recommend to directly use the real **root** account.  
See [why sudo is not configured](0701-term-konsole_en.md#work-as-root).

### How to set a new password

Remember: The livesession's standard user is **siducer** with the password **live**. If you want to change the password, open a terminal and enter the following commands:

~~~
siducer@siduction:~$ passwd
Enter a new password:
Re-enter the new password:
passwd: Password successfully changed
siducer@siduction:~$
~~~

This new password for **siducer** can be used for the rest of the live session.  

The same procedure can be used to set a password for **root** in any terminal, but you have to become root via **`su`** first. 
Afterwards, a login on a virtual console as **root** is possible.

### Software installation during live session

The command sequence for installing software during a live session is similar to that on a hard disk installation.
The prerequisite is a root terminal:

~~~
apt update
apt install <the-package-you-want>
~~~

Otherwise, type `sudo` before the commands.

~~~
sudo apt update
sudo apt install <the-package-you-want>
~~~

However, if you shut down the live medium, no changes will be kept.

<div id="rev">Last edited: 2023/11/10</div>
