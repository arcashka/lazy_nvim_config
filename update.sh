curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract

# Check if /squashfs-root exists before attempting to remove it
if [ -d "/squashfs-root" ]; then
    sudo rm -r /squashfs-root
fi

sudo mv squashfs-root /
sudo rm /usr/bin/nvim 2> /dev/null # Suppresses the error if the file doesn't exist
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

