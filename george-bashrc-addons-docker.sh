#     .....................:
# uses secret $REYMONTE_IMAGE_REGISTRY_USER
# uses secret $REYMONTE_IMAGE_REGISTRY_PASS
# uses secret $REYMONTE_IMAGE_REGISTRY_ADDRESS

source secrets.sh

# .........................:
echo "registry_login.......: login to the docker registry"
function registry_login()
{
  sudo docker login -u $REYMONTE_IMAGE_REGISTRY_USER --password $REYMONTE_IMAGE_REGISTRY_PASS $REYMONTE_IMAGE_REGISTRY_ADDRESS
  registry_list
  # see https://docs.docker.com/registry/spec/api/#deleting-an-image
}


# ..........................:
echo "registry_list.........: list images stored in the registry"
function registry_list()
{
  curl https://$REYMONTE_IMAGE_REGISTRY_USER:$REYMONTE_IMAGE_REGISTRY_PASS@$REYMONTE_IMAGE_REGISTRY_ADDRESS/v2/_catalog
}

echo "registry_cleanup.........: ask registry to perorm garbage collection"
function registry_cleanup()
{
  # WARNING:
  # only run this when you are sure that there is noone writing to the registry
  # needs to be executed from sudo
  #
  # usage:
  # go root and manually delete the manifests of interests
  # there: /opt/docker/registry/data/docker/registry/v2/repositories/<repository>/<manifest>
  cd /opt/docker/registry/data/docker/registry/v2/repositories
  ls
  # THEN run this:
  docker exec -it gui_registry_1 bin/registry garbage-collect /etc/docker/registry/config.yml
  docker restart gui_registry_1
}

# ..........................:

# .........................:
echo "dbr..................: docker build and run the Dockerfile"
function dbr()
{
  # docker build .
  docker-compose build
  # docker run -it $(docker images --format "{{.ID}} {{.CreatedAt}}" | sort -rk 2 | awk 'NR==1{print $1}')
  docker up
}

function docker_last_image()
{
  echo $(docker images --format "{{.ID}} {{.CreatedAt}}" | sort -rk 2 | awk 'NR==1{print $1}')
}

# how to get docker container to serve an X11 app:
# https://gursimar27.medium.com/run-gui-applications-in-a-docker-container-ca625bad4638

echo "docker_tag \$1........: tag \$1 with the local registry name"
function docker_tag()
{
  docker tag $(docker_last_image) $REYMONTE_IMAGE_REGISTRY_ADDRESS/sources/$1
}
