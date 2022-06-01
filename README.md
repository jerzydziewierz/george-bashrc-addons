# george-bashrc-addons

bash and CLI convenience tools

Here is a collection of convenience tools that I have gathered over time.

They are intended to work on ubuntu 20+

Some are dependent on software packages already installed on the system 

# Summary

I'll leave some features undocumented. 

### General 

**gping** 
shortcut to gping a couple of my favorite locations.

**rc**
this will reload .bashrc. Shortcut to `. ~/.bashrc`

**uprc**
this will reload the `george-bashrc-addons` from github. 

**make_link**
this will build a string that (in some terminals) will appear like a clickable link.
example use:
```bash
make_link "George" "http://rey.wiki"
```

The intention is to extend [terminator](https://github.com/gnome-terminator/terminator) to support executing shell commands 

### CLI

**z** 
Interface to [zoxide](https://github.com/ajeetdsouza/zoxide)

**zi** interface to [zoxide](see https://github.com/ajeetdsouza/zoxide)

**fix_zoxide**
if you used `zoxide` in root mode (not sudo mode), it's database might be marked as owned by root. 
This will bring back the ownership back to the user. Needs `sudo`.

**ctrl-R** 
last command search using fzf 
see https://github.com/junegunn/fzf

**ctrl-T**
file search using fzf
see https://github.com/junegunn/fzf

### Devel

**mambao**
shortcut to [mamba install](https://github.com/mamba-org/mamba)  

**lsopo**
list open ports. Useful for debugging server apps. 

**cdr** 
this will cd to the git repo's top level (root) folder. Useful when you are done doing some detail and want to quickly push. 

**start_notesync**
this will periodically push my notes repo to it's mirrors.

**gap**
git add, commit and push. Works from any folder in the repo and then comes back to the current folder.

**dfh**
show device's free storage space. uses `df` but filters out junk info.

### Screen

my shortcuts to use the immensely useful [gnu screen](https://www.gnu.org/software/screen/) tool 

**ss** start a new screen. $1 = name of the screen. $2 = command to execute

**sl** list existing screens 

**sx** attach to screen in "X" mode, meaning multiple sessions are allowed. Does not disconnect the previous session.



# Installation

on a fresh machine,

### STEP 1

see `ubuntu-preparator-***.sh` file first

open, edit, execute as needed. Parts of it you might need after other steps are done. 

### STEP 2

```bash 
mkdir -p ~/git ~/prog
pushd ~/git
git clone https://github.com/jerzydziewierz/george-bashrc-addons.git ~/git/george-bashrc-addons/

echo "pushd ~/git/george-bashrc-addons/ >> /dev/null" >> ~/.bashrc
echo ". ~/git/george-bashrc-addons/george-bashrc-addons.sh" >> ~/.bashrc
echo "popd >> /dev/null" >> ~/.bashrc

pushd ~/git/george-bashrc-addons/
cp secrets.template.sh secrets.sh
popd
popd 
```

### STEP 3

```bash
nano secrets.sh
```

