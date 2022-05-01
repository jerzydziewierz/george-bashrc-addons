# George's .bashrc tools & config

# echo "
# |0-------|10-------|20-------|30-------|40-------|50-------|60-------|70-------|"

eval "$(zoxide init bash)"

function make_link()
{
echo -e -n "\e]8;;$1\a$2\e]8;;\a"
}

# find screens

echo -n "screens: "
screen -list | while read c1 c2 c3; do echo $c1; done |  sed '1d; $d' | sed ':b;N;$!bb;s/\n/ | /g;'

#     .....................:
echo "sl,sx,ss, z, zi......: screen -list, -x, -S; interactive cd"
echo "ctrl-A,D.............: exit screen"
alias sl="screen -list"
alias sx="screen -x"
alias ss="screen -S"


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


echo "ctrl-R, ctrl-T.......: last command, file search"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash



function cd() {
 z "$@"
}
#     .....................:
echo "reymonte_++:.........: reymonte ops:"
echo "ssh, sshfs, unmount..:  "
echo "start, stop .........:  "
function reymonte_sshfs()
{
fusermount -u ~/git/reymonte
sshfs -o idmap=user paperspace@184.105.118.249:/ ~/git/reymonte
}
function reymonte_unmount()
{
fusermount -u ~/git/reymonte
}
function reymonte_ssh()
{
ssh -X paperspace@184.105.118.249
}

# export PAPERSPACE_APIKEY=db2bf2e24c1acd37eabdf4fa418c9c
function reymonte_start()
{
curl -X POST -v 'https://api.paperspace.io/machines/pslgaourx/start' -H 'X-Api-Key: db2bf2e24c1acd37eabdf4fa418c9c' 
}
# echo "reymonte_stop.....: stop reymonte"
function reymonte_stop()
{
curl -X POST -v 'https://api.paperspace.io/machines/pslgaourx/stop' -H 'X-Api-Key: db2bf2e24c1acd37eabdf4fa418c9c' 
}  

function reymonte_unmount()
{
fusermount -u ~/git/reymonte
}

# ============================= CODEGEN machine
export CODEGEN_IP=64.71.146.214

function codegen_ssh()
{
ssh -X paperspace@$CODEGEN_IP
}

function codegen_sshfs()
{
mkdir -p ~/git/qCodeGen
fusermount -u ~/git/qCodeGen
sshfs -o idmap=user paperspace@$CODEGEN_IP:/ ~/git/qCodeGen
}




function codegen_unmount()
{
fusermount -u ~/git/qCodeGen1
}

function uzdrowiciel_sshfs()
{
cd ~
mkdir -p ~/git/uzdrowiciel
fusermount -u ~/git/uzdrowiciel
sshfs -o idmap=user ftpq:d9rq28rdcpq99@rey.wiki:/ ~/git/uzdrowiciel
}

echo "sb...................: reload .bashrc"
function sb()
{
    source ~/.bashrc
}
