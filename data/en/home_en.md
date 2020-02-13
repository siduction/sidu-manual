<div id="main-page"></div>
<div class="divider" id="home-bu"></div>
## Backing up your /home partition

Before moving your `/home`  you should back up everything below /home (as root): 

~~~  
tar cvzpf somewhere/home.tar.gz /home  
~~~

To extract:

~~~  
tar xvpf somewhere/home.tar.gz  
~~~

 [Another alternative method to backing up is using rdiff.](sys-admin-rdiff-en.htm#rdiff) 

<div class="divider" id="home-move"></div>
## Moving /home

**`Do not use or share an existing $home from another distribution as the $home configuration files in a home directory will conflict if you share the same username between differing distributions.`** 

Moving or using an existing siduction /home can be done two ways, one with livecd, the other with command line, neither way is difficult.

Since the system needs the  [UUID information](part-uuid-en.htm#uuid) , you'll need to get the uuid of the new partition, unless you already have it noted. 

The easiest method is to add this new information, commented out before moving your home, to `/etc/fstab` .

Boot up the PC and in the grub box of the grub menu type 1 and hit the enter key. This will take you to init (runlevel) 1, which is single user and your current home is not used, so it is safe to work with it.

At the tty, login as root and mount your new /home partition, for example:

~~~  
mount /dev/sdxX /media/new-home  
(or whatever partition the new home is going to be)  
cp -pr /home /media/new-home  
~~~

Next edit `/etc/fstab`  to reflect the change of where the new /home is: 

~~~  
mcedit /etc/fstab  
~~~

Now `uncomment (delete the #)`  where the new /home is and `comment out (insert #)`  the old /home and save with F2 then quit with F10 then reboot.

<div id="rev">Content last revised 08/01/2012 1800 UTC</div>
