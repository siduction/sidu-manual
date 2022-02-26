BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC2**

Necessary work:

+ check spelling  

Work done

+ check extern links  
+ check layout  

END   INFO AREA FOR THE AUTHORS  
% Doas

## Doas - Alternative to Sudo

We, the siduction team, have decided to use a real root account and not configure Sudo. For users who are used to Sudo and don't want to do without its functionality, the slim alternative Doas is a good choice. Doas is, in comparison to Sudo with only about 1/100 of code lines, tailored to desktop systems. With *siduction 2021.3 wintersky*, Doas is automatically installed in version 6.8.1-3, but is not yet fully configured.

### Configure Doas

The only thing missing to be able to use Doas is the configuration file `/etc/doas.conf`. It contains line-by-line rules that assign actions to a user. A `#` introduces comments. Doas reads the lines one after the other, executing the action of the last applicable rule. To understand the rules in the configuration file, there are a few things to keep in mind.  
- Only actions for which at least one rule applies are executed.
- By the fact that Doas evaluates the rules line by line one after the other, hierarchies can be built up.
- For rules that contain commands with arguments, the arguments must be specified exactly and completely.
- Rules with commands that require variable arguments are not possible.
- Doas checks the syntax of the configuration file before executing the requested action. In case of incorrect rules the output `doas: syntax error at line 4` and Doas exits. The write access to the configuration file is then only possible with the root account.

The configuration is particularly simple if only one user account exists on the siduction system. A single line is sufficient to execute commands with root privileges using the prefix "doas ".  
Log in to a terminal as root and execute the following command, replacing "tux" with the name of your user account. 

~~~txt
tux@sidu:~$ su
Password:
root@sidu:/home/tux# echo "permit keepenv nopass tux" > /etc/doas.conf
root@sidu:/home/tux# exit
tux@sidu:~$
~~~

The configuration line is composed of:  
The action *permit|deny* with  
the option *keepenv* (this allows to start graphical programs like gparted),  
the option *nopass|persist* (no password request|the one-time password entry remains valid for a limited time) and  
the user *tux* to which the action is to be applied.

If the username stands alone, *tux* may execute commands as any user present on the system. The default is *root*. If the execution of the action is to be allowed only with the rights of a user other than *root*, the name must be specified within the rule (e.g. *tux as anne*). Instead of the user, a group (e.g. *:vboxusers*) can gain permissions by prepending a **`:`**.

### Doas and multiple users

**Example**  
On the workstation PC, in addition to *tux*, three other users named *anne*, *bob*, and *lisa* are allowed to log in.  
Anne only wants to allow Bob to run two of her scripts from her /home directory. Anne has restrictively set the permissions on her scripts to 700.  
Lisa is especially trusted, so she should be in charge of system upgrades.

We use as *tux* immediately Doas in a terminal to edit the configuration file.

~~~txt
tux@sidu:~$ doas mcedit /etc/doas.conf
~~~

We convert the previously mentioned permissions into rules and add some comments to the file.

~~~txt
# doas config file /etc/doas.conf

# tux gets root privileges
permit keepenv nopass tux

# bob may execute script from anne
permit bob as anne cmd /home/anne/bin/script1 args -n
permit bob as anne cmd /home/anne/bin/script2 args

# lisa may execute system upgrade
deny lisa cmd init
permit persist lisa as root cmd init args 3
permit persist lisa as root cmd init args 6
permit persist lisa as root cmd apt args update
permit persist lisa as root cmd apt args full-upgrade
~~~

**Explanations**  
**Bob** may execute the scripts *script1* and *script2* inside Anne's /home directory. The former exclusively with the argument *-n*, the latter must not be given any argument. Specifying *args* in the rule line for the *script2* without a following argument, forces the file to be called without an argument and thus without potentially malicious code. Bob must supply the username to the call to the scripts with the *-u* option.

~~~txt
bob@sidu:~$ doas -u anne /home/anne/bin/script1 -n
doas (bob@sidu) password:

bob@sidu:~$
~~~

The script was executed without comment after Bob entered his user password.

To allow **Lisa** to perform the system upgrade, she should switch to *multi-user.target* (init 3) and perform a *systemctl reboot* (init 6) after completion. The rule line `deny lisa cmd init` without specifying *args* causes all other calls to init except those in the two rules below, to be disallowed. Therefore, she cannot go directly from the *multi-user.target* to the *graphical.target* (init 5). Here we see the structure of a hierarchy.

**Notes**  
If you keep typing *sudo*, the line `alias sudo="doas"` in your .bashrc will help.  
Doas plays its decisive advantage where only one user is granted root rights by *doas*. The above example with Lisa shows how extensive the configuration for a restricted rights assignment can become. Furthermore, a rule for a program call with variable arguments (e.g. *apt install \<package name\>*) is not possible.

**Sources**  
man doas  
man doas.conf  
[github, doas](https://github.com/slicer69/doas)  
[DE: LinuxNews, Linux Rechtemanagement, sudo durch doas ersetzen](https://linuxnews.de/2020/10/linux-rechtemanagement-sudo-durch-doas-ersetzen/)  
[DE: LinuxUser 08.2021, Kleiner Bruder](https://www.linux-community.de/ausgaben/linuxuser/2021/08/mit-doas-statt-sudo-administrative-aufgaben-erledigen/)

<div id="rev">Page last updated 2021/26/02</div>
