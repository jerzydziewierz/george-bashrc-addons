#     .....................:
# uses secret $REYMONTE_IMAGE_REGISTRY_USER
# uses secret $REYMONTE_IMAGE_REGISTRY_PASS
# uses secret $REYMONTE_IMAGE_REGISTRY_ADDRESS

source secrets.sh

# ..........................:
echo "registry_login........: login to the docker registry"
function registry_login()
{
  sudo docker login -u $REYMONTE_IMAGE_REGISTRY_USER --password $REYMONTE_IMAGE_REGISTRY_PASS $REYMONTE_IMAGE_REGISTRY_ADDRESS
  registry_list
}


# ..........................:
echo "registry_list........: list images stored in the registry"
function registry_list()
{
  curl https://$REYMONTE_IMAGE_REGISTRY_USER:$REYMONTE_IMAGE_REGISTRY_PASS@$REYMONTE_IMAGE_REGISTRY_ADDRESS/v2/_catalog
}

# ..........................:
echo "docker_tag \$1.......: tag \$1 with the local registry name"
function docker_tag()
{
  docker tag $1 $REYMONTE_IMAGE_REGISTRY_ADDRESS/sources/$1
}
