# basrc-addons-reymonte.sh

#     .....................:
# uses secret REYMONTE_IP
# echo "reymonte_+ uzdrowiciel_+ ops :"
# echo "ssh, sshfs, unmount..:  "
# echo "start, stop .........:  "
export GRTools=$GRTools"raspi+ uzdrowiciel+ reymonte+ _ssh _sshfs _start _stop _unmount "
function reymonte_sshfs()
{
fusermount -u ~/git/reymonte
sshfs -o idmap=user paperspace@$REYMONTE_IP:/ ~/git/reymonte
cd ~/git/reymonte/home/paperspace/git
ls
pwd
}
function reymonte_unmount()
{
fusermount -u ~/git/reymonte
}
function reymonte_ssh()
{
ssh -X paperspace@$REYMONTE_IP
}

# export PAPERSPACE_APIKEY=db2bf2e24c1acd37eabdf4fa418c9c
# uses secret PAPERSPACE_APIKEY
# uses secret PAPERSPACE_REYMONTE_MACHINENAME
function reymonte_start()
{
  # options: -v
curl -X POST "https://api.paperspace.io/machines/$PAPERSPACE_REYMONTE_MACHINENAME/start" -H "X-API-Key: $PAPERSPACE_APIKEY"
}
# echo "reymonte_stop.....: stop reymonte"
function reymonte_stop()
{
  # options: -v
curl -X POST "https://api.paperspace.io/machines/$PAPERSPACE_REYMONTE_MACHINENAME/stop" -H "X-API-Key: $PAPERSPACE_APIKEY"
}  



# ============================= uzdrowiciel machine
# uses secret UZDROWICIEL_SFTP_ACCOUNTNAME
function uzdrowiciel_sshfs()
{
cd ~
mkdir -p ~/git/uzdrowiciel
fusermount -u ~/git/uzdrowiciel
sshfs -p 22222 -o idmap=user $UZDROWICIEL_SFTP_ACCOUNTNAME:/ ~/git/uzdrowiciel
pushd ~/git/uzdrowiciel
}



# echo "raspi_sshfs......: open sshfs connection to 192.168.3.2/"

function raspi_sshfs()
{
fusermount -u ~/git/raspi
mkdir -p ~/git/raspi
sshfs -o idmap=user mib07150@$RASPI_IP:/ ~/git/raspi
pushd ~/git/raspi
echo $(pwd)
}

#     .....................:
# echo "raspi_ssh..........: open $RASPI_IP
function raspi_ssh()
{
screen -t raspi bash -c 'ssh -X $RASPI_IP'
}

export DATACRUNCH_IP=root@65.108.33.76
function any_ssh()
{
ssh -X $DATACRUNCH_IP
}
function any_sshfs()
{
cd ~
mkdir -p ~/git/datacrunch
fusermount -u ~/git/datacrunch
sshfs -o idmap=user $DATACRUNCH_IP:/ ~/git/datacrunch
pushd ~/git/datacrunch/
}

# === run jupyter notebook via ssh
# screen -S jupyter
# jupyter notebook --allow-root --no-browser --port 11234
# ssh -X -L 11234:localhost:11234 root@host

#     .....................:
 echo "kh..................: open krusader **here**"
function kh()
{
  local localcmd="krusader $(pwd)"
  local localcmd2="bash -c '$localcmd'"
  screen -S "krusader-here" -dm bash -c "$localcmd"
  sl
}