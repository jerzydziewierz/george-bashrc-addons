# george-bashrc-addons-devel-tools.sh

#     .....................:
# uses secret $RASPI_IP
source secrets.sh
echo "raspi_math...........: open $RASPI_IP"
function raspi_math()
{
screen -dmS raspi bash -c "ssh -X $RASPI_IP mathematica"
}



#     .....................:
# echo "stlvenv..............: STL-STI-venv"
# function stlvenv()
# {
# z /home/mib07150/git/STL/STI/sti_surestop_hub
# conda deactivate
# source scripts/setup-venv.sh
# }



#     .....................:
echo "clion, pycharm.......: start CLion, pycharm"
# echo "pycharm...........: start pycharm"
function clion()
{
    screen -S clion -d -m bash -i -c "conda deactivate && conda deactivate && ~/prog/clion-2021.3.3/bin/clion.sh" 
    echo "started clion in screen. The screen sessions are now:"
    sl
}

function pycharm()
{
    screen -S pycharm  -d -m bash -c "pycharm-professional" 
    echo "started pycharm in screen. The screen sessions are now:"
    sl
}


#     .....................:
echo "mambao...............: mamba install"
alias mambao='mamba install --use-index-cache -y'

#     .....................:
echo "lsopo................: list open ports"
function lsopo()
{
sudo lsof -i -P -n | grep LISTEN
}

#     .....................:
echo "cdr..................: go to the git repo root folder"
function cdr()
{
z $(git rev-parse --show-toplevel)
}

#     .....................:
echo "kilidar..............: kill doTDLidar, if it exists"
function kilidar()
{
  sudo lsof -i -P -n | grep LISTEN | grep doTDLidar | while read c1 c2 c3; do sudo kill $c2; echo "got one"; done
}


# Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

#     .....................:
echo "start_notesync.......: synchronize daily-notes"
function start_notesync()
{
echo "starting notesync in SCREEN"
screen -S notesync -d -m bash -i -c "__notesync" 
sl
}
function __notesync_internal()
{
# cd /home/mib07150/git/STL/georgerey-notes
git add .
git commit -m 'autosave'
git fetch
git merge -m 'automerge'
git add .
git commit -m 'autosave'
# (git ls-files --modified --others --exclude-standard | grep . > /dev/null)
# git push origin
# git push grey-private
git push public
}

function __notesync(){
cd /home/mib07150/git/STL/georgerey-notes
watch -d -n 30 bash -i -c __notesync_internal
}

#     .....................:
echo "gap..................: git add, commit and push"
function gap()
{
pushd $(git rev-parse --show-toplevel)
  if [ -z "$1" ]; then
    echo "gap: using default message"
    local msg="autosave"
  else
    echo "gap: " $1
    local msg = "$1"
    fi
  git add .
  git commit -m "$msg"
  git fetch
  git merge -m 'automerge'
  git add .
  git commit -m "post-auto-merge+$msg"
  git push origin
popd
}
#     .....................:
echo "dfh..................: show device free space"
alias dfh="df -h | grep -v 100% | grep -v tmpfs | grep -v udev"




