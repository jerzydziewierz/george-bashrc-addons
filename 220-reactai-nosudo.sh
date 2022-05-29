# how to run redis-server with no sudo
function reactai_nosudo()
{
  screen -dmS redis-server bash -c -i _reactai_nosudo
}

function  _reactai_nosudo()
{
  cd /home/george/prog/from-source/redis/redis-stable/src
  ./redis-server
}