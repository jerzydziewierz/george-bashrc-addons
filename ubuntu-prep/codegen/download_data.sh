# download the model parameters
# codegen-350M-nl,multi,mono
# rm -r checkpoints/codegen-350M*
wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-350M-nl.tar.gz && tar -xvf checkpoints/codegen-350M-nl.tar.gz -C checkpoints/
# wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-350M-multi.tar.gz && tar -xvf checkpoints/codegen-350M-multi.tar.gz -C checkpoints/
# wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-350M-mono.tar.gz && tar -xvf checkpoints/codegen-350M-mono.tar.gz -C checkpoints/
# codegen-2B-nl,multi,mono
# rm -r checkpoints/codegen-2B*
# wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-2B-nl.tar.gz && tar -xvf checkpoints/codegen-2B-nl.tar.gz -C checkpoints/
# wget -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-2B-multi.tar.gz && tar -xvf checkpoints/codegen-2B-multi.tar.gz -C checkpoints/
# wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-2B-mono.tar.gz && tar -xvf checkpoints/codegen-2B-mono.tar.gz -C checkpoints/
# codegen-6B-nl,multi,mono

# wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-6B-nl.tar.gz
# tar -xvf checkpoints/codegen-6B-nl.tar.gz -C checkpoints/
# wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-6B-multi.tar.gz
# tar -xvf checkpoints/codegen-6B-multi.tar.gz -C checkpoints/
# wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-6B-mono.tar.gz
# tar -xvf checkpoints/codegen-6B-mono.tar.gz -C checkpoints/

# codegen-16B-nl,multi,mono
# wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-16B-nl.tar.gz
# tar -xvf checkpoints/codegen-16B-nl.tar.gz -C checkpoints/

# wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-16B-multi.tar.gz && tar -xvf checkpoints/codegen-16B-multi.tar.gz -C checkpoints/

wget -c -P checkpoints https://storage.googleapis.com/sfr-codegen-research/checkpoints/codegen-16B-mono.tar.gz && tar -xvf checkpoints/codegen-16B-mono.tar.gz -C checkpoints/
