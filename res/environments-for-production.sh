export APP_URL="https://your-host-name"
export APP_SECRET_KEY="your-secret-key(need-32-characters)"
export ASPNETCORE_Kestrel__Certificates__Default__Path="path-to-your-pfx"
export ASPNETCORE_Kestrel__Certificates__Default__Password="password-for-pfx"
export POSTGRES_USER="your-db-user-for-hugin"
export POSTGRES_PASSWORD="your-db-user-password-for-hugin"

### for LDAP
# export LDAP_HOST="ldap.****.**"
# export LDAP_PORT="636"
# export LDAP_BASE="dc=***,dc=***,..."
# export LDAP_ID_ATTR="uid"
# export LDAP_MAIL_ATTR="mail"
# export LDAP_NAME_ATTR="displayName;lang-ja"
# export LDAP_ENGNAME_ATTR="displayName"

export APP_NAME=Hugin
export LANG=ja_JP.UTF-8
export TZ=Asia/Tokyo
export POSTGRES_DB=hugin-production
export APP_DATA_PATH="$HOME/hugin-app-data"
export APP_DESCRIPTION=""
export ASPNETCORE_ENVIRONMENT=Production
export ASPNETCORE_URLS="https://+:443"
export DB_CONNECTION_STR="Host=localhost; Database=$POSTGRES_DB; Port=5432; Username=$POSTGRES_USER; Password=$POSTGRES_PASSWORD"
export PATH_TO_PROTECTION_KEY="$HOME/hugin-data-protection"

