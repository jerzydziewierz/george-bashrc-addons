# source .venv/bin/activate
python3 -m jaxformer.hf.sample --device=cpu --model codegen-6B-nl --max-length=128 --rng-seed=44 --p=0.90 --t=0.4 --context "$1"
