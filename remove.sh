path=$1
if [[ -d $path ]]; then
    rm -rf $path
fi
# ssh-keygen -t ed25519 -b 4096 -C "nguyenphuctrungkien@gmail.com" -f key_mac_m1_ks