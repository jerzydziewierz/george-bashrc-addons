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
echo "registry_list........: list images stored in the registry"
function registry_list()
{
  curl https://$REYMONTE_IMAGE_REGISTRY_USER:$REYMONTE_IMAGE_REGISTRY_PASS@$REYMONTE_IMAGE_REGISTRY_ADDRESS/v2/_catalog
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
