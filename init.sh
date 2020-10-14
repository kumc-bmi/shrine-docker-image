#!/bin/bash

set -euxo pipefail

: "$SHRINE_KEYSTORE_PASSWORD"

if [ ! -f /opt/shrine/shrine.keystore ]; then
  keytool -genkeypair -keysize 2048 -alias shrine-example.harvard.edu \
          -dname "CN=shrine-example.harvard.edu, OU=SHRINE Example, O=SHRINE Network, L=Boston, S=MA, C=US" \
          -keyalg RSA -keypass "$SHRINE_KEYSTORE_PASSWORD" -storepass "$SHRINE_KEYSTORE_PASSWORD" \
          -keystore /opt/shrine/shrine.keystore -storetype pkcs12 -validity 7300
fi

template.py

exec /usr/local/tomcat/bin/catalina.sh run
