#!/bin/bash

#####
# 以下を実行するとインストールできます。
# macしか対応してません
# curl -sL https://raw.githubusercontent.com/ahyahya/interact/master/install.sh | bash
#####

brew install rlwrap

cd /usr/local/bin

curl -sL -o _interact https://raw.githubusercontent.com/ahyahya/interact/master/_interact
curl -sL -o interact https://raw.githubusercontent.com/ahyahya/interact/master/interact

chmod +x _interact
chmod +x interact
