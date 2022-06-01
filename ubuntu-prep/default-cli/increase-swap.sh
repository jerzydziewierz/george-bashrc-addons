# === increase swap 
# create empty file
echo "reserving by writing to /swapfile..."
dd if=/dev/zero of=/swapfile bs=1G count=16
# bake the swap file
echo "baking /swapfile ..."
chmod 0600 /swapfile
mkswap /swapfile
# Add this line to /etc/fstab
echo "activating..."
echo "/swapfile swap swap sw 0 0" >> /etc/fstab
# change premissions

# activate 
swapon /swapfile
# verify
cat /proc/swaps
