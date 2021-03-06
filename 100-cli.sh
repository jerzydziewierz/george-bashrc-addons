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
    exa --icons --group-directories-first
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
# echo "fix_zoxide...........:"
function fix_zoxide()
{
sudo chown a /home/mib07150/.local/share/zoxide/db.zo
}

#     .....................:
# echo "say..................: sudo apt install -y \$1"
export GRTools=$GRTools"say "
function say()
{
sudo apt install -y $1
}

#     .....................:
# echo "mkdirp...............: mkdir -p $1 and cd $1"
export GRTools=$GRTools"mkdirp "
function mkdirp()
{
mkdir -p $1
cd $1
}

# pwdx : copy current folder to clipboard, and display the contents of the current folder
function pwdx()
{
  # save the current selection in the backup
  # xsel --exchange
  # send pwd to both clipboards -- the X-window and the primary clipboard
  pwd | xsel --clipboard
  echo "----"
  pwd
  echo "----"
  exa -l
  echo "----"
  pwd | xsel --primary
}
# echo "ctrl-R, ctrl-T.......: last command, file search"
export GRTools=$GRTools"ctrl-R ctrl-T "
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# note: it may be risky to shadow the cd command
#function cd() {
# z "$@"
#}
