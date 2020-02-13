<div id="main-page"></div>
<div class="divider" id="rootpw"></div>
## siduction-*.iso - Live Mode root password

<p class='highlight-2'>Please note: Whenever you execute something with root permissions, you should know what you are doing! For web surfing over the internet no root access is required. Should your live-session time out, user and password on live-sessions are  **user:siducer**  and <b>password:live</p>
### siduction-*.iso default password

On the siduction-*.iso no root password is set. If you want to run a program that requires root-privileges you have several choices:

Simple method, just type:

~~~  
su  
~~~

###### To set a (temporary) root-password

Open a console/ shell:

~~~  
siduction@0[siduction]$ sudo passwd  
Enter new UNIX password:  
Retype new UNIX password:  
passwd: password updated successfully  
siduction@0[siduction]$  
~~~

Now you can use this password for the rest of your siduction-Live-session.

`sudo is not preconfigured on hard disk installations. We recommend to use the real root account, see`  [sudo](term-konsole-en.htm#sudo)  and  [suxtermterm](term-konsole-en.htm#suxtermterm) .

###### Running a program from a root-shell

Typing `suxterm`  in a terminal will take you to root with Xapp privileges.

Open a console/ shell:

~~~  
siduction@0[siduction]$ su  
root@0[siduction]# gparted  *(or whatever you want...)*   
~~~

Another option generic to all major Desktop Managers is:

~~~  
Alt+F2 su-to-root -X -c <Application>  
~~~

For example:

~~~  
Alt+F2 su-to-root -X -c gparted  
~~~

`To get out of being root in the konsole type:`

~~~  
exit  
~~~

or just click the top right hand corner to close the konsole.

**`In case of a lockout on an siduction-*.iso you need to do the following and follow the prompts to set a password:`** 

~~~  
alt+ctrl+F1  
sudo passwd  
~~~

Once the password is active, action the following:

~~~  
alt+ctrl+F7  
~~~

<div class="divider" id="live-cd-installsoft"></div>
## Installing software whilst on a Live-CD

~~~  
apt-get update  
apt-get install your-preferred-package  
~~~

Note: when you power off the Live-CD, no changes will be kept, except if you enable  [fromiso and persist](hd-install-opts-en.htm#fromiso-persist) .

<div id="rev">Content last revised 26/11/20124 2000 UTC</div>
