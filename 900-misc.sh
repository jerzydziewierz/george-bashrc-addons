
#    .....................:
# echo "gping.............: gping"
export GRTools=$GRTools"gping "
function gping()
{ # start gping in screen, but also do not disconnect -- stay connected
    # gstatic.com www.interieur.gouv.fr
    screen -S gping -m bash -c "~/prog/gping/gping richards.planeti.co.uk docker.planeti.co.uk"
}


#     .....................:
# echo "rc...................: reload .bashrc"
export GRTools=$GRTools"rc "
function rc()
{
    . ~/.bashrc
}

# echo "uprc.................: update bashrc addons from git repo"
export GRTools=$GRTools"rcup "
function rcup()
{
  pushd ~/git/george-bashrc-addons/
  git pull
  popd
  . ~/.bashrc
}