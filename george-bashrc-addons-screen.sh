# george-bashrc-addons-screen.sh

# find screens
echo -n "screens: "
screen -list | while read c1 c2 c3; do echo $c1; done |  sed '1d; $d' | sed ':b;N;$!bb;s/\n/ | /g;'

#     .....................:
echo "sl,sx,ss, z, zi......: screen -list, -x, -S; interactive cd"
echo "ctrl-A,D.............: exit screen"
alias sl="screen -list"
alias sx="screen -x"
alias ss="screen -S"


