#!/usr/bin/zsh
set -e

sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release


# Docker の公式 GPG 鍵を追加
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 安定版（stable）リポジトリをセットアップ
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker Engine のインストール
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

