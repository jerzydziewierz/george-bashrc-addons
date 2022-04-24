
#    .....................:
# echo "gping.............: gping"
function gping()
{ # start gping in screen, but also do not disconnect -- stay connected
    # gstatic.com www.interieur.gouv.fr
    screen -S gping -m bash -c "~/prog/gping/gping richards.planeti.co.uk docker.planeti.co.uk"
}


#     .....................:
# echo "rc...................: reload .bashrc"
function rc()
{
    . ~/.bashrc
}

echo "uprc.................: update bashrc addons from git repo"
function uprc()
{
  pushd ~/git/george-bashrc-addons/
  git pull
  popd
  . ~/.bashrc
}