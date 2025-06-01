if [[ $1 = "--usage" ]]; then
  echo "usage:"
  echo "   $0 <drive> <host>"
  exit
fi

DISK="$1"

sudo umount -A -R /mnt
sudo sgdisk -Z ${DISK}
sudo sgdisk -a 2048 -o ${DISK}

sudo sgdisk -n 1::+500M --typecode=1:ef00 --change-name=1:"BOOT" ${DISK}
sudo sgdisk -n 2::-0 --typecode=2:8300 --change-name=2:"ROOT" ${DISK}
sudo partprobe ${DISK}

sudo mkfs.fat -F32 -n "BOOT" ${DISK}1
sudo mkfs.ext4 -F -L "ROOT" ${DISK}2

sudo mount ${DISK}2 /mnt
sudo mount --mkdir ${DISK}1 /mnt/boot

sudo nixos-generate-config --root /mnt

cp /mnt/etc/nixos/hardware-configuration.nix .
git add .

sudo cp -r ./* /mnt/etc/nixos/
cd /mnt/etc/nixos || exit

export NIX_CONFIG="experimental-features = nix-command flakes"
sudo sudo nixos-install --flake .#"$2" --root /mnt
