# george-bashrc-addons-screen.sh

# find screens
echo -n "screens: "
screen -list | while read c1 c2 c3; do echo $c1; done |  sed '1d; $d' | sed ':b;N;$!bb;s/\n/ | /g;'

#     .....................:
# echo "sl,sx,ss, z, zi......: screen -list, -x, -S; exit = ctrl-A,D; interactive cd"
# echo "ctrl-A,D.............: exit screen"
export GRTools=$GRTools"sl sx ss z zi "
alias sl="screen -list"
alias sx="screen -x"
alias ss="screen -S"

function fix_screen()
{
  sudo mkdir -p /run/screen
  sudo chown mib07150 /run/screen
  sudo chmod 777 /run/screen
}

