# basrc-addons-reymonte.sh

#     .....................:
# uses secret REYMONTE_IP
echo "reymonte_+ uzdrowiciel_+ ops :"
echo "ssh, sshfs, unmount..:  "
echo "start, stop .........:  "
function reymonte_sshfs()
{
fusermount -u ~/git/reymonte
sshfs -o idmap=user paperspace@$REYMONTE_IP:/ ~/git/reymonte
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
curl -X POST -v "https://api.paperspace.io/machines/$PAPERSPACE_REYMONTE_MACHINENAME/start" -H "$PAPERSPACE_APIKEY"
}
# echo "reymonte_stop.....: stop reymonte"
function reymonte_stop()
{
curl -X POST -v "https://api.paperspace.io/machines/$PAPERSPACE_REYMONTE_MACHINENAME/stop" -H "$PAPERSPACE_APIKEY"
}  



# ============================= uzdrowiciel machine
# uses secret UZDROWICIEL_SFTP_ACCOUNTNAME
function uzdrowiciel_sshfs()
{
cd ~
mkdir -p ~/git/uzdrowiciel
fusermount -u ~/git/uzdrowiciel
sshfs -o idmap=user $UZDROWICIEL_SFTP_ACCOUNTNAME:/ ~/git/uzdrowiciel
}



# echo "raspi_sshfs......: open sshfs connection to 192.168.3.2/"

function raspi_sshfs()
{
fusermount -u ~/git/raspi
mkdir -p ~/git/raspi
sshfs -o idmap=user mib07150@$RASPI_IP:/ ~/git/raspi
}

#     .....................:
# echo "raspi_ssh..........: open $RASPI_IP
function raspi_ssh()
{
screen -t raspi bash -c 'ssh -X $RASPI_IP'
}


