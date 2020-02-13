<div id="main-page"></div>
<div class="divider" id="rsync"></div>
## Backing up with rsync

rsync is a tool used to backup and synchronise your files. (It can be run on a variety of *nix ports).

**`One limitation of rsync is that it can NOT copy from a remote system to a remote system. If you want to do that, then you will need to copy one of the remote systems to a local system and then copy it from the local system to the other remote system. This is a limitation of rsync.`**

With siduction you have choices how to initiate the proccess, DIY or via a deb package in Debian sid:

##### For the deb package:

~~~  
apt-get install luckybackup  
~~~

 [Homepage of luckybackup.](http://luckybackup.sourceforge.net/) 

###### What follows from here is the DIY version

The following gives you a working knowledge of what rsync can do and some sample code to use for your own backup script.

rsync is a very easy to use file backup program, it can also back up files and directories quickly. This is accomplished by using a very smart routine in checking when files have changed, so that only those files are selected for copying. rsync also uses a compression utility to speed up the copy process <span class=" highlight-3">(when explicitly set with-z option)</span>. This can be explained very simply:

The rsync program detects files and folders that need to be copied because one or more of their attributes have changed (for example date/time of last modification, or the size of the file), in either case, something is not the same as what was backed up previously. This selection process is very quick.

When rsync has finished building the list it will use, the copy of these changed files is done a lot faster because of a compression routine performed during the copy process. rsync does the compression before sending, and uncompresses at the other end, “on the fly”.

rsync can copy files from:  
* local system to local system,  
* local system to remote system,  
* remote system to local system.

It uses either the default  [ssh](ssh-en.htm#ssh)  client, or running a rsync daemon on both the source and target systems. The man pages for rsync states that, if you can ssh to the system, then rsync will be able to ssh to it as well.

`One limitation of rsync is that it can NOT copy from a remote system to a remote system. If you want to do that, then you will need to copy one of the remote systems to a local system and then copy it from the local system to the other remote system. This is a limitation of rsync.`

To give an example of this logic, lets say we have three systems;

~~~  
neo – the local system  
morpheus – a remote system  
trinity – a remote system  
~~~

You want to use rsync to copy, or sync, the /home/[user]/Data folders from all the systems with each other. Each system is “owned” by a specific user, in other words, a specific user uses that system specifically, and thus, that system should be used as the “source” for the other two systems. You are also going to be running the rsync command on the “local” system only, which is neo:

~~~  
the main user of neo is cuddles,  
the main user of morpheus is tartie, and  
the main user of trinity is taylar.  
~~~

So, what you would want is, backing up, or syncing, of the following:

~~~  
neo's /home/cuddles/Data area to morpheus and trinity,  
morpheus's /home/tartie/Data area to neo and trinity,  
trinity's /home/taylar/Data area to neo and morpheus.  
~~~

The problem of rsync and it not being able to copy from a remote system to a remote system, in the above example, will result when we come to backing up trinity to morpheus, or morpheus to trinity (both the source and target systems are remote) i.e.

~~~  
neo --> morpheus – fine, thats local to remote  
neo --> trinity – fine, thats local to remote  
morpheus --> neo – fine, thats remote to local  
trinity --> neo – fine, thats remote to local  
morpheus --> trinity – remote to remote – won't work  
trinity --> morpheus – remote to remote – won't work  
~~~

To resolve this limitation, you need to change your rsync scheme a little. The following would do this;

~~~  
morpheus --> trinity – becomes: morpheus --> neo & neo --> trinity  
trinity --> morpheus – becomes: trinity --> neo & neo --> morpheus  
~~~

This is an extra step, versus the single step, but, considering that you want to get the files over to neo as well, it's just changing where the source comes from, not the final outcome. This assumes that our backups are good and nothing is missing.

`This limitation of rsync needs to be considered when designing your backup process.`

##### Using hostnames with hostnames with rsync.

As described above, using neo, morpheus, or trinity in a translation of a physical IP Address, it is a clean, and easy way of making things a lot more readable. To accomplish being able to use those hostnames, is really simple.

You will want to edit your /etc/hosts file, and add the hostnames and what IP Addresses they relate, or translate to. Here is a small portion of the top lines of a /etc/hosts file, showing the translations:

~~~  
192.168.1.15 neo  
192.168.1.16 morpheus  
192.168.1.17 trinity  
~~~

The first line above translates IP Address 192.168.1.15 to the name “neo”, the second 192.168.1.16 to the name “morpheus”, and the last line, IP Address 192.168.1.17 to the name “trinity”. After adding the above and saving the /etc/hosts file, you can then use the “name” instead of the IP Address, or you can continue to use the IP Address. What makes this really shine, is when you change a systems IP Address. To give an example of this change, lets say neo changes its IP Address from 192.168.1.15 to 192.168.1.25

If you have all of your scripts using the IP Address, you will need to locate them all, and change them to the new address. If, on the other hand, your scripts are using the “name”, all you need to do is change the /etc/hosts file to reflect the change, and all your scripts will work. This can be very handy when you have a lot of scripts that remote connect to other systems, or vice-versa. The “name” method also makes your scripts more easy to read, and follow, because you aren't using the IP Address, but rather, a recognizable name to associate with the IP.

#### rsync, and the two ways you can use it.

One way is to  **“push”**  files to a target, and the other way, is to  **“pull”**  them from the source. Each has its advantages, and some disadvantages. Let's look at each one (for this explanation, let's assume one of the systems is local, and the other is a remote system. That way, you should be able to see the terminology a lot better)

 **“push”**  - the local system has the source files and folders on it, and the target location is a remote system. The rsync command is run on the local system, and “pushes” its files to the target system.

Advantages:  
* You can have more than one system backing itself up to one target system.  
* The backup process is distributed over your complete computer systems and not just one system is being taxed.  
* If one system is faster than another, it can finish before the others do, and do other things.

Disadvantages:  
* If you are using a script, and scheduling them with cron, this will require updating and changing multiple crontabs on every system, as well as updating multiple versions of your script.  
* Your backup can not check if the target system has its target partition mounted, and may be backing up to nothing on the target.

 **“pull”**  - the remote system has the source files and folders on it, and the target location is on the local system. The rsync command is run on the local system, and “pulls” the files from the source system.

Advantages:  
* One system is made to be the server, controlling all the backups for all the other systems. Centralized backups.  
* if you are using a script, it is contained only on one system, and only one script, making updating and modifications easy. It also allows you to control only one crontab file for scheduling the script.  
* Your script can check, and mount, if necessary, the target partition.

###### Syntax of rsync, as found from the man pages:

~~~  
rsync [OPTION]... SRC [SRC]... DEST  
rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST  
rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST  
rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST  
rsync [OPTION]... SRC  
rsync [OPTION]... [USER@]HOST:SRC [DEST]  
rsync [OPTION]... [USER@]HOST::SRC [DEST]  
rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]  
~~~

