#!/bin/sh
apt update -y
apt install nodejs -y ;apt install npm -y
apt install curl -y
npm install git -v
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | sh
source ~/.shrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install 14
mkdir /var/www ; cd /var/www
git clone https://github.com/johnmogi/bootcamp-app.git
cd bootcamp-app/
npm i
echo """
PORT=8080
HOST=0.0.0.0
NODE_ENV=development
HOST_URL=http://localhost:8080
COOKIE_ENCRYPT_PWD=superAwesomePasswordStringThatIsAtLeast32CharactersLong!

# Okta configuration
OKTA_ORG_URL="https://dev-96311573.okta.com"
OKTA_CLIENT_ID="0oa57uv2e4ZbMvc8b5d7"
OKTA_CLIENT_SECRET="-dS3ittft57jAzdyGrR1AmJhVD9qr2xapEJla7MF"

# Postgres configuration
PGHOST=10.0.0.4
PGUSERNAME=postgres
PGDATABASE=postgres
PGPASSWORD=p@ssw0rd42
PGPORT=5432
""" > .env
npm run initdb
npm i -g pm2
pm2 start npm --name start -- run start
env PATH=$PATH:/home/azureuser/.nvm/versions/node/v14.19.3/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u azureuser --hp /home/azureuser
systemctl start pm2-azureuser
pm2 save