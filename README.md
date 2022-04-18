# george-bashrc-addons
bash and CLI convenience tools

here is a collection of convenience tools that I have gathered over time

They are intended to work on ubuntu 20+

some are dependent on software packages already installed on the system 

# Summary

## General 

## CLI

## Devel

## Screen

# Installation

on a fresh machine,

### STEP 1

see `ubuntu-preparator-***.sh` file first

open, edit, execute as needed 

### STEP 2

```bash 
cd ~
mkdir -p git prog
pushd ~/git
git clone https://github.com/jerzydziewierz/george-bashrc-addons.git
echo "pushd ~/git/george-bashrc-addons/"
echo ". ~/git/george-bashrc-addons/george-bashrc-addons.sh" >> ~/.bashrc
echo "popd"
pushd ~/git/george-bashrc-addons/
cp secrets.template.sh secrets.sh
popd
popd 
```

### STEP 3

copy `secrets.template.sh` to `secrets.sh` 

edit `secrets.sh` to add secrets

### STEP 4


add this line to `~/.bashrc` :

```bash
echo ". ~/git/george-bashrc-addons/george-bashrc-addons.sh" >> ~/.bashrc 
```
