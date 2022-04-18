rel=$(cat /etc/os-release)
if [[ "$rel" =~ .*Fossa.* ]]; then   # if system is ubuntu 20
  # this repo is needed to get python3.7 on Ubuntu 20
  echo "I think that your system is Ubuntu Focal Fossa. (20)"
  # echo "Adding Deadsnakes repo to get python3.7"
  # $SUDO apt-add-repository -y -n ppa:deadsnakes/ppa
else
  echo "I think your system is not Ubuntu Focal Fosa. Let's hope you have python3.7 available."
fi
