# George's .bashrc tools & config

# echo "
# |0-------|10-------|20-------|30-------|40-------|50-------|60-------|70-------|"
# GRTools variable is used to store the help message for the GRTools command set.
export GRTools=""
# source the secrets
. secrets.sh

. 050-screen.sh
. 100-cli.sh

# load reymonte commands
. 200-reymonte.sh
. 210-notesync.sh
. 300-devel-tools.sh
. 400-docker.sh
. 800-fancy-prompt.sh
. 900-misc.sh


echo $GRTools
# private most often used links
. 910-links.sh

conda deactivate