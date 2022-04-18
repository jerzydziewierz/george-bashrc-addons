# George's .bashrc tools & config

# echo "
# |0-------|10-------|20-------|30-------|40-------|50-------|60-------|70-------|"

# source the secrets
. secrets.sh

. george-bashrc-addons-screen.sh
. george-bashrc-addons-cli.sh

# load reymonte commands
. george-bashrc-addons-reymonte.sh
. george-bashrc-addons-devel-tools.sh
. fancy-prompt

#    .....................:
# echo "gping.............: gping"
function gping()
{ # start gping in screen, but also do not disconnect -- stay connected
    # gstatic.com www.interieur.gouv.fr  
    screen -S gping -m bash -c "~/prog/gping/gping richards.planeti.co.uk docker.planeti.co.uk"
}


#     .....................:
echo "sb...................: reload .bashrc"
function sb()
{
    . ~/.bashrc
}


function make_link()
{
echo -e -n "\e]8;;$1\a$2\e]8;;\a"
}

echo -n "| $(make_link https://eu.actitime.com/stl-tech 'Time tracker') "
echo -n "| $(make_link https://stltech.atlassian.net/jira/your-work 'Jira') "
echo -n "| $(make_link https://bitbucket.org/dashboard/overview 'Bitbucket') "
echo -n "| "


