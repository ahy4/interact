# interact

## 概要

任意のコマンドを対話モード化するためのコマンド

例えば、このタブではgitしかいじんないんだから打つのめんどいだけだし省略したい、などの問題を解決する

需要はほとんどないとおもう

## 使い方

### インストール

このレポジトリの`interact`を`/usr/local/bin`にぶちこんで、

`chmod +x /usr/local/bin/interact`

する

### 実行例

```sh
$ interact git
[ git ] >> status
On branch develop
Your branch is up-to-date with 'origin/develop'.
Changes not staged for commit:
...
[ git ] >> log
commit 7cc1fefa526d5245d5fb3914e6c40a709671e4fc
Merge: 2f2aa4d2b 23f8e39ec
Author: LimeStreem <LimeStreem@gmail.com>
Date:   Fri Apr 1 01:57:27 2016 +0900
...
```

## たのむ

類似なコマンドがあるなら誰か教えてくれ・・・
