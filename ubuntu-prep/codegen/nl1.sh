# source .venv/bin/activate
# python3 -m jaxformer.hf.sample --device=cpu --model codegen-16B-nl --max-length=64 --rng-seed=40 --p=0.95 --t=0.20 --context "
#python3 -m jaxformer.hf.sample --device=cpu --model codegen-350M-nl --max-length=128 --rng-seed=40 --p=0.60 --t=0.20 --context "
python3 -m jaxformer.hf.sample --device=cpu --model codegen-6B-nl --max-length=128 --rng-seed=40 --p=0.60 --t=0.20 --context "
Aragorn and Legolas continue their adventure in the forest. They see"
 
