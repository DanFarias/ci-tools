#!/bin/bash

set -e

PROXY_CONF=/etc/nginx/conf.d/default.conf

if [ "$1" = "nginx" ]; then
  # Replace position holders in default.conf
  sed -i "s#{{SERVER_NAME}}#${SERVER_NAME}#g" ${PROXY_CONF}
  sed -i "s#{{CLIENT_MAX_BODY_SIZE}}#${CLIENT_MAX_BODY_SIZE}#g" ${PROXY_CONF}
  echo "====== ${PROXY_CONF} ======="
  cat "${PROXY_CONF}"
  echo "============================"

  SLEEP_TIME=5
  declare -a DEPENDENCIES=( "jenkins:8080/jenkins" "sonarqube:9000/sonar" "nexus:8081/nexus" "gitlab:10080/gitlab")
  for d in ${DEPENDENCIES[@]}; do
    echo "waiting for $d to be available";
    until curl --location --output /dev/null --silent --write-out "%{http_code}\\n" http://$d | grep "200\|404\|403\|401\|301\|302" &> /dev/null
    do
      echo "$d unavailable, sleeping for ${SLEEP_TIME}"
      sleep "${SLEEP_TIME}"
    done
    echo "$d ready"
  done
fi

exec "$@"