##### Working Example of rsync commands:

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

Let's take a look at some of the parts of that command:

~~~  
the source path/file is: morpheus:/home/tartie  
and the target is: /media/sda7/SysBackups/morpheus/home  
~~~

everything from /home/tartie... will be backed up under the /media/sda7/SysBackups/morpheus/home which will look like this:

~~~  
/media/sda7/SysBackups/morpheus/home/tartie...  
~~~

It should be noted, that the only reason /tartie is under /home is because of the TARGET designation, and NOT from the SOURCE. The “source” only selects where the files are coming from, not where they are going. The “target” is what is telling rsync where to put the files it gets from the “source”. Take the following example:

~~~  
rsync [...] /home/user/data/files /media/sda7/SysBackups/neo  
~~~

In the above command, only the source folder /files, and whats below it, will be under the target folder /neo – and not this /media/sda7/SysBackups/neo/home/user/data/files

Be sure to take this into consideration when you are creating your rsync backup commands.

##### Explanation of the options:

~~~  
-a is used for archive mode. From the man page, it explains this option as “in simple terms,  
a way to backup recursively, and to preserve 'almost' everything”. It does mention that t  
his format does not preserve hardlinks due to the complexity of processing.  
The -a option is stated as being equivalent to the following: -rlptgoD which means this:  
-r = recursive – process sub-folders and files found in our “source” location.  
-l = links – when symlinks are encountered, recreate them on the target location.  
-p = permissions – tells rsync to set target permissions the same as source.  
-t = times – tells rsync to set target times the same as source.  
-q = quiet – tells rsync to keep its output minimal, though we add a level of  
verbose with the command -v right after this. To make the process complete “quiet”,  
remove the “v” in the above command.  
-o = owner – tells rsync that if it's run as root, set the target files owner the same as source.  
-D = this is equivalent to using these two commands: --devices --specials  
--devices = causes rsync to transfer character and block device files to  
the remote system to recreate these devices. Unfortunately, if you do not  
also include --super in the same command, this has no effect.  
--specials = causes rsync to transfer special files such as named sockets  
and fifos.  
-g is used to preserve “group” of the source file to the target.  
-E is used to preserve “executable” of the source file to the target.  
-v is used to increase the verbosity that is displayed. After we are sure we are  
backing up what we want, the “v” can be removed. I have left it in, because I  
run this process from a cron job, and prefer to “see” what it did.  
I leave it up to the individual to decide.  
-z is used to compress the data it needs to “transfer” or copy, this makes the copy  
process take less time, because the data being transferred is smaller in size than its real size.  
--delete-after = target files/folders that are no longer on the source are  
deleted after transfer, not before. This “after” is used in case of problems  
or a crash, and the “delete” is used to keep target files that no longer  
exist on source system from hanging around and not cleaned up on our target  
location.  
--exclude = a pattern used to exclude files or folders with. In the  
example, --exclude=“*~” would exclude ANY and ALL files or folders ending  
with the “~” character from being backed up. Only one pattern can be supplied  
with the --exclude option, so if more than one is needed, you need to supply  
additional exclude lines on the command line.  
~~~

