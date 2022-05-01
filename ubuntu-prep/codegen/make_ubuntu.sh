# this prepares a fresh ubuntu to work for me
DEBIAN_FRONTEND=noninteractive
export USER_DIR=/home/mib07150
cd $USER_DIR

mkdir -p $USER_DIR/prog
mkdir -p $USER_DIR/prog/git 
mkdir -p $USER_DIR/git 
apt update  
apt upgrade -y -force-confnew
apt install -y kate krusader baobab sshfs git make screen p7zip-full curl wget coreutils sed build-essential python3 python3-pip gcc-10 g++-10 sysstat

# install btop from release 
mkdir -p $USER_DIR/prog/btop
pushd $USER_DIR/prog/btop
wget -c https://github.com/aristocratos/btop/releases/download/v1.2.6/btop-x86_64-linux-musl.tbz
7za x btop-x86_64-linux-musl.tbz
7za x btop-x86_64-linux-musl.tar 
rm btop-x86_64-linux-musl.tbz
rm btop-x86_64-linux-musl.tar 
chmod +x install.sh 
./install.sh
popd


pushd $USER_DIR/prog/ 
curl -sS https://webinstall.dev/zoxide | bash
popd


# apt install fzf
# install fzf with git :
pushd $USER_DIR/
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$USER_DIR/.fzf/install
popd


===
pushd $USER_DIR/prog/
# fsearch filesystem indexing and search
# snap install qalculate vlc shutter fsearch
===

# nvidia CUDA along with the drivers
# 
# wget -c https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local

# apt install zoxide
# after this, one needs to add "eval "$(zoxide init bash)"" to .bashrc



pushd $USER_DIR/prog/
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
wget -c https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh
chmod +x Miniconda3-py39_4.11.0-Linux-x86_64.sh
./Miniconda3-py39_4.11.0-Linux-x86_64.sh -b -u
/root/miniconda3/bin/conda init
conda init
conda config --add channels conda-forge
# conda create -n jupyter
# conda activate jupyter
# update: just use the default environment, this is a throwaway machine anyway
conda install -y mamba
alias mambao="mamba install --use-index-cache -y --channel conda-forge"
python -m pip install -U git+https://github.com/jerzydziewierz/mict.git#egg=mict
mambao jupyter ipython plotly numpy pandas cryptography jax python-kaleido tqdm watermark pymc3
python -m pip install kaleido
popd

