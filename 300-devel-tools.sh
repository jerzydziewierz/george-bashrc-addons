# george-bashrc-addons-devel-tools.sh

#     .....................:
# uses secret $RASPI_IP

# echo "raspi_math...........: open $RASPI_IP"
export GRTools=$GRTools"raspi_math "
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
# echo "clion, pycharm.......: start CLion, pycharm"
# export GRTools=$GRTools"clion pycharm "
# function clion()
# {
#    screen -S clion -d -m bash -i -c "conda deactivate && conda deactivate && ~/prog/clion-2021.3.3/bin/clion.sh" 
#    echo "started clion in screen. The screen sessions are now:"
#    sl
# }

# function pycharm()
# {
#     screen -S pycharm  -d -m bash -c "pycharm-professional" 
#    echo "started pycharm in screen. The screen sessions are now:"
#    sl
# }


#     .....................:
# echo "mambao...............: mamba install"
export GRTools=$GRTools"mambao "
alias mambao='mamba install --use-index-cache -y'

#     .....................:
# echo "lsopo................: list open ports"
export GRTools=$GRTools"lsopo "
function lsopo()
{
sudo lsof -i -P -n | grep LISTEN
}

#     .....................:
# echo "cdr..................: go to the git repo root folder"
export GRTools=$GRTools"cdr "
function cdr()
{
z $(git rev-parse --show-toplevel)
}

#     .....................:
# echo "kilidar..............: kill doTDLidar, if it exists"
export GRTools=$GRTools"kilidar "
function kilidar()
{
  sudo lsof -i -P -n | grep LISTEN | grep doTDLidar | while read c1 c2 c3; do sudo kill $c2; echo "got one"; done
}



#     .....................:
# echo "gap..................: git add, commit and push"
export GRTools=$GRTools"gap "
function gap()
{
pushd "$(git rev-parse --show-toplevel)" || exit 1
  gaa $1
  git push origin
popd
}

# git add all and commit -- do everything that gap used to do except for push
function gaa()
{
  pushd "$(git rev-parse --show-toplevel)" || exit 1
  if [ -z "$1" ]; then
    echo "gap: using default message"
    local msg="autosave"
  else
    echo "gap: $1"
    local msg=$1
    fi
  git add .
  git commit -m "$msg"
  git fetch
  git merge -m 'automerge'
  git add .
  git commit -m "post-auto-merge+$msg"
  git push origin
popd || echo "popd failed in gaa $1"
}


# echo "gmd..................: git merge devel branch"
export GRTools=$GRTools"gmd "
function gmd()
{
  local currentFolder
  currentFolder=$(pwd)
  cdr
  gaa
  local currentBranch
  currentBranch=$(git symbolic-ref --short HEAD)
  echo "going to devel..."
  git checkout devel
  git pull --recurse-submodules
  git pull
  {
    echo "going to tools..."
    {
      pushd src/engine/tools
    } || { echo "pushd src/engine/tools failed" ; return ; }
    gaa
    git checkout devel
    git pull
    popd
  } || { echo "updating tools failed" && return ; }

  {
    echo "updating devel-reference..."
    git checkout devel-reference
    git merge devel
    echo "done."
  } || { echo "git checkout devel-reference failed - continuing"; }
  echo "going back to $currentBranch..."
  git checkout "${currentBranch}"
  git merge devel
  echo "going back to $currentFolder..."
  cd "$currentFolder" || { echo "cd $currentFolder failed" ;  return; }
}

# echo "pt..................: push to tools. Dev helper"
function cdt()
{
  pushd src/engine/tools || echo "pushd src/engine/tools failed"
  git status
}
#     .....................:
# echo "dfh..................: show device free space"
export GRTools=$GRTools"dfh "
alias dfh="df -h | grep -v 100% | grep -v tmpfs | grep -v udev"


#     .....................:
# echo "start_jupyter.......: synchronize daily-notes"
function start_jupyter()
{
echo "starting jupyter notebook from ~,  in SCREEN"

screen -S jupyter -d -m bash -i -c "__jupyter"
sl
}

function __jupyter()
{
  echo "in __jupyter"
  echo "starting jupyter with home folder as root..."
  echo "======================================"
  cd ~
  conda activate jupyter
  jupyter notebook
}
