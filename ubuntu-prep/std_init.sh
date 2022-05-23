# startups
conda install -y mamba
alias mambao="mamba install --use-index-cache -y --channel conda-forge"
# essentials
python -m pip install -U git+https://github.com/jerzydziewierz/mict.git#egg=mict
mambao jupyter ipython plotly numpy pandas cryptography jax python-kaleido \
  tqdm watermark pymc3 redis-py
python -m pip install kaleido chevron

# ML/RL
mambao optuna hiplot neptune-client neptune-optuna

# Redis for optuna and other stuff (inter-process and inter-node communication database)
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
sudo apt-get update
sudo apt-get install redis

