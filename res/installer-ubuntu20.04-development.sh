
#!/bin/bash

# for Ubuntu 20.04

source environments-for-development.sh

sudo apt update; \
  sudo apt install -y locales-all git curl

## install Postgresql
sudo apt update; \
  sudo apt install -y postgresql postgresql-contrib
sudo useradd -M -p $POSTGRES_PASSWORD $POSTGRES_USER
echo "create user $POSTGRES_USER with password '$POSTGRES_PASSWORD';" | sudo -u postgres psql
sudo -u postgres createdb $POSTGRES_DB --owner $POSTGRES_USER
PGHBA=$(echo "SHOW hba_file;" | sudo -u postgres psql | head -n 3 | tail -n 1)
cat <<EOM | sudo patch $PGHBA -
94c94
< local   all             all                                     peer
---
> local   all             all                                     md5
EOM
sudo service postgresql stop; sudo service postgresql start

## install Hugin
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update; \
  sudo apt install -y apt-transport-https && \
  sudo apt update && \
  sudo apt install -y dotnet-sdk-5.0
sudo apt update; \
  sudo apt install -y npm gnupg binutils debootstrap
dotnet tool install --global dotnet-ef --version 5.0.5

git clone https://github.com/kjmtks/hugin-lms.git
cd hugin-lms/Hugin
npm install
dotnet restore
dotnet publish "Hugin.csproj" -c Release -o out
ln -s "$PWD/node_modules" "$PWD/out/node_modules"

mkdir -p $APP_DATA_PATH
mkdir -p $PATH_TO_PROTECTION_KEY

PATH="$PATH:~/.dotnet/tools/" dotnet ef database update
