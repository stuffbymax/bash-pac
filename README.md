if the program tells you that scores.txt doesnt exist after you save a score the program will create scores.txt for see your score
------------------------------------------------------------------------------------------------------------------------------------
known bugs
------------------------------
.collision

if you do not want to install the bash script click here [https://www.onlinegdb.com/lF2xPYk-W](https://onlinegdb.com/rhTNWw26ee)

old version [https://www.onlinegdb.com/lF2xPYk-W]
---------------------------------------------------------------------------------------------
about the project
------------------
waring this project is not finished
-----------------------------------------
the bash-pac is clone of pacman
that is writen in bash script.

if you want play better copy of pacman Install
----------------------------------------

``pacman4console``

Game Instructions
-------------------
 Player character: (C)

  Avoid the ghost (G) while collecting food (.) to increase your score.
 
  Controls:
  ------------------
A: Move Left
S: Move Down
D: Move Right

In-game shortcuts:
-------------------------
Q: Exit full terminal
Ctrl: Exit only the program
Tap: Return to the main menu
Linux
-------
                   
Set execute permission on your script using the following command:
``chmod +x script-name-here.sh``

To run your script, execute it directly:
``./script-name-here.sh``

Alternatively, you can use either of the following commands:
``sh script-name-here.sh``
or
``bash script-name-here.sh``

for example

``chmod +x script /home/zdislav/Desktop/bash-pac.sh``

``./home/zdislav/Desktop/bash-pac.sh``




Windows 
--------

(using Windows Subsystem for Linux - WSL):
Open Command Prompt and navigate to the folder where the script file is located.
Type the following command and hit Enter:

``bash script-filename.sh``
 
``bash script-bash-pac.sh``




BSD
----
Install Bash:

By default, FreeBSD uses the tcsh shell and a POSIX-compatible sh shell.
If you want to run Bash scripts, you can install Bash using the following commands:
pkg add bash

or
``make -C /usr/ports/shells/bash install clean``

After installation, you can execute your Bash script by invoking bash
``./home/zdislav/Desktop/bash-pac.sh``

Use a Universal Shebang:

Modify the shebang (the first line of your script) to use a more universally compatible shell location.
Instead of ``#!/bin/bash, use #!/bin/sh.``
Then, within your script, you can check where Bash is installed (if it’s even installed) and adjust accordingly.




Andoid
-------
Termux:

Termux is a popular terminal emulator available for Android.
It provides a comprehensive collection of packages, including BASH and ZSH shells.
If you have root access, you can manage files with tools like nnn and edit them using nano, vim, or emacs2.

Running Scripts:

You can run shell commands in Android using Termux.
Create/download a BASH script (or any script) with a .sh extension.
Use ``./myscript.sh`` to execute the script directly.
Alternatively, call BASH in a new shell and feed its commands from a text file using bash myscript.sh

for example ``./home/zdislav/Desktop/bash-pac.sh``

not recomended by me (i thing is harder)

Android’s Native Shell:

Android uses a shell located at /system/bin/sh, which is different from the typical /bin/sh found in most Unix-like systems.
If you create a BASH script (with a .sh extension) and try to run it directly using #!/bin/bash, it won’t work because Android doesn’t have a full-fledged BASH interpreter.
Instead, use ``#!/system/bin/sh`` in your script to make it compatible with Android’s shell.
Keep in mind that Android is not a GNU/Linux distribution, so not all scripts that work on GNU/Linux will necessarily work on Android1.




mac os
------
Run the Script: 

you can run your script by typing:
``./myscript.sh``

for example 

``./home/zdislav/Desktop/bash-pac.sh``

The ./ prefix specifies that you want to execute the script in the current directory.
Double-Click in Finder:
Save your bash script with no file extension (e.g., bash_file instead of bash_file.sh).
Alternatively, right-click the script file, choose “Get Info,” and set “Open with” to Terminal.app.
Now you can double-click the script in Finder to execute it.

Using zsh (zshell):
Note that the default shell on macOS used to be bash, but now it’s zsh (zshell).
Both shells work, and you can choose based on your preferences.
Familiarize yourself with common shell commands, such as cp for copying files or killall for stopping processes or apps 1234.


                   
