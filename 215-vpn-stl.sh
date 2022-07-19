function start_vpn()
{
  echo "current IP : $(curl --no-progress-meter ifconfig.me)"
  echo "---------- here are the sessions:"
  openvpn3 sessions-list
  echo "---------- attempting to stop the session..."
  openvpn3 session-start --config ${GEORGE_ADDONS_FOLDER}/secrets/vpn-paris.ovpn
  echo "---------- here are the sessions after attempting to start:"
  openvpn3 sessions-list
  echo "---------- sleeping 7 seconds . . . . "
  for i in {1..7}; do echo -n "." && sleep 1; done
  openvpn3 sessions-list
  echo "current IP : $(curl --no-progress-meter ifconfig.me)"
}

function stop_vpn()
{
  echo "---------- here are the sessions:"
  openvpn3 sessions-list
  echo "---------- attempting to stop the session..."
  openvpn3 session-manage --config ${GEORGE_ADDONS_FOLDER}/secrets/vpn-paris.ovpn --disconnect
  echo "---------- here are the sessions after attempting to stop:"
  openvpn3 sessions-list

}

function reset_vpn_sessions()
{
  for session in $(awk '{print $2}' <<< $(openvpn3 sessions-list  | grep Path:))
  do
    echo "---------- attempting to stop the session ${session} ..."
    openvpn3 session-manage --path ${session} --disconnect
  done
}

function start_stl_webcam()
{
  echo "note that this must be ran under vpn connection"
  ssh 10.1.206.23 "ffmpeg -an -f video4linux2 -i /dev/video0 -r 5 -b:v 64k -f matroska pipe:1" | mpv --demuxer=mkv /dev/stdin -
}