Additionally, these are some other, useful command options:

~~~  
-c – which will add another level of checks into the source being compared to the target after the copy process,  
but it adds more time to the copy process, and rsync already does comparisons of the source and target files  
during its processing, so this option was not included for the simple fact it slows the complete process down,  
and is only a form of redundancy, which is not needed.  
--super – which, as the man page describes it, the receiver, or target system,  
will attempt super-user activities  
--dry-run – which will show what would have been transferred. This is kind of  
like using the -s option with apt-get install, or apt-get dist-upgrade.  
~~~

The remainder of our command is the source file/folder, and then our target folder location.

##### Example commands:

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

This command will back up all the files and any folders below /home/tartie on the system translated with a name “morpheus”, and place them into the /media/sda7/SysBackups/morpheus/home folder – keeping the tree structure from tartie folder, out.

~~~  
rsync -agEvz --delete-after --exclude=”*~” /home/tartie neo:/media/sda7/SysBackups/morpheus/home  
~~~

This command is the reverse of the command above, it will “push” the /home/tartie folder, its contents, and sub-folders over to the system named neo into the same folder – take note that a system is considered remote when it has the “:” (colon) in front of the path.

~~~  
rsync -agEvz --delete-after --exclude=”*~” /home/cuddles /media/sda7/SysBackups/neo/home  
~~~

This command is performing a local to local backup, note that no colon exists in either the source or the target locations. This command will backup locally the /home/cuddles area to the same systems /media/sda7/SysBackups/neo/home location.

Lets see what a multiple exclude rsync command will look like:

~~~  
rsync -agEvz --delete-after --exclude=”*~” --exclude=”*.c” --exclude=”*.o” "/*" /media/sda7/SysBackups/neo  
~~~

The above command will back up EVERYTHING from the root of the local system, and all its files/folders, placing in the target location /media/sda7/SysBackups/neo – only now, it will exclude all files, or folders, that end with a “~”, or a “.c”, or a “.o”

**`Below is a sample rsync command that either one, should error, or, should be avoided whenever possible. It is an example of a remote system to a remote system rsync command:`**

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie trinity:/home  
~~~

**`As mentioned earlier in this document, this is a limitation of rsync.`**

One last sample command, let's see what a remote to local rsync would look like if we replace our “system names” with the IP Address, instead.

This first command is the “name” method, and the second one, is the exact same command, using the IP Address

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

~~~  
rsync -agEvz --delete-after --exclude=”*~” 192.168.1.16:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

As said earlier, you don't have to use the translated “names”, but, in the first example, you can read what it is doing a lot easier than in the second.

You should now be able to design a simple command, either from the examples given, or by missing and matching the commands shown to get what you are looking for.

<div id="rev">Page last revised 08/01/2012 1800 UTC</div>
