#!/bin/bash

#####
# 以下を実行してください。
# ただしmacだけ対応してます
# curl -sL https://raw.githubusercontent.com/ahyahya/interact/develop/install.sh | bash
#####

cd /usr/local/bin

curl -o _interact https://raw.githubusercontent.com/ahyahya/interact/develop/_interact
curl -o interact https://raw.githubusercontent.com/ahyahya/interact/develop/interact

chmod +x _interact
chmod +x interact
