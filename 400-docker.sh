#     .....................:
# uses secret $REYMONTE_IMAGE_REGISTRY_USER
# uses secret $REYMONTE_IMAGE_REGISTRY_PASS
# uses secret $REYMONTE_IMAGE_REGISTRY_ADDRESS

source secrets.sh

# .........................:
# echo "registry_login.......: login to the docker registry"
export GRTools=$GRTools"registry+ _login _list _cleanup "
function registry_login()
{
  sudo docker login -u $REYMONTE_IMAGE_REGISTRY_USER --password $REYMONTE_IMAGE_REGISTRY_PASS $REYMONTE_IMAGE_REGISTRY_ADDRESS
  registry_list
  # see https://docs.docker.com/registry/spec/api/#deleting-an-image
}


# .........................:
# echo "registry_list........: list images stored in the registry"
function registry_list()
{
  curl https://$REYMONTE_IMAGE_REGISTRY_USER:$REYMONTE_IMAGE_REGISTRY_PASS@$REYMONTE_IMAGE_REGISTRY_ADDRESS/v2/_catalog
}
# .........................:
# echo "registry_cleanup.....: ask registry to perform garbage collection"
function registry_cleanup()
{
  # WARNING:
  # only run this when you are sure that there is noone writing to the registry
  # needs to be executed from sudo
  #
  # usage:
  # go root and manually delete the manifests of interests
  # there: /opt/docker/registry/data/docker/registry/v2/repositories/<repository>/<manifest>
  pushd /opt/docker/registry/data/docker/registry/v2/repositories
  ls
  echo "you can do >> rm -r * << here -- but be careful"
  echo "then, restart registry_cleanup"

  # THEN run this:
  docker exec -it gui_registry_1 bin/registry garbage-collect /etc/docker/registry/config.yml
  docker restart gui_registry_1
  echo "I came here from: $(dirs)"
}


# .........................:
# echo "dbr..................: docker build and run the Dockerfile"
export GRTools=$GRTools"dbr "
function dbr()
{
  # docker build .
  docker-compose build
  # docker run -it $(docker images --format "{{.ID}} {{.CreatedAt}}" | sort -rk 2 | awk 'NR==1{print $1}')
  docker up
}
export GRTools=$GRTools"docker+ _last_image "
function docker_last_image()
{
  echo $(docker images --format "{{.ID}} {{.CreatedAt}}" | sort -rk 2 | awk 'NR==1{print $1}')
}

# how to get docker container to serve an X11 app:
# https://gursimar27.medium.com/run-gui-applications-in-a-docker-container-ca625bad4638

# echo "docker_tag \$1........: tag \$1 with the local registry name"
export GRTools=$GRTools" _tag "
function docker_tag()
{
  docker tag $(docker_last_image) $REYMONTE_IMAGE_REGISTRY_ADDRESS/sources/$1
}

function docker_cleanup()
{
# this clears the builder cache, forces full rebuilds on next docker builder run
# https://docs.docker.com/engine/reference/commandline/builder_prune/
docker builder prune -f --all
}

# .........................:
# echo "docker_dangerous_cleanup.........: !!! WARNING !!!: remove all non-running things from docker system"
function docker_dangerous_cleanup()
{
  docker container prune
  docker builder prune --all
  docker image prune -a
  docker system prune -a
  registry_cleanup
}