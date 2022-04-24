# george-bashrc-addons-cli.sh

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoredups:erasedups
# This will save  and reload the history between commands, 
# effectively sharing the history across all terminals
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# update the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# start zoxide
eval "$(zoxide init bash)"


function z() {
    __zoxide_z "$@"
    echo "----"
    ls
    echo "----"
}

# echo "z, zi .............: interactive cd\n"
__zoxide_unset 'zi'

function zi() {
    __zoxide_zi "$@"
    echo "----"
    ls
    echo "----"
}

#     .....................:
echo "fix_zoxide...........:"
function fix_zoxide()
{
sudo chown a /home/mib07150/.local/share/zoxide/db.zo
}

#     .....................:
echo "say..................: sudo apt install -y \$1"
function say()
{
sudo apt install -y $1
}

#     .....................:
echo "mkdirp...............: mkdir -p $1 and cd $1"
function mkdirp()
{
mkdir -p $1
cd $1
}



echo "ctrl-R, ctrl-T.......: last command, file search"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# note: it may be risky to shadow the cd command
#function cd() {
# z "$@"
#}


}