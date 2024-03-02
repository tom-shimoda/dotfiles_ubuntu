#!/usr/bin/zsh
set -e

readonly USE_TMUX=true

# Change default shell to zsh
echo "### Change default shell to zsh"
chsh -s /usr/bin/zsh

# apt update
echo "### sudo apt update"
sudo apt update

# create folder
echo "### create folder"
mkdir -p ~/Downloads
mkdir -p ~/.local/bin
mkdir -p ~/Documents/Github
mkdir -p ~/.config/nvim

# wget
echo "### wget"
sudo apt install -y --no-install-recommends wget
# curl
echo "### curl"
sudo apt install -y --no-install-recommends curl
sudo apt install -y --no-install-recommends ca-certificates
sudo update-ca-certificates
# dpkg
echo "### dpkg"
sudo apt install -y --no-install-recommends dpkg
# git
echo "### git"
sudo apt install -y --no-install-recommends git

# dotfiles
echo "### dotfiles"
cd ~/Documents/Github
if [ ! -e dotfiles_ubuntu ]; then
    git clone https://github.com/tom-shimoda/dotfiles_ubuntu
else
    echo "dotfiles_ubuntu exists."
fi
cd dotfiles_ubuntu
./deploy-dotfiles
cd /

# nvim
echo "### nvim"
cd ~/Downloads
if [ ! -e nvim-linux64.tar.gz ]; then
    wget --no-check-certificate https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
else
    echo "nvim-linux64.tar.gz is exists."
fi
mv nvim-linux64.tar.gz ~/.local/bin
cd ~/.local/bin
tar xzvf nvim-linux64.tar.gz
rm -rf nvim-linux64.tar.gz
# create symbolic link
ln -s ./nvim-linux64/bin/nvim ./nvim
cd /

# nvm
echo "### nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# pyenv (for Ubuntu/Debian/Mint : https://github.com/pyenv/pyenv/wiki )
# echo "### pyenv"
# sudo apt install -y --no-install-recommends build-essential libssl-dev zlib1g-dev \
# libbz2-dev libreadline-dev libsqlite3-dev \
# libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
# curl https://pyenv.run | bash

# python
echo "### pthon"
sudo apt install -y --no-install-recommends python3
sudo apt install -y --no-install-recommends python3-pip

# zinit
echo "### zinit"
export NO_INPUT=1
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# fzf
echo "### fzf"
cd ~/Documents/Github
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
cd /

# ripgrep
echo "### ripgrep"
sudo apt install -y --no-install-recommends ripgrep

# bat
echo "### bat"
sudo apt install -y --no-install-recommends bat
ln -s /usr/bin/batcat ~/.local/bin/bat

# delta
echo "### delta"
cd ~/Downloads
if [ ! -e git-delta-musl_0.15.1_amd64.deb ]; then
    wget --no-check-certificate https://github.com/dandavison/delta/releases/download/0.15.1/git-delta-musl_0.15.1_amd64.deb
fi
sudo dpkg -i git-delta-musl_0.15.1_amd64.deb
cd /

# tmux
if "${USE_TMUX}"; then
    echo "### tmux"
    sudo apt install -y --no-install-recommends tmux
    cd ~/Documents/Github
    if [ ! -e ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        echo "~/.tmux/plugins/tpm is exists."
    fi

    # tmux-powerline
    echo "### tmux-powerline"
    if [ ! -e tmux-powerline ]; then
        git clone https://github.com/tom-shimoda/tmux-powerline
    else
        echo "tmux-powerline exists."
    fi
    cd /
fi

# font
# cd ~/Downloads
# sudo apt install -y --no-install-recommends unzip
# sudo apt install -y --no-install-recommends fontconfig
# wget --no-check-certificate https://github.com/adam7/delugia-code/releases/download/v2111.01.2/delugia-book.zip
# unzip delugia-book.zip
# cp -R delugia-book /usr/share/fonts

# apply dotfiles
echo ""
echo "### Installed successfuly."
echo "Run this command."
echo "> source ~/.zshrc"
echo "> zsh ~/setup.zsh"
