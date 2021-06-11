source environments-for-production.sh

cd hugin-lms
git fetch origin main
git reset --hard origin/main

cd Hugin
rm -rf out
dotnet restore
dotnet publish "Hugin.csproj" -c Release -o out
ln -s "$PWD/node_modules" "$PWD/out/node_modules"
PATH="$PATH:~/.dotnet/tools/" dotnet ef database update
PIDS=$(ps -alx | grep Hugin.dll | grep -v "grep" | awk '{ print $3 }')
for PID in "$PIDS"
do
  sudo kill -9 $PID
done
PATH="$PATH:~/.dotnet/tools/" dotnet ef database update
npm install

cd out
sudo -E nohup dotnet Hugin.dll > /dev/null 2>&1 &
