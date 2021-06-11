# Hugin

任意の言語のプログラミング演習をウェブブラウザで実施できる LMS である [hugin-lms](https://github.com/kjmtks/hugin-lms) の解説ページです．
本システムはプログラミング演習のほか，自由記述形，ファイル提出，フォーム入力の課題を課すこともできます．

コンテンツはテキスト(Markdown or HTML + [Scriban](https://github.com/scriban/scriban))で記述します，このシステム自体がGitのリモートリポジトリとしても振る舞い， 
GitHubのようにGitのコマンドでコンテンツの入手・更新ができます． また，ウェブからもコンテンツの編集が可能です．

そのほか，以下の機能を有しています:

* 単体テストによる課題の自動チェック
* 提出課題への手動フィードバック，最終成績のCSV出力
* 任意のプログラム実行環境の構築
* 学生の学習行動の可視化，オンライン状態の監視，全行動の記録，
* LDAP認証の利用（LDAPを使用しない認証との併用も可）
* スタイラスペンによるページへの書き込み
* 講義コンテンツ，プログラム実行環境(サンドボックス)，課題(アクティビティ)のひな形をウェブからインポート


## デモサイト

[https://hugin-lms.net/](https://hugin-lms.net/)

デモサイトのユーザーアカウントとパスワード:

アカウント | パスワード
----------|-----------
test001   | password
test002   | password
test003   | password

## ドキュメント

* [コンテンツの記述について](https://kjmtks.github.io/hugin-page/describe-contents)

## 試用方法

自身の環境で動作を確認する方法を説明します．

以下に環境毎の操作手順を示します．
インストールおよび起動完了後にデモを動かすための手順は [YouTube](https://www.youtube.com/watch?v=Yvm4sSdc58M) で説明しています．

初期ユーザーのアカウントとパスワード:

アカウント | パスワード
----------|-----------
admin     | password
test001   | password
test002   | password
test003   | password

### Windows (WSL2 + Docker Desktop)

[WSL2](https://docs.microsoft.com/ja-jp/windows/wsl/install-win10) + [Docker Desktop](https://docs.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-containers#install-docker-desktop) の準備が必要です．

#### ソースコードの入手と実行
```
git clone https://github.com/kjmtks/hugin-lms.git
cd Hugin
make local-up
```

make コマンド実行後，しばらくしてから http://localhost:8080 にブラウザでアクセスしてください． ただし，Internet Explorerは対応していません．

#### 終了
````
make local-down
````

### macOS (with Docker)

WSL2 + Docker Desktop の代わりに，[Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/) をインストールしていれば，上記 Windows と同じ手順で試用できます．

### Ubuntu 20.04 (without Docker)

`sudo` を実行できるユーザーで以下の手順に従い操作を行ってください．

#### 設定ファイルの入手
```
wget https://kjmtks.github.io/hugin-page/res/environments-for-development.sh
```

入手した `environments-for-development.sh` を適切に編集してください．
以下の環境変数は必ず自分の環境に合わせて記述してください:

```
# アプリケーションを公開するURL．ポート8080 を指定してください．末尾にスラッシュを書かないでください．
export APP_URL="http://your-host-name:8080"

# アプリケーションのシークレットキー．32文字以上必要です．
export APP_SECRET_KEY="your-secret-key(need-32-characters)" 

# データベースのユーザー名．まだ存在しないユーザー名にしてください． hugin でかまいません．
export POSTGRES_USER="your-db-user-for-hugin"

# 上記ユーザーのパスワード．
export POSTGRES_PASSWORD="your-db-user-password-for-hugin"
```

#### インストール
```
curl https://kjmtks.github.io/hugin-page/res/installer-ubuntu20.04-development.sh | /bin/bash -
```

#### 実行
```
source environments-for-development.sh
cd hugin-lms/Hugin/out/
sudo -E dotnet Hugin.dll
```

`Ctrl+C` で終了できます．

### Azure (without Docker)
無料枠でも利用できる Ubuntu 20.04 Server のインスタンス上で，上記 Ubuntu 20.04 と同じ手順で試用できます．

メモリは2~4GB, ストレージは標準のもので十分です．
8080番ポートの開放が必要です．

### VisualStudio (for developers)
開発者向けです．

Requirements:

* Visual Studio 2019
* Docker Desktop

```
git clone https://github.com/kjmtks/hugin-lms.git
cd Hugin/Hugin
npm install
```

Then, open Hugin.sln and run with docker-compose profile


## 実環境での実行

実環境(https)での実行手順について説明します．

ドメイン，サーバー証明書（および必要であれば中間証明書）が必要となります．


### Ubuntu 20.04 (without Docker)

最も推奨する方法です．

#### pfxファイルの生成

下記コマンドによりpfxファイルを生成します．
ただし，`your.key`, `your.crt`, `your-ca.cer` はそれぞれ 鍵ファイル, サーバー証明書, 中間証明書とします:
```
openssl pkcs12 -export -out server.pfx -inkey your.key -in your.crt -certfile your-ca.cer
```
中間証明書がない場合は代わりに下記コマンドを実行してください:
```
openssl pkcs12 -export -out server.pfx -inkey your.key -in your.crt
```

#### 設定ファイルの入手
```
wget https://kjmtks.github.io/hugin-page/res/environments-for-production.sh
```

入手した `environments-for-production.sh` を適切に編集してください．
以下の環境変数は必ず自分の環境に合わせて記述してください:

```
# アプリケーションを公開するURL．末尾にスラッシュを書かないでください．
export APP_URL="https://your-host-name"

# アプリケーションのシークレットキー．32文字以上必要です．
export APP_SECRET_KEY="your-secret-key(need-32-characters)" 

# データベースのユーザー名．まだ存在しないユーザー名にしてください． hugin でかまいません．
export POSTGRES_USER="your-db-user-for-hugin"

# 上記ユーザーのパスワード．
export POSTGRES_PASSWORD="your-db-user-password-for-hugin"

# 前節で作成した server.pfx へのパス
export ASPNETCORE_Kestrel__Certificates__Default__Path="path-to-your-pfx"

# server.pfx のパスワード
export ASPNETCORE_Kestrel__Certificates__Default__Password="password-for-pfx"
```

#### インストール
```
curl https://kjmtks.github.io/hugin-page/res/installer-ubuntu20.04-production.sh | /bin/bash -
```

#### 実行
```
source environments-for-production.sh
cd hugin-lms/Hugin/out/
sudo -E nohup dotnet Hugin.dll > /dev/null 2>&1 &
```

### macOS (with Docker Desktop on Mac)

[Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/) が必要です．

#### ソースコードの入手と設定
```
git clone https://github.com/kjmtks/hugin-lms.git
cd Hugin
```

自分の環境に合わせて `docker-compose.production.override.yml` ファイルを適切に編集してください．

#### 実行

```
make production-up
```

#### 終了
````
make production-down
````
