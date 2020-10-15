#!/bin/bash

set -euxo pipefail

: "$SHRINE_DB_TYPE"
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

if [ ! -f /opt/shrine/shrine.keystore ]; then
  keytool -genkeypair -keysize 2048 -alias shrine-example.harvard.edu \
          -dname "CN=shrine-example.harvard.edu, OU=SHRINE Example, O=SHRINE Network, L=Boston, S=MA, C=US" \
          -keyalg RSA -keypass "$SHRINE_KEYSTORE_PASSWORD" -storepass "$SHRINE_KEYSTORE_PASSWORD" \
          -keystore /opt/shrine/shrine.keystore -storetype pkcs12 -validity 7300
fi

template.py

exec /usr/local/tomcat/bin/catalina.sh run
