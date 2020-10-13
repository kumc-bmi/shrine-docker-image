#!/bin/bash

set -euxo pipefail

exec /usr/local/tomcat/bin/catalina.sh run
