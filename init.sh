#!/bin/bash

systemctl start ntpd && systemctl enable ntpd

set -euxo pipefail

: "$TZ"
: "$SHRINE_DB_TYPE"
: "$SHRINE_HIVE_PASSWORD"
: "$SHRINE_KEYSTORE_PATH"
: "$SHRINE_KEYSTORE_PASSWORD"
: "$SHRINE_JDBC_PATH"
: "$SHRINE_PROBLEMDB_USER"
: "$SHRINE_PROBLEMDB_PASS"
: "$SHRINE_PROBLEMDB_DRIVER"
: "$SHRINE_PROBLEMDB_URL"
: "$SHRINE_SHRINEDB_USER"
: "$SHRINE_SHRINEDB_PASS"
: "$SHRINE_SHRINEDB_DRIVER"
: "$SHRINE_SHRINEDB_URL"
: "$SHRINE_ADAPTERAUDITDB_USER"
: "$SHRINE_ADAPTERAUDITDB_PASS"
: "$SHRINE_ADAPTERAUDITDB_DRIVER"
: "$SHRINE_ADAPTERAUDITDB_URL"
: "$SHRINE_QEPAUDITDB_USER"
: "$SHRINE_QEPAUDITDB_PASS"
: "$SHRINE_QEPAUDITDB_DRIVER"
: "$SHRINE_QEPAUDITDB_URL"
: "$SHRINE_STEWARDDB_USER"
: "$SHRINE_STEWARDDB_PASS"
: "$SHRINE_STEWARDDB_DRIVER"
: "$SHRINE_STEWARDDB_URL"

keytool -genkeypair -keysize 2048 -alias enact.kumc.edu -dname "CN=enact.harvard.edu, OU=Research Administration and Research Informatics, O=Universityof Kansas Medical Center, L=Kansas City, S=KS, C=US" -keyalg RSA -keypass $SHRINE_KEYSTORE_PASSWORD -storepass $SHRINE_KEYSTORE_PASSWORD -keystore shrine.keystore -storetype pkcs12 -validity 7300

if grep -E "^http|^ftp" <<< "$SHRINE_KEYSTORE_PATH" ; then
  wget "$SHRINE_KEYSTORE_PATH" -O /opt/shrine/shrine.keystore
elif [ "$SHRINE_KEYSTORE_PATH" == "/opt/shrine/shrine.keystore" ] ; then
  true
else
  mv "$SHRINE_KEYSTORE_PATH" /opt/shrine/shrine.keystore
fi

if grep -E "^http|^ftp" <<< "$SHRINE_JDBC_PATH" ; then
  wget "$SHRINE_JDBC_PATH" -O /usr/local/tomcat/lib/jdbc.jar
else
  mv "$SHRINE_JDBC_PATH" /usr/local/tomcat/lib/
fi

# Setting up the flags and env variables for tomcat
echo 'export CATALINA_OPTS="$CATALINA_OPTS -server -Xms1024m -Xmx3072m -Duser.timezone=America/New_York"' >> /usr/local/tomcat/bin/setenv.sh
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto' >> /usr/local/tomcat/bin/setenv.sh
echo 'export JRE_HOME=$JAVA_HOME' >> /usr/local/tomcat/bin/setenv.sh

configure_templates.py
exec /usr/local/tomcat/bin/catalina.sh run
