# basrc-addons-reymonte.sh

#     .....................:
# uses secret REYMONTE_IP
# echo "reymonte_+ uzdrowiciel_+ ops :"
# echo "ssh, sshfs, unmount..:  "
# echo "start, stop .........:  "
function rsh_stl()
{
  ssh -X 10.1.206.23
}

function rfs_stl()
{
  mkdir -p ~/git/remote-fs/stl
  fusermount -u ~/git/remote-fs/stl
  sshfs -o idmap=user mib07150@10.1.206.23:/ ~/git/remote-fs/stl
  cd ~/git/remote-fs/stl/home/mib07150/
  ls
  pwd
}

export GRTools=$GRTools"raspi+ uzdrowiciel+ reymonte+ any+ reactai+ _ssh _sshfs _start _stop _unmount _start_relay"
function rfs_reymonte()
{
fusermount -u ~/git/reymonte
sshfs -o idmap=user paperspace@$REYMONTE_IP:/ ~/git/remote-fs/reymonte
cd ~/git/reymonte/home/paperspace/git
ls
pwd
}
function rfs_reymonte_unmount()
{
fusermount -u ~/git/remote-fs/reymonte
}
function rsh_reymonte_ssh()
{
ssh -X paperspace@$REYMONTE_IP
}

# export PAPERSPACE_APIKEY=db2bf2e24c1acd37eabdf4fa418c9c
# uses secret PAPERSPACE_APIKEY
# uses secret PAPERSPACE_REYMONTE_MACHINENAME
function rsh_reymonte_start()
{
  # options: -v
curl -X POST "https://api.paperspace.io/machines/$PAPERSPACE_REYMONTE_MACHINENAME/start" -H "X-API-Key: $PAPERSPACE_APIKEY"
}
# echo "reymonte_stop.....: stop reymonte"
function rsh_reymonte_stop()
{
  # options: -v
curl -X POST "https://api.paperspace.io/machines/$PAPERSPACE_REYMONTE_MACHINENAME/stop" -H "X-API-Key: $PAPERSPACE_APIKEY"
}  



# ============================= uzdrowiciel machine
# uses secret UZDROWICIEL_SFTP_ACCOUNTNAME
function rfs_uzdrowiciel_sshfs()
{
cd ~
mkdir -p ~/git/remote-fs/uzdrowiciel
fusermount -u ~/git/remote-fs/uzdrowiciel
sshfs -p 22222 -o idmap=user ${UZDROWICIEL_SFTP_ACCOUNTNAME}@${UZDROWICIEL_SFTP_SERVER}:/home/ftpq4/ ~/git/uzdrowiciel
pushd ~/git/remote-fs/uzdrowiciel
ls -la
}

function rsh_uzdrowiciel()
{
ssh -p 22222 ${UZDROWICIEL_SFTP_ACCOUNTNAME}@${UZDROWICIEL_SFTP_SERVER}
}



# echo "raspi_sshfs......: open sshfs connection to 192.168.3.2/"

function rfs_raspi_sshfs()
{
fusermount -u ~/git/remote-fs/raspi
mkdir -p ~/git/remote-fs/raspi
sshfs -o idmap=user mib07150@$RASPI_IP:/ ~/git/remote-fs/raspi
pushd ~/git/remote-fs/raspi
echo $(pwd)
}

#     .....................:
# echo "raspi_ssh..........: open $RASPI_IP
function rsh_raspi_ssh()
{
screen -t raspi bash -c 'ssh -X $RASPI_IP'
}

function rsh_datacrunch()
{
ssh -C -X root@${DATACRUNCH_IP}
}
function rsh_datacrunch_cleanup_key()
{
  ssh-keygen -f "/home/mib07150/.ssh/known_hosts" -R "${DATACRUNCH_IP}"
}
function rfs_datacrunch_sshfs()
{
cd ~
mkdir -p ~/git/remote-fs/datacrunch
fusermount -u ~/git/remote-fs/datacrunch
sshfs -o idmap=user root@${DATACRUNCH_IP}:/ ~/git/remote-fs/datacrunch
pushd ~/git/remote-fs/datacrunch/
}

function rfs_datacrunch_nmount()
{
fusermount -u ~/git/remote-fs/datacrunch "$1"
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


function rsh_reactai_ssh()
{
  ssh -X -i $KEY_DEV_REACTAI_COM_FILE george@dev.reactai.com
}


function rsh_reactai_relay()
{
  screen -dmS dev-reactai-relay bash -c -i _reactai_relay


}
function _reactai_relay()
{ # this relays port 8888 from the target machine to my machine, enabling me to see the target machine's jupyter notebook server at port 8892
  # no X-server relay on this session!
  # use 8892 for jupyter
  # use 6002 for tensorboard

  ssh -v -i $KEY_DEV_REACTAI_COM_FILE -NL 8892:localhost:8892 -NL 6002:localhost:6002 george@dev.reactai.com
}


function rfs_reactai_sshfs()
{
  mkdir -p ~/git/remote-fs/reactai
  fusermount -u ~/git/remote-fs/reactai
  sshfs -o IdentityFile=$KEY_DEV_REACTAI_COM_FILE -o idmap=user george@dev.reactai.com:/ ~/git/remote-fs/reactai
  pushd ~/git/remote-fs/reactai/home/george
  kh
}

function reactai_jupyter()
{ # start jupyter notebook, but
  # * with a different port
  # * with no browser
  # * with root allowed
  # This is intended for ssh-relayed access.
  #
  # Usage:
  # 1. on the GUI, use reactai_start_relay() to start the relay
  # 2. on the GUI, ssh into ReactAI using reactai_ssh() and run reactai_jupyter()
  #
  # Future work:
  # collapse all of this into a single command that pipes scripts through ssh straight to the target machine.
  echo "THIS IS INTENDED TO BE RAN ON THE REACTAI host"
  screen -S jupyter bash -c "jupyter notebook --allow-root --no-browser --port 8892"
# jupyter notebook --allow-root --no-browser --port 11234
# ssh -X -L 11234:localhost:11234 root@host
}