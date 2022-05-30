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
sshfs -p 22222 -o idmap=user ${UZDROWICIEL_SFTP_ACCOUNTNAME}@${UZDROWICIEL_SFTP_SERVER}:/home/ftpq4/ ~/git/uzdrowiciel
pushd ~/git/uzdrowiciel
ls -la
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

function any_ssh()
{
ssh -C -X root@${DATACRUNCH_IP}
}
function any_cleanup_key()
{
  ssh-keygen -f "/home/mib07150/.ssh/known_hosts" -R "${DATACRUNCH_IP}"
}
function any_sshfs()
{
cd ~
mkdir -p ~/git/datacrunch
fusermount -u ~/git/datacrunch
sshfs -o idmap=user root@${DATACRUNCH_IP}:/ ~/git/datacrunch
pushd ~/git/datacrunch/
}

function any_unmount()
{
fusermount -u ~/git/datacrunch "$1"
}

# === run jupyter notebook via ssh
# screen -S jupyter
# jupyter notebook --allow-root --no-browser --port 11234
# ssh -X -L 11234:localhost:11234 root@host

#     .....................:
# echo "kh..................: open krusader **here**"
export GRTools=$GRTools"kh "
function kh()
{
  local localcmd="krusader $(pwd)"
  local localcmd2="bash -c '$localcmd'"
  screen -S "krusader-here" -dm bash -c "$localcmd"
  sl
}

function random_port()
{ # random port number between 2000 and 65535
  echo $(shuf -i 2000-65535 -n 1)
}


function reactai_ssh()
{
  ssh -X -i $KEY_DEV_REACTAI_COM_FILE george@dev.reactai.com
}

function reactai_start_relay()
{
  screen -dmS dev-reactai-relay bash -c -i _reactai_relay_jupyter
  screen -dmS dev-reactai-relay bash -c -i _reactai_relay_tensorboard

}
function _reactai_relay_jupyter()
{ # this relays port 8888 from the target machine to my machine, enabling me to see the target machine's jupyter notebook server at port 8892
  # no X-server relay on this session!
  # use 8892 for jupyter
  # use 6002 for tensorboard

  ssh -v -i $KEY_DEV_REACTAI_COM_FILE -NL 8892:localhost:8892 -NL 6002:localhost:6002 george@dev.reactai.com
}

function _reactai_relay_tensorboard()
{ # this relays port 8888 from the target machine to my machine, enabling me to see the target machine's jupyter notebook server at port 8892
  # no X-server relay on this session!

  ssh -v -i $KEY_DEV_REACTAI_COM_FILE -NL 6002:localhost:6002 george@dev.reactai.com
}

function reactai_sshfs()
{
  mkdir -p ~/git/reactai
  fusermount -u ~/git/reactai
  sshfs -o IdentityFile=$KEY_DEV_REACTAI_COM_FILE -o idmap=user george@dev.reactai.com:/ ~/git/reactai
  pushd ~/git/reactai/home/george
  kh
}
