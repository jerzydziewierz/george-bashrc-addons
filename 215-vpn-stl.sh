function start_vpn()
{
  openvpn3 session-start --config ${GEORGE_ADDONS_FOLDER}/secrets/vpn.ovpn
}

function stop_vpn()
{
  openvpn3 session-manage --config ${GEORGE_ADDONS_FOLDER}/secrets/vpn.ovpn --disconnect
}

function start_stl_webcam()
{
  echo "note that this must be ran under vpn connection"
  ssh 10.1.206.23 "ffmpeg -an -f video4linux2 -i /dev/video0 -r 5 -b:v 64k -f matroska pipe:1" | mpv --demuxer=mkv /dev/stdin -